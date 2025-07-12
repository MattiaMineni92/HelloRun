using Microsoft.AspNetCore.Mvc;
using HelloRun.API.Data;
using HelloRun.API.Models;

namespace HelloRun.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AttivitaController : ControllerBase
    {
        private readonly AppDbContext _context;

        public AttivitaController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult GetAll() => Ok(_context.Attivita.ToList());

        [HttpPost]
        public IActionResult Add([FromBody] Attivita attivita)
        {
            _context.Attivita.Add(attivita);
            _context.SaveChanges();
            return Ok(attivita);
        }
    }
}
