using System.Data;

namespace Repository.Infrastructure
{
    public interface IUnitOfWorkProvider
    {
        IUnitOfWork Create(string name, IsolationLevel isolationLevel = IsolationLevel.ReadCommitted);
    }
}