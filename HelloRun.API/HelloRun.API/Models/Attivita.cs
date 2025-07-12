
namespace HelloRun.API.Models
{
    public class Attivita
    {
        public int Id { get; set; }
        public string Nome { get; set; }
        public double Km { get; set; }
        public DateTime Data { get; set; } = DateTime.UtcNow;
    }
}

