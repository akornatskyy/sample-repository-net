using System.Configuration;
using System.Threading.Tasks;

using Microsoft.Practices.Unity;

using Repository.Infrastructure;
using Repository.Interface;

namespace Repository
{
    public static class Program
    {
        public static void Main()
        {
            UseCase("andriy.kornatskyy@live.com");
        }

        private static void UseCase(string email)
        {
            using (var c = UnityConfig.Register(ConfigurationManager.AppSettings["Repository.Strategy"]))
            {
                var facade = (Facade)c.Resolve(typeof(Facade));

                // Avoid concurrency for unit of work, underlying db connection
                // does not support MultipleActiveResultSets.
                // Task.WaitAll(facade.HasUser(email), facade.EnsureUser(email));
                Task.WaitAll(facade.HasUser(email));
                Task.WaitAll(facade.EnsureUser(email));
            }
        }

        private class Facade
        {
            private readonly IUnitOfWorkProvider unitOfWorkProvider;
            private readonly IMembershipRepository membershipRepository;

            public Facade(IUnitOfWorkProvider unitOfWorkProvider, IMembershipRepository membershipRepository)
            {
                this.unitOfWorkProvider = unitOfWorkProvider;
                this.membershipRepository = membershipRepository;
            }

            public async Task<bool> HasUser(string email)
            {
                int id;
                using (await this.unitOfWorkProvider.Create("ro"))
                {
                    id = await this.membershipRepository.HasUser(email);
                }

                return id > 0;
            }

            public async Task<int> EnsureUser(string email)
            {
                int id;
                using (var unitOfWork = await this.unitOfWorkProvider.Create("rw"))
                {
                    id = await this.membershipRepository.HasUser(email);
                    if (id > 0)
                    {
                        return id;
                    }

                    id = await this.membershipRepository.AddUser(email);
                    if (id <= 0)
                    {
                        return 0;
                    }

                    unitOfWork.Commit();
                }

                return id;
            }
        }
    }
}