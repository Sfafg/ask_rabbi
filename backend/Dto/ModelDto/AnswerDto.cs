using System;
using System.Collections.Generic;

namespace backend.Models;

public partial class AnswerDto
{
    public int Id { get; set; }

    public string Body { get; set; } = null!;

    public virtual UserSummaryDto? User { get; set; } = null!;
}
