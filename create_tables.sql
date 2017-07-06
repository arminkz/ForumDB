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

CREATE TABLE projects (
    projID INT PRIMARY KEY AUTO_INCREMENT,
    userID INT,
    projTitle VARCHAR(10),
    description VARCHAR(20),
    projStatus INT
);

ALTER TABLE projects
ADD FOREIGN KEY (userID) REFERENCES users(userID);

CREATE TABLE project_images (
    projID INT,
    link_to_image VARCHAR(20),
    PRIMARY KEY(projID,link_to_image)
);

ALTER TABLE project_images
ADD FOREIGN KEY (projID) REFERENCES projects(projID);

CREATE TABLE organizations (
    orgID INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(10),
    description VARCHAR(20),
    hashedPassword VARCHAR(40),
    logo BLOB,
    credits INT,
    isDeleted TINYINT(1)
);

CREATE TABLE organization_phones (
    orgID INT,
    phone INT,
    PRIMARY KEY(orgID,phone);
);

ALTER TABLE organization_phones
ADD FOREIGN KEY (orgID) REFERENCES organizations(orgID);

CREATE TABLE organization_addresses (
    orgID INT,
    address VARCHAR(30),
    PRIMARY KEY(orgID,address);
);

ALTER TABLE organization_addresses
ADD FOREIGN KEY (orgID) REFERENCES organizations(orgID);

CREATE TABLE organization_emails (
    orgID INT,
    email VARCHAR(20),
    PRIMARY KEY(orgID,email);
);

ALTER TABLE organization_emails
ADD FOREIGN KEY (orgID) REFERENCES organizations(orgID);

CREATE TABLE organization_profile_changelogs (
    logID INT PRIMARY KEY AUTO_INCREMENT,
    orgID INT,
    fieldName VARCHAR(20),
    oldValue VARCHAR(20),
    newValue VARCHAR(20),
    updateDate DATETIME
);

ALTER TABLE organization_profile_changelogs
ADD FOREIGN KEY (orgID) REFERENCES organizations(orgID);

-- TODO : FIX TRIGGER

CREATE TRIGGER update_organization_profile AFTER UPDATE on organizations
FOR EACH ROW
BEGIN
    IF (NEW.name != OLD.name) THEN
        INSERT INTO organization_profile_changelogs
        VALUES 
        (DEFAULT,NEW.orgID, "name", OLD.name, NEW.name, NOW());
    END IF;
END;

CREATE TABLE ads (
    adID INT PRIMARY KEY AUTO_INCREMENT,
    orgID INT,
    adTitle VARCHAR(10),
    adText VARCHAR(20),
    viewPrice INT,
    clickPrice INT
);

ALTER TABLE ads
ADD FOREIGN KEY (orgID) REFERENCES organizations(orgID);

CREATE TABLE ad_images (
    adID INT,
    link_to_image VARCHAR(20),
    PRIMARY KEY(adID,link_to_image)
);

ALTER TABLE ad_images
ADD FOREIGN KEY (adID) REFERENCES ads(adID);

CREATE TABLE categories (
    catID INT PRIMARY KEY AUTO_INCREMENT,
    cName VARCHAR(20)
);

CREATE TABLE advertise_constrains (
    constID INT PRIMARY KEY AUTO_INCREMENT,
    ageFrom INT,
    ageTo INT,
    tagConstrain INT
);

ALTER TABLE advertise_constrains
ADD FOREIGN KEY (tagConstrain) REFERENCES categories(catID);

CREATE TABLE supports (
    suppID INT PRIMARY KEY AUTO_INCREMENT,
    fristName VARCHAR(10),
    lastName VARCHAR(10),
    profilePic BLOB,
    isOnline TINYINT(1)
);

CREATE TABLE increase_credits_log (
    incID INT PRIMARY KEY AUTO_INCREMENT,
    orgID INT,
    suppID INT,
    amount INT,
    bankTrackingCode VARCHAR(20),
    accountNumber INT,
    transationTime TIMESTAMP,
    incStatus INT
);

ALTER TABLE increase_credits_log
ADD FOREIGN KEY (orgID) REFERENCES organizations(orgID);

ALTER TABLE increase_credits_log
ADD FOREIGN KEY (suppID) REFERENCES supports(suppID);


