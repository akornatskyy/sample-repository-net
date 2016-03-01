using System;

namespace Repository.Infrastructure
{
    public interface IUnitOfWork : IDisposable
    {
        void Commit();
    }
}