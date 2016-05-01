CREATE SEQUENCE membership.user_sq START 1000;

CREATE TABLE membership.user (
	id INTEGER NOT NULL DEFAULT nextval('membership.user_sq'),
	created_on TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
	email VARCHAR(254) NOT NULL,
	is_locked BIT NOT NULL DEFAULT 0::BIT,
	CONSTRAINT user_pk PRIMARY KEY 
	(
		Id
	)
);


CREATE UNIQUE INDEX ix_email ON membership.user
(
	email ASC
);