using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using AutoMapper;
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
    private readonly IMapper _mapper;

    public QuestionsController(AskRabbiDbContext context, IMapper mapper)
    {
        _context = context;
        _mapper = mapper;
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<QuestionDto>>> GetQuestions(
        [FromQuery] int offset = 0,
        int limit = 2147483647
    )
    {
        var questions = await _context
            .Questions.Skip(offset)
            .Take(limit)
            .Include(q => q.User)
            .Include(q => q.Answers)
                .ThenInclude(a => a.User)
            .Include(q => q.Answers)
                .ThenInclude(a => a.Answers)
            .ToListAsync();
        return Ok(_mapper.Map<List<QuestionDto>>(questions));
    }

    [HttpGet("query")]
    public async Task<ActionResult<IEnumerable<Question>>> GetQuestions([FromQuery] string phrase)
    {
        phrase = phrase.ToLower();
        var questions = await _context
            .Questions.FromSql($"SELECT * FROM quary_phrase({phrase})")
            .Include(q => q.User)
            .Include(q => q.Answers)
                .ThenInclude(a => a.User)
            .Include(q => q.Answers)
                .ThenInclude(a => a.Answers)
            .ToListAsync();
        return Ok(_mapper.Map<List<QuestionDto>>(questions));
    }

    [HttpGet("{id}")]
    public async Task<ActionResult<Question>> GetQuestion(int id)
    {
        var question = await _context
            .Questions.Where(q => q.Id == id)
            .Include(q => q.User)
            .Include(q => q.Answers)
                .ThenInclude(a => a.User)
            .Include(q => q.Answers)
                .ThenInclude(a => a.Answers)
            .FirstOrDefaultAsync();

        if (question == null)
            return NotFound();

        return Ok(_mapper.Map<QuestionDto>(question));
    }

    [Authorize(Roles = "u,r")]
    [HttpPost]
    public async Task<ActionResult<Question>> AddQuestion([FromBody] PostQuestionDto request)
    {
        var id = HttpContext.User.Identity as ClaimsIdentity;
        if (id == null)
            return Unauthorized();

        string? userId_ = id.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;

        if (string.IsNullOrEmpty(userId_))
            return Unauthorized();

        if (!int.TryParse(userId_, out int userId))
            return BadRequest(new { errors = new { user_id = "Invalid user id" } });

        var question = _mapper.Map<Question>(request);
        question.UserId = userId;
        _context.Questions.Add(question);
        await _context.SaveChangesAsync();

        return Ok(question);
    }

    [Authorize(Roles = "u,r")]
    [HttpPut("{questionId}")]
    public async Task<ActionResult<Question>> UpdateQuestion(
        int questionId,
        [FromBody] PostQuestionDto request
    )
    {
        var id = HttpContext.User.Identity as ClaimsIdentity;
        if (id == null)
            return Unauthorized();

        string? userId_ = id.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;

        if (string.IsNullOrEmpty(userId_))
            return Unauthorized();

        if (!int.TryParse(userId_, out int userId))
            return BadRequest(new { errors = new { user_id = "Invalid user id" } });

        var question = await _context.Questions.FirstOrDefaultAsync(q => q.Id == questionId);

        if (question == null)
            return BadRequest(new { errors = new { question = "Question does not exist" } });

        if (question.UserId != userId)
            return Unauthorized();

        question.Body = request.Body;
        await _context.SaveChangesAsync();

        return Ok(question);
    }
}
