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
[Route("answers")]
public class AnswersController : ControllerBase
{
    private readonly AskRabbiDbContext _context;
    private readonly IMapper _mapper;

    public AnswersController(AskRabbiDbContext context, IMapper mapper)
    {
        _context = context;
        _mapper = mapper;
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
    public async Task<ActionResult<Answer>> AddAnswer([FromBody] PostAnswerDto request)
    {
        var id = HttpContext.User.Identity as ClaimsIdentity;
        if (id == null)
            return Unauthorized();

        string? userId_ = id.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;

        if (string.IsNullOrEmpty(userId_))
            return Unauthorized();

        if (!int.TryParse(userId_, out int userId))
            return BadRequest(new { errors = new { user_id = "Invalid user id" } });

        var answer = _mapper.Map<Answer>(request);
        answer.UserId = userId;
        _context.Answers.Add(answer);
        await _context.SaveChangesAsync();

        return Ok(answer);
    }

    [Authorize(Roles = "r")]
    [HttpPut("{answerId}")]
    public async Task<ActionResult<Answer>> EditAnswer(
        int answerId,
        [FromBody] PostAnswerDto request
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
