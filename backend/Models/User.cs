using System.Collections.Generic;
namespace AskRabbiApi.Models;

public class User
{
    public int id { get; set; }
    public string username { get; set; } = null!;
    public string email { get; set; } = null!;
    public char type { get; set; } = 'u';
    public ICollection<Question> questions { get; set; } = new List<Question>();
    public ICollection<Answer> answers { get; set; } = new List<Answer>();
}
