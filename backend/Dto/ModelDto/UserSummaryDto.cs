using System;
using System.Collections.Generic;

namespace backend.Models;

public partial class UserSummaryDto
{
    public int Id { get; set; }

    public string Username { get; set; } = null!;

    public string Email { get; set; } = null!;
}
