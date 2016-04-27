using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

using Dapper;

namespace Repository.Sql.Infrastructure
{
    public sealed class DbContext
    {
        private readonly IDbConnection connection;
        private readonly IDbTransaction transaction;

        public DbContext(IDbConnection connection, IDbTransaction transaction)
        {
            this.connection = connection;
            this.transaction = transaction;
        }

        public async Task<T> SpScalarAsync<T>(string name, object param = null)
        {
            var r = await this.connection.QueryAsync<T>(name, param, this.transaction, commandType: CommandType.StoredProcedure);
            return r.SingleOrDefault();
        }

        public Task<IEnumerable<T>> SpAsync<T>(string name, object param = null)
        {
            return this.connection.QueryAsync<T>(name, param, this.transaction, commandType: CommandType.StoredProcedure);
        }
    }
}