using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
namespace AskRabbiApi.Models;

[Table("answers")]
public class Answer
{
    [Column("id")]
    public int Id { get; set; }
    [Column("user_id")]
    public int UserId { get; set; }
    [Column("answer_id")]
    public int? AnswerId { get; set; }
    [Column("question_id")]
    public int? QuestionId { get; set; }
    [Column("body")]
    public string Body { get; set; } = null!;
    [Column("user")]
    public User User { get; set; } = null!;
    public Answer? ParentAnswer { get; set; }
    public ICollection<Answer> Replies { get; set; } = new List<Answer>();
    public Question? Question { get; set; }
}
