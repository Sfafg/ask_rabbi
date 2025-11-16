using backend.Data;
using backend.Models;
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
    public async Task<ActionResult<IEnumerable<Question>>> GetQuestions()
    {
        return await _context.Questions.ToListAsync();
    }

    [HttpGet("{id}")]
    public async Task<ActionResult<Question>> GetQuestion(int id)
    {
        var question = await _context.Questions.FindAsync(id);

        if (question == null)
            return NotFound();

        return question;
    }

    // [HttpPost]
    // public async Task<ActionResult<IEnumerable<Question>>> AddQuestion(int body)
    // {
    //     return await _context.users.ToListAsync();
    // }

    // [HttpPut("{id}")]
    // public async Task<ActionResult<IEnumerable<Question>>> UpdateQuestion()
    // {
    //     return await _context.users.ToListAsync();
    // }
}
