using System;
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

        public IUnitOfWork Create(string name, IsolationLevel isolationLevel = IsolationLevel.ReadCommitted)
        {
            if (name == null)
            {
                throw new ArgumentNullException("name");
            }

            this.accessor.Context = name;
            return new UnitOfWork();
        }
    }
}