using System.Data;

namespace Repository.Sql
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
    }
}