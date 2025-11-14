using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
namespace AskRabbiApi.Models;

[Table("questions")]
public class Question
{
    [Column("id")]
    public int Id { get; set; }
    [Column("user_id")]
    public int Userid { get; set; }
    [Column("body")]
    public string Body { get; set; } = null!;
    public User User { get; set; } = null!;
    public ICollection<Answer> Answers { get; set; } = new List<Answer>();
}

