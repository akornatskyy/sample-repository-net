# Sample Repository

[![Build status](https://ci.appveyor.com/api/projects/status/n54jge3wdupaajop?svg=true)](https://ci.appveyor.com/project/akornatskyy/sample-repository-net)

A simple repository pattern for .NET.

## Setup

### Database

Create *sample* database. Add users *sample-ro* and *sample-rw*.

SQL Server:

	cd build
	DbUp.SqlServer.cmd

PostgreSQL:

	cd build
	DbUp.Postgresql.cmd

### Strategy

There are three available repository strategies: mock,
sql and pgsql. See option `Repository.Strategy` in  *app.settings* file.