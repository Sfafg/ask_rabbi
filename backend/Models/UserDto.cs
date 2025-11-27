using System;
using System.Collections.Generic;

namespace backend.Models;

public partial class UserDto
{
    public string Username { get; set; } = null!;

    public string Email { get; set; } = null!;

    public char Type { get; set; }

    public virtual ICollection<Answer>? Answers { get; set; } = new List<Answer>();

    public virtual ICollection<Question>? Questions { get; set; } = new List<Question>();
}
