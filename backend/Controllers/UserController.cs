using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using AutoMapper;
using backend.Data;
using backend.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;

namespace AskRabbi.Controllers;

[ApiController]
[Route("users")]
public class UsersController : ControllerBase
{
    private readonly AskRabbiDbContext _context;
    private readonly IConfiguration _config;
    private readonly IMapper _mapper;

    public UsersController(IConfiguration config, AskRabbiDbContext context, IMapper mapper)
    {
        _config = config;
        _context = context;
        _mapper = mapper;
    }

    [HttpPost("register")]
    public async Task<ActionResult<User>> RegisterUser(
        [FromForm] RegisterDto request,
        IFormFile? certificate
    )
    {
        if (await _context.Users.FirstOrDefaultAsync(u => u.Email == request.Email) != null)
            return BadRequest(
                new { errors = new { email = "There already exists a user with this email." } }
            );

        if (await _context.Users.FirstOrDefaultAsync(u => u.Username == request.Username) != null)
            return BadRequest(new { errors = new { username = "Username already taken." } });

        string passwordHash = BCrypt.Net.BCrypt.HashPassword(request.Password);

        var type = (certificate == null) ? 'u' : 'r';

        var user = _mapper.Map<User>(request);
        user.Type = type;
        user.Password = passwordHash;
        _context.Users.Add(user);
        await _context.SaveChangesAsync();

        return Ok(
            new { message = "User registered successfully as " + (type == 'u' ? "User" : "Rabbi") }
        );
    }

    [HttpPost("login")]
    public async Task<ActionResult<User>> LoginUser([FromBody] LoginDto request)
    {
        var user = await _context.Users.FirstOrDefaultAsync(u => u.Username == request.Username);
        if (user == null || !BCrypt.Net.BCrypt.Verify(request.Password, user.Password))
            return Unauthorized(new { errors = new { credentials = "Invalid credentials" } });

        var tokenHandler = new JwtSecurityTokenHandler();
        var key = Encoding.UTF8.GetBytes(
            _config["JwtSettings:SecretKey"]
                ?? throw new Exception("JWT SecretKey is missing in appsettings.json")
        );

        var tokenDescriptor = new SecurityTokenDescriptor
        {
            Subject = new ClaimsIdentity(
                new Claim[]
                {
                    new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),
                    new Claim(ClaimTypes.Name, user.Username),
                    new Claim(ClaimTypes.Role, user.Type.ToString()),
                }
            ),
            Expires = DateTime.UtcNow.AddHours(1),
            SigningCredentials = new SigningCredentials(
                new SymmetricSecurityKey(key),
                SecurityAlgorithms.HmacSha256Signature
            ),
        };
        var token = tokenHandler.CreateToken(tokenDescriptor);
        var jwt = tokenHandler.WriteToken(token);

        return Ok(new { token = jwt });
    }
}
