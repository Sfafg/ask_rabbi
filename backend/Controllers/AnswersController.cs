using backend.Data;
using backend.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace AskRabbi.Controllers;

[ApiController]
[Route("answer")]
public class AnswersController : ControllerBase
{
    private readonly AskRabbiDbContext _context;

    public AnswersController(AskRabbiDbContext context)
    {
        _context = context;
    }

    // [HttpGet]
    // public async Task<ActionResult<IEnumerable<User>>> GetAnswers()
    // {
    //     return await _context.users.ToListAsync();
    // }

    // [HttpPut]
    // public async Task<ActionResult<IEnumerable<User>>> RegisterUser()
    // {
    //     return await _context.users.ToListAsync();
    // }

    // [HttpGet("login")]
    // public async Task<ActionResult<IEnumerable<User>>> LoginUser()
    // {
    //     return await _context.users.ToListAsync();
    // }

    // // TODO: Remove
    // [HttpGet("{id}")]
    // public async Task<ActionResult<User>> GetUser(int id)
    // {
    //     var user = await _context.users.FindAsync(id);

    //     if (user == null)
    //         return NotFound();

    //     return user;
    // }
}
