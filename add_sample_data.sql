INSERT INTO users VALUES
(DEFAULT,'arminkz','Armin','Kazemi','1997-3-13','1a79a4d60de6718e8e5b326e338ae533',NULL,0),
(DEFAULT,'reeezaaa','Reza','Ahmadi','1997-5-24','1a79a4d60de6718e8e5b326e338ae533',NULL,0);

INSERT INTO categories VALUES
(1,'Computer'),
(2,'Food'),
(3,'Biology');

INSERT INTO posts VALUES
(DEFAULT,1,'DNA Mutation','Hello World',NULL,0,NULL,NULL,NULL),
(DEFAULT,2,'GGWP','Epic DB Software',NULL,0,NULL,NULL,NULL);

INSERT INTO post_tags VALUES
(1,3,0),
(2,1,0);

INSERT INTO replies VALUES
(DEFAULT,1,2,'DNA is the key!'),
(DEFAULT,2,1,'MongoDB is Better !');

-- TEST TRIGGER (UPDATE USER)
UPDATE users
SET fristName = 'Rezaya'
WHERE userID = 2;


UPDATE users
SET isDeleted = 1
WHERE userID = 2;