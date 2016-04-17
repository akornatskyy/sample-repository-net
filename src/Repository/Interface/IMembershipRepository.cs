using System.Threading.Tasks;

namespace Repository.Interface
{
    public interface IMembershipRepository
    {
        Task<int> HasUser(string email);

        Task<int> AddUser(string email);
    }
}