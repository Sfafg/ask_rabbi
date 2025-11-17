using System.ComponentModel.DataAnnotations;

namespace backend.Models;

public class AnswerDto
{
    public int? AnswerId { get; set; }
    public int? QuestionId { get; set; }

    [MinLength(10, ErrorMessage = "Answer must be at least 10 characters")]
    public string Body { get; set; } = null!;
}
