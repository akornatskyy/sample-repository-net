using System.Data;
using System.Threading.Tasks;

namespace Repository.Infrastructure.Data
{
    public interface IDbConnectionFactory
    {
        Task<IDbConnection> Create(string connectionString);
    }
}