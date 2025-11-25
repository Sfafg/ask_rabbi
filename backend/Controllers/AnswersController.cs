using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using backend.Data;
using backend.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace AskRabbi.Controllers;

[ApiController]
[Route("answers")]
public class AnswersController : ControllerBase
{
    private readonly AskRabbiDbContext _context;

    public AnswersController(AskRabbiDbContext context)
    {
        _context = context;
    }

    [HttpGet("question/{id}")]
    public async Task<ActionResult<IEnumerable<Answer>>> GetAnswersByQuestion(int id)
    {
        return await _context.Answers.Where(a => a.QuestionId == id).ToListAsync();
    }

    [HttpGet("answer/{id}")]
    public async Task<ActionResult<IEnumerable<Answer>>> GetAnswersByAnswer(int id)
    {
        return await _context.Answers.Where(a => a.AnswerId == id).ToListAsync();
    }

    [Authorize(Roles = "r")]
    [HttpPost]
    public async Task<ActionResult<Answer>> AddAnswer([FromBody] AnswerDto request)
    {
        var id = HttpContext.User.Identity as ClaimsIdentity;
        if (id == null)
            return Unauthorized();

        string? userId_ = id.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;

        if (string.IsNullOrEmpty(userId_))
            return Unauthorized();

        if (!int.TryParse(userId_, out int userId))
            return BadRequest(new { errors = new { user_id = "Invalid user id" } });

        var answer = new Answer
        {
            UserId = userId,
            AnswerId = request.AnswerId,
            QuestionId = request.QuestionId,
            Body = request.Body,
        };
        _context.Answers.Add(answer);
        await _context.SaveChangesAsync();

        return Ok(answer);
    }

    [Authorize(Roles = "r")]
    [HttpPut("{answerId}")]
    public async Task<ActionResult<Answer>> EditAnswer(int answerId, [FromBody] AnswerDto request)
    {
        var id = HttpContext.User.Identity as ClaimsIdentity;
        if (id == null)
            return Unauthorized();

        string? userId_ = id.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;

        if (string.IsNullOrEmpty(userId_))
            return Unauthorized();

        if (!int.TryParse(userId_, out int userId))
            return BadRequest(new { errors = new { user_id = "Invalid user id" } });

        var answer = await _context.Answers.FirstOrDefaultAsync(a => a.Id == answerId);

        if (answer == null)
            return BadRequest(new { errors = new { question = "Answer does not exist" } });

        if (answer.UserId != userId)
            return Unauthorized();

        answer.Body = request.Body;
        await _context.SaveChangesAsync();

        return Ok(answer);
    }
}
