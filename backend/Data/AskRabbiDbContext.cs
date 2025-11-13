using Microsoft.EntityFrameworkCore;
namespace AskRabbiApi.Models;

public class AskRabbiContext : DbContext
{
    public AskRabbiContext(DbContextOptions<AskRabbiContext> options)
        : base(options)
    {
    }

    public DbSet<User> users { get; set; } = null!;
    public DbSet<Question> questions { get; set; } = null!;
    public DbSet<Answer> answers { get; set; } = null!;
}
