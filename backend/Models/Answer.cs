using System.Collections.Generic;
namespace AskRabbiApi.Models;

public class Answer
{
    public int Id { get; set; }
    public int UserId { get; set; }
    public int? AnswerId { get; set; }
    public int? QuestionId { get; set; }
    public string Body { get; set; } = null!;
    public User User { get; set; } = null!;
    public Answer? ParentAnswer { get; set; }
    public ICollection<Answer> Replies { get; set; } = new List<Answer>();
    public Question? Question { get; set; }
}
