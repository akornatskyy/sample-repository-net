CREATE SCHEMA membership;

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