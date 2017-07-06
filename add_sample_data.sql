INSERT INTO users VALUES
(DEFAULT,'arminkz','Armin','Kazemi','1997-3-13','1a79a4d60de6718e8e5b326e338ae533',NULL,0),
(DEFAULT,'reeezaaa','Reza','Ahmadi','1997-5-24','1a79a4d60de6718e8e5b326e338ae533',NULL,0);

-- TEST TRIGGER (UPDATE USER)
UPDATE users
SET fristName = 'Rezaya'
WHERE userID = 2;