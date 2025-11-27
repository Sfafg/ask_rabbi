using System;
using System.Collections.Generic;

namespace backend.Models;

public partial class QuestionResponseDto
{
    public string Body { get; set; } = null!;

    public virtual UserDto User { get; set; } = null!;

    public virtual ICollection<Answer> Answers { get; set; } = new List<Answer>();
}
