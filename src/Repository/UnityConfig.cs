using System;

using Microsoft.Practices.Unity;

using Repository.Infrastructure;

namespace Repository
{
    public static class UnityConfig
    {
        public const string Mock = "Mock";

        public static IUnityContainer Register(string strategy)
        {
            var mi = typeof(UnityConfig).GetMethod("Register" + strategy);
            if (mi == null)
            {
                throw new ArgumentOutOfRangeException("strategy");
            }

            var c = new UnityContainer();
            mi.Invoke(null, new object[] { c });
            return c;
        }

        public static void RegisterMock(IUnityContainer c)
        {
            c.RegisterType<ContextAccessor>(new HierarchicalLifetimeManager());
            c.RegisterType<IUnitOfWorkProvider, Mock.UnitOfWorkProvider>(new HierarchicalLifetimeManager());
        }
    }
}