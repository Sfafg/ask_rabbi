using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using backend.Data;
using backend.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace AskRabbi.Controllers;

[ApiController]
[Route("questions")]
public class QuestionsController : ControllerBase
{
    private readonly AskRabbiDbContext _context;

    public QuestionsController(AskRabbiDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<Question>>> GetQuestions(
        [FromQuery] int offset = -1,
        int limit = -1
    )
    {
        IEnumerable<Question> questions;
        if (offset == -1 || limit == -1)
            questions = await _context.Questions.ToListAsync();
        else
            questions = await _context.Questions.Skip(offset).Take(limit).ToListAsync();
        return Ok(questions);
    }

    [HttpGet("query")]
    public async Task<ActionResult<IEnumerable<Question>>> GetQuestions([FromQuery] string phrase)
    {
        phrase = phrase.ToLower();
        var questions = await _context
            .Questions.FromSql($"SELECT * FROM quary_phrase({phrase})")
            .ToListAsync();
        return Ok(questions);
    }

    [HttpGet("{id}")]
    public async Task<ActionResult<Question>> GetQuestion(int id)
    {
        var question = await _context.Questions.FindAsync(id);

        if (question == null)
            return NotFound();

        return Ok(question);
    }

    [Authorize(Roles = "u,r")]
    [HttpPost]
    public async Task<ActionResult<Question>> AddQuestion([FromBody] QuestionDto request)
    {
        var id = HttpContext.User.Identity as ClaimsIdentity;
        if (id == null)
            return Unauthorized();

        string? userId_ = id.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;

        if (string.IsNullOrEmpty(userId_))
            return Unauthorized();

        if (!int.TryParse(userId_, out int userId))
            return BadRequest("Invalid user id.");

        var question = new Question { UserId = userId, Body = request.Body };
        _context.Questions.Add(question);
        await _context.SaveChangesAsync();

        return Ok(question);
    }

    [Authorize(Roles = "u,r")]
    [HttpPut("{questionId}")]
    public async Task<ActionResult<Question>> UpdateQuestion(
        int questionId,
        [FromBody] QuestionDto request
    )
    {
        var id = HttpContext.User.Identity as ClaimsIdentity;
        if (id == null)
            return Unauthorized();

        string? userId_ = id.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;

        if (string.IsNullOrEmpty(userId_))
            return Unauthorized();

        if (!int.TryParse(userId_, out int userId))
            return BadRequest("Invalid user id.");

        var question = await _context.Questions.FirstOrDefaultAsync(q => q.Id == questionId);

        if (question == null)
            return BadRequest("Question does not exist.");

        if (question.UserId != userId)
            return Unauthorized();

        question.Body = request.Body;
        await _context.SaveChangesAsync();

        return Ok(question);
    }
}
