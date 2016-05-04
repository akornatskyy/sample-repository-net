CREATE SCHEMA membership;

-- ROLES

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_catalog.pg_user WHERE usename = 'sample-ro') THEN
        CREATE ROLE "sample-ro" LOGIN PASSWORD 'sample-ro';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_catalog.pg_user WHERE usename = 'sample-rw') THEN
        CREATE ROLE "sample-rw" LOGIN PASSWORD 'sample-rw';
    END IF;
END
$$;

-- ACCESS SCHEMA

REVOKE ALL     ON SCHEMA public FROM public;
GRANT  USAGE   ON SCHEMA public TO "sample-ro";
GRANT  USAGE   ON SCHEMA public TO "sample-rw";

REVOKE ALL     ON SCHEMA membership FROM public;
GRANT  USAGE   ON SCHEMA membership TO "sample-ro";
GRANT  USAGE   ON SCHEMA membership TO "sample-rw";

-- ACCESS TABLES

REVOKE ALL ON ALL TABLES IN SCHEMA public FROM public;
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM "sample-ro";
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM "sample-rw";

ALTER DEFAULT PRIVILEGES IN SCHEMA membership
    GRANT SELECT ON TABLES
    TO "sample-ro";

ALTER DEFAULT PRIVILEGES IN SCHEMA membership
    GRANT INSERT, SELECT, UPDATE, DELETE ON TABLES
    TO "sample-rw";

-- ACCESS SEQUENCES

ALTER DEFAULT PRIVILEGES IN SCHEMA membership
    GRANT USAGE ON SEQUENCES
    TO "sample-rw";