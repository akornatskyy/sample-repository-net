using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Threading.Tasks;

using Repository.Infrastructure;

namespace Repository.Sql
{
    public sealed class UnitOfWorkProvider : IUnitOfWorkProvider
    {
        private readonly ContextAccessor accessor;

        public UnitOfWorkProvider(ContextAccessor accessor)
        {
            this.accessor = accessor;
        }

        public async Task<IUnitOfWork> Create(string name, IsolationLevel isolationLevel = IsolationLevel.ReadCommitted)
        {
            Debug.Assert(this.accessor.Context == null, "this.accessor.Context == null");
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings[name].ConnectionString);
            await connection.OpenAsync();
            return new UnitOfWork(connection, this.accessor, isolationLevel);
        }
    }
}