CREATE TABLE users (
    userID INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(10),
    fristName VARCHAR(10),
    lastName VARCHAR(10),
    dateOfBirth DATE,
    hashedPassword VARCHAR(40),
    profilePic BLOB,
    isDeleted TINYINT(1)
);

CREATE TABLE users_email (
    userID INT,
    email VARCHAR(20),
    PRIMARY KEY(userID,email)
);

ALTER TABLE users_email
ADD FOREIGN KEY (userID) REFERENCES users(userID);


CREATE TABLE user_profile_changelogs (
    logID INT PRIMARY KEY AUTO_INCREMENT,
    userID INT,
    fieldName VARCHAR(20),
    oldValue VARCHAR(20),
    newValue VARCHAR(20),
    updateDate DATETIME
);

ALTER TABLE user_profile_changelogs
ADD FOREIGN KEY (userID) REFERENCES users(userID);

CREATE TRIGGER update_user_profile AFTER UPDATE on users
FOR EACH ROW
BEGIN
    IF (NEW.fristName != OLD.fristName) THEN
        INSERT INTO user_profile_changelogs
        VALUES 
        (DEFAULT,NEW.userID, "fristName", OLD.fristName, NEW.fristName, NOW());
    END IF;
    IF (NEW.lastName != OLD.lastName) THEN
        INSERT INTO user_profile_changelogs
        VALUES 
        (DEFAULT,NEW.userID, "lastName", OLD.lastName, NEW.lastName, NOW());
    END IF;
    IF (NEW.dateOfBirth != OLD.dateOfBirth) THEN
        INSERT INTO user_profile_changelogs
        VALUES 
        (DEFAULT,NEW.userID, "dateOfBirth", OLD.dateOfBirth, NEW.dateOfBirth, NOW());
    END IF;
    IF (NEW.hashedPassword != OLD.hashedPassword) THEN
        INSERT INTO user_profile_changelogs
        VALUES 
        (DEFAULT,NEW.userID, "hashedPassword", OLD.hashedPassword, NEW.hashedPassword, NOW());
    END IF;
    IF (NEW.profilePic != OLD.profilePic) THEN
        INSERT INTO user_profile_changelogs
        VALUES 
        (DEFAULT,NEW.userID, "profilePic", OLD.profilePic, NEW.profilePic, NOW());
    END IF;
END;