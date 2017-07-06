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

CREATE TABLE posts (
    postID INT PRIMARY KEY AUTO_INCREMENT,
    userID INT,
    title VARCHAR(20),
    description VARCHAR(64),
    pstatus INT,
    rejectionMsg VARCHAR(20),
    summeryReply INT,
    relatedProject INT
);

ALTER TABLE posts
ADD FOREIGN KEY (userID) REFERENCES users(userID);

CREATE TABLE post_attachments (
    postID INT,
    link_to_file VARCHAR(20),
    PRIMARY KEY(postID,link_to_file)
);

ALTER TABLE post_attachments
ADD FOREIGN KEY (postID) REFERENCES posts(postID);

CREATE TABLE replies (
    repID INT PRIMARY KEY AUTO_INCREMENT,
    rtext VARCHAR(20)
);

CREATE TABLE summary_replies (
    srepID INT PRIMARY KEY AUTO_INCREMENT,
    srtext VARCHAR(20),
    creationTime TIMESTAMP
);

ALTER TABLE posts
ADD FOREIGN KEY (summeryReply) REFERENCES summary_replies(srepID);

CREATE TABLE comments (
    comID INT PRIMARY KEY AUTO_INCREMENT,
    userID INT,
    ctext VARCHAR(20),
    ctime TIMESTAMP
);

ALTER TABLE comments
ADD FOREIGN KEY (userID) REFERENCES users(userID);




