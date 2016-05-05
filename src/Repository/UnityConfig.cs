using Microsoft.Practices.Unity;
using Microsoft.Practices.Unity.Configuration;

using Repository.Infrastructure;

namespace Repository
{
    public static class UnityConfig
    {
        public static IUnityContainer Register(string strategy)
        {
            var c = new UnityContainer();
            c.RegisterType<ContextAccessor>(new HierarchicalLifetimeManager());
            return c.LoadConfiguration(strategy);
        }
    }
}