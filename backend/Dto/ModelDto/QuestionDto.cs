using System;
using System.Collections.Generic;

namespace backend.Models;

public partial class QuestionDto
{
    public string Body { get; set; } = null!;

    public virtual UserSummaryDto? User { get; set; } = null!;

    public virtual ICollection<AnswerDto>? Answers { get; set; } = new List<AnswerDto>();
}
