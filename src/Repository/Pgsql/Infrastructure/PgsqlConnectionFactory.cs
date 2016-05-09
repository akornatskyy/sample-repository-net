using System.Data;
using System.Threading.Tasks;

using Npgsql;

using Repository.Infrastructure.Data;

namespace Repository.Pgsql.Infrastructure
{
    public sealed class PgsqlConnectionFactory : IDbConnectionFactory
    {
        public async Task<IDbConnection> Create(string connectionString)
        {
            var c = new NpgsqlConnection(connectionString);
            await c.OpenAsync();
            return c;
        }
    }
}