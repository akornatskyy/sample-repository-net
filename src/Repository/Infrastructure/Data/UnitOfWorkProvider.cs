using System.Configuration;
using System.Data;
using System.Diagnostics;
using System.Threading.Tasks;

namespace Repository.Infrastructure.Data
{
    public sealed class UnitOfWorkProvider : IUnitOfWorkProvider
    {
        private readonly IDbConnectionFactory connectionFactory;
        private readonly ContextAccessor accessor;

        public UnitOfWorkProvider(IDbConnectionFactory connectionFactory, ContextAccessor accessor)
        {
            this.connectionFactory = connectionFactory;
            this.accessor = accessor;
        }

        public async Task<IUnitOfWork> Create(string name, IsolationLevel isolationLevel = IsolationLevel.ReadCommitted)
        {
            Debug.Assert(this.accessor.Context == null, "this.accessor.Context == null");
            var connection = await this.connectionFactory.Create(ConfigurationManager.ConnectionStrings[name].ConnectionString);
            return new UnitOfWork(connection, this.accessor, isolationLevel);
        }
    }
}