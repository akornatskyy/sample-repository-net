using System.Threading.Tasks;

using Repository.Interface;

namespace Repository.Mock
{
    public sealed class MembershipRepository : IMembershipRepository
    {
        public Task<int> HasUser(string email)
        {
            return Task.FromResult(1);
        }

        public Task<int> AddUser(string email)
        {
            return Task.FromResult(1);
        }
    }
}