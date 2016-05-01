CREATE TABLE membership.gender (
	id INTEGER NOT NULL,
	name VARCHAR(50) NOT NULL,
	CONSTRAINT gender_pk PRIMARY KEY 
	(
		id
	)
);

INSERT INTO membership.gender
SELECT 0, 'Unknown'
UNION ALL SELECT 1, 'Male'
UNION ALL SELECT 2, 'Female';