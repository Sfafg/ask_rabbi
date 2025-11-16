using System;
using System.Collections.Generic;

namespace backend.Models;

public partial class Answer
{
    public int Id { get; set; }

    public int UserId { get; set; }

    public int? AnswerId { get; set; }

    public int? QuestionId { get; set; }

    public string Body { get; set; } = null!;

    public virtual Answer? AnswerNavigation { get; set; }

    public virtual Answer? InverseAnswerNavigation { get; set; }

    public virtual Question? Question { get; set; }

    public virtual User User { get; set; } = null!;
}
