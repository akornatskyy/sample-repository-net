CREATE TABLE membership.address (
	user_id INTEGER NOT NULL,
	modified_on TIMESTAMP NOT NULL DEFAULT NOW(),
	address_line_1 VARCHAR(150) NOT NULL DEFAULT '',
	address_line_2 VARCHAR(150) NOT NULL DEFAULT '',
	address_line_3 VARCHAR(150) NOT NULL DEFAULT '',
	address_line_4 VARCHAR(150) NOT NULL DEFAULT '',
	city VARCHAR(150) NOT NULL DEFAULT '',
	country VARCHAR(50) NOT NULL DEFAULT '',
	zipcode CHAR(10) NOT NULL DEFAULT '',

	CONSTRAINT address_pk PRIMARY KEY (user_id),
	CONSTRAINT address_user_fk FOREIGN KEY (user_id)
	REFERENCES membership.user (id)
);