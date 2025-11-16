using System;
using System.Collections.Generic;

namespace backend.Models;

public partial class Question
{
    public int Id { get; set; }

    public int UserId { get; set; }

    public string Body { get; set; } = null!;

    public virtual ICollection<Answer> Answers { get; set; } = new List<Answer>();
}
