﻿using Repository.Infrastructure;

namespace Repository.Mock
{
    public sealed class UnitOfWork : AbstractUnitOfWork
    {
        public override void Commit()
        {
        }

        protected override void Dispose(bool disposing)
        {
        }
    }
}