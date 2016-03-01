using System.Data;

namespace Repository.Infrastructure
{
    public interface IUnitOfWorkProvider
    {
        IUnitOfWork Create(string name = null, IsolationLevel isolationLevel = IsolationLevel.ReadCommitted);
    }
}