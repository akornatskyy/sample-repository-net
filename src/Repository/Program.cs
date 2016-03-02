using Microsoft.Practices.Unity;

using Repository.Infrastructure;

namespace Repository
{
    public static class Program
    {
        public static void Main()
        {
            var c = UnityConfig.Register(UnityConfig.Mock);
            var facade = (Facade)c.Resolve(typeof(Facade));
            facade.DoSomething();
        }

        private class Facade
        {
            private readonly IUnitOfWorkProvider unitOfWorkProvider;

            public Facade(IUnitOfWorkProvider unitOfWorkProvider)
            {
                this.unitOfWorkProvider = unitOfWorkProvider;
            }

            public void DoSomething()
            {
                using (this.unitOfWorkProvider.Create("ro"))
                {
                }

                using (var unitOfWork = this.unitOfWorkProvider.Create("rw"))
                {
                    unitOfWork.Commit();
                }
            }
        }
    }
}