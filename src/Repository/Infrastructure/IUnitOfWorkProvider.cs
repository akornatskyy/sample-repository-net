using System.Data;
using System.Threading.Tasks;

namespace Repository.Infrastructure
{
    public interface IUnitOfWorkProvider
    {
        Task<IUnitOfWork> Create(string name, IsolationLevel isolationLevel = IsolationLevel.ReadCommitted);
    }
}