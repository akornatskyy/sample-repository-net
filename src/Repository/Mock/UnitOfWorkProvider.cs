using System.Data;

using Repository.Infrastructure;

namespace Repository.Mock
{
    public sealed class UnitOfWorkProvider : IUnitOfWorkProvider
    {
        private readonly ContextAccessor accessor;

        public UnitOfWorkProvider(ContextAccessor accessor)
        {
            this.accessor = accessor;
        }

        public IUnitOfWork Create(string name = null, IsolationLevel isolationLevel = IsolationLevel.ReadCommitted)
        {
            this.accessor.Context = name;
            return new UnitOfWork();
        }
    }
}