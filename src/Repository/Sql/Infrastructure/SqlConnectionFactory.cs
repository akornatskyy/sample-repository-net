using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;

using Repository.Infrastructure.Data;

namespace Repository.Sql.Infrastructure
{
    public sealed class SqlConnectionFactory : IDbConnectionFactory
    {
        public async Task<IDbConnection> Create(string connectionString)
        {
            var c = new SqlConnection(connectionString);
            await c.OpenAsync();
            return c;
        }
    }
}
