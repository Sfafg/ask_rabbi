using System.Collections.Generic;
namespace AskRabbiApi.Models;

public class Question
{
    public int Id { get; set; }
    public int UserId { get; set; }
    public string Body { get; set; } = null!;
    public User User { get; set; } = null!;
    public ICollection<Answer> Answers { get; set; } = new List<Answer>();
}
