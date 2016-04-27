using System.Diagnostics;
using System.Threading.Tasks;

using Repository.Infrastructure;
using Repository.Interface;
using Repository.Sql.Infrastructure;

namespace Repository.Sql
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
            return this.Context.SpScalarAsync<int>("Membership.HasUser", new { Email = email });
        }

        public Task<int> AddUser(string email)
        {
            return this.Context.SpScalarAsync<int>("Membership.AddUser", new { Email = email });
        }
    }
}