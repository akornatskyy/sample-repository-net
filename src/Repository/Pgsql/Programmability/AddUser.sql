CREATE OR REPLACE FUNCTION membership.add_user
(
	email VARCHAR
)
RETURNS TABLE (Id INTEGER)
AS $$
	WITH x AS 
	(
		INSERT INTO membership.user
			(created_on, email)
		VALUES 
			(DEFAULT, LOWER($1))
		RETURNING
			id, created_on
	),
	a AS 
	(
		INSERT INTO membership.address
		(
			user_id, modified_on
		)
		SELECT
			id, created_on
		FROM x
	)
	INSERT INTO membership.person
	(
		user_id, modified_on
	)
	SELECT
		id, created_on
	FROM x
	RETURNING user_id;
$$ LANGUAGE SQL;

GRANT EXECUTE ON FUNCTION membership.add_user(VARCHAR) TO "sample-rw";