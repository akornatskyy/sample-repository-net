using System.Diagnostics;
using System.Threading.Tasks;

using Repository.Infrastructure;
using Repository.Infrastructure.Data;
using Repository.Interface;

namespace Repository.Pgsql
{
    public sealed class MembershipRepository : IMembershipRepository
    {
        private readonly ContextAccessor accessor;

        public MembershipRepository(ContextAccessor accessor)
        {
            this.accessor = accessor;
        }

        private DbContext Context
        {
            get
            {
                var ctx = this.accessor.Context as DbContext;
                Debug.Assert(ctx != null, "ctx != null");
                return ctx;
            }
        }

        public Task<int> HasUser(string email)
        {
            return this.Context.SpFirstOrDefaultAsync<int>("membership.has_user", new { email });
        }

        public Task<int> AddUser(string email)
        {
            return this.Context.SpFirstOrDefaultAsync<int>("membership.add_user", new { email });
        }
    }
}