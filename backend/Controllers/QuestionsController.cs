using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using AskRabbiApi.Models;

namespace AskRabbi.Controllers;

[ApiController]
[Route("questions")]
public class QuestionsController : ControllerBase
{
    private readonly AskRabbiContext _context;

    public QuestionsController(AskRabbiContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<Question>>> GetQuestions()
    {
        return await _context.questions.ToListAsync();
    }

    [HttpGet("{id}")]
    public async Task<ActionResult<Question>> GetQuestion(int id)
    {
        var question = await _context.questions.FindAsync(id);

        if(question == null) 
            return NotFound();

        return question;
    }

    // [HttpPost]
    // public async Task<ActionResult<IEnumerable<Question>>> AddQuestion()
    // {
    //     return await _context.users.ToListAsync();
    // }

    // [HttpPut("{id}")]
    // public async Task<ActionResult<IEnumerable<Question>>> UpdateQuestion()
    // {
    //     return await _context.users.ToListAsync();
    // }
}
