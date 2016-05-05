using System.Data;

namespace Repository.Infrastructure.Data
{
    public sealed class UnitOfWork : AbstractUnitOfWork
    {
        private readonly IDbConnection connection;
        private readonly IDbTransaction transaction;
        private readonly ContextAccessor accessor;

        public UnitOfWork(IDbConnection connection, ContextAccessor accessor, IsolationLevel isolationLevel = IsolationLevel.ReadCommitted)
        {
            this.connection = connection;
            this.transaction = connection.BeginTransaction(isolationLevel);
            this.accessor = accessor;
            this.accessor.Context = new DbContext(connection, this.transaction);
        }

        public override void Commit()
        {
            this.transaction.Commit();
        }

        protected override void Dispose(bool disposing)
        {
            this.accessor.Context = null;
            this.transaction.Dispose();
            this.connection.Dispose();
        }
    }
}