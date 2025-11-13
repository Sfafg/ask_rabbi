using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using AskRabbiApi.Models;

namespace AskRabbi.Controllers;

[ApiController]
[Route("users")]
public class UsersController : ControllerBase
{
    private readonly AskRabbiContext _context;

    public UsersController(AskRabbiContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<User>>> GetUsers()
    {
        return await _context.users.ToListAsync();
    }

    [HttpGet("{id}")]
    public async Task<ActionResult<User>> GetUser(int id)
    {
        var user = await _context.users.FindAsync(id);

        if (user == null)
            return NotFound();

        return user;
    }
}
