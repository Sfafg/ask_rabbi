using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
namespace AskRabbiApi.Models;

[Table("users")]
public class User
{
    [Column("id")]
    public int Id { get; set; }
    [Column("username")]
    public string Username { get; set; } = null!;
    [Column("email")]
    public string Email { get; set; } = null!;
    [Column("type")]
    public char Type { get; set; } = 'u';
    public ICollection<Question> Questions { get; set; } = new List<Question>();
    public ICollectiOn<Answer> Answers { get; set; } = new List<Answer>();
}
