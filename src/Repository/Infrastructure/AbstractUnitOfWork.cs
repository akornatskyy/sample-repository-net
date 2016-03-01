using System;
using System.Diagnostics;

namespace Repository.Infrastructure
{
    public abstract class AbstractUnitOfWork : IUnitOfWork
    {
        ~AbstractUnitOfWork()
        {
            this.Dispose(false);
        }

        public abstract void Commit();

        [DebuggerStepThrough]
        public void Dispose()
        {
            this.Dispose(true);
            GC.SuppressFinalize(this);
        }

        protected abstract void Dispose(bool disposing);
    }
}