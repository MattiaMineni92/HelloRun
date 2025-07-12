using Microsoft.EntityFrameworkCore;
using HelloRun.API.Models;

namespace HelloRun.API.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options)
            : base(options) { }

        public DbSet<Attivita> Attivita => Set<Attivita>();
    }
}
