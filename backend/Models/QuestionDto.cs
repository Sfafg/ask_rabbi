using System.ComponentModel.DataAnnotations;

namespace backend.Models;

public class QuestionDto
{
    [Required(ErrorMessage = "Username is required")]
    [StringLength(
        1024,
        MinimumLength = 3,
        ErrorMessage = "Username must be between 3 and 1024 characters"
    )]
    public string Body { get; set; } = "";
}
