using System;
using System.Reflection;

using Microsoft.Practices.Unity;

using Repository.Infrastructure;
using Repository.Interface;

namespace Repository
{
    public static class UnityConfig
    {
        public const string Mock = "Mock";
        public const string Sql = "Sql";

        public static IUnityContainer Register(string strategy)
        {
            var mi = typeof(UnityConfig).GetMethod("Register" + strategy, BindingFlags.NonPublic | BindingFlags.Static);
            if (mi == null)
            {
                throw new ArgumentOutOfRangeException("strategy", strategy, null);
            }

            var c = new UnityContainer();
            UnityConfig.RegisterCommon(c);
            mi.Invoke(null, new object[] { c });
            return c;
        }

        private static void RegisterCommon(IUnityContainer c)
        {
            c.RegisterType<ContextAccessor>(new HierarchicalLifetimeManager());
        }

        private static void RegisterMock(IUnityContainer c)
        {
            c.RegisterType<IUnitOfWorkProvider, Mock.UnitOfWorkProvider>(new HierarchicalLifetimeManager());
            c.RegisterType<IMembershipRepository, Mock.MembershipRepository>(new HierarchicalLifetimeManager());
        }

        private static void RegisterSql(IUnityContainer c)
        {
            c.RegisterType<IUnitOfWorkProvider, Sql.Infrastructure.UnitOfWorkProvider>(new HierarchicalLifetimeManager());
            c.RegisterType<IMembershipRepository, Sql.MembershipRepository>(new HierarchicalLifetimeManager());
        }
    }
}