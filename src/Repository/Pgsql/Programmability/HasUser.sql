CREATE OR REPLACE FUNCTION membership.has_user
(
	email VARCHAR
)
RETURNS TABLE(id INTEGER)
AS $$
	SELECT
		id id
	FROM membership.user
	WHERE
		email = $1
	LIMIT 1
$$ LANGUAGE SQL;

GRANT EXECUTE ON FUNCTION membership.has_user(VARCHAR) TO "sample-ro";