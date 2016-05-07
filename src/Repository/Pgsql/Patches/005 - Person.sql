CREATE TABLE membership.person (
	user_id INTEGER NOT NULL,
	gender_id INTEGER NOT NULL DEFAULT 0,
	modified_on TIMESTAMP WITH TIME ZONE NOT NULL,
	firstname VARCHAR(150) NOT NULL DEFAULT '',
	lastname VARCHAR(150) NOT NULL DEFAULT '',
	date_of_birth DATE NULL,

	CONSTRAINT person_pk PRIMARY KEY (user_id),
	CONSTRAINT person_user_fk FOREIGN KEY (user_id)
	REFERENCES membership.user (id),
	CONSTRAINT person_gender_fk FOREIGN KEY (gender_id)
	REFERENCES membership.gender (id)
);