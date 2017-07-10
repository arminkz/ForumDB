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

CREATE TABLE posts (
    postID INT PRIMARY KEY AUTO_INCREMENT,
    userID INT,
    title VARCHAR(20),
    description VARCHAR(64),
    saID INT, -- SUPPORT ACTION
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
    postID INT,
    userID INT,
    rtext VARCHAR(20)
);

ALTER TABLE replies
ADD FOREIGN KEY (postID) REFERENCES posts(postID);

ALTER TABLE replies
ADD FOREIGN KEY (userID) REFERENCES users(userID);

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
    repID INT,
    ctext VARCHAR(20),
    ctime TIMESTAMP
);

ALTER TABLE comments
ADD FOREIGN KEY (userID) REFERENCES users(userID);

ALTER TABLE comments
ADD FOREIGN KEY (repID) REFERENCES replies(repID);

CREATE TABLE projects (
    projID INT PRIMARY KEY AUTO_INCREMENT,
    userID INT,
    projTitle VARCHAR(10),
    description VARCHAR(20),
    saID INT, -- SUPP ACTION
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

ALTER TABLE posts
ADD FOREIGN KEY (relatedProject) REFERENCES projects(projID);

CREATE TABLE project_members (
    projID INT,
    userID INT,
    isProjectCreator TINYINT(1),
    startDate DATE,
    endDate DATE,
    PRIMARY KEY(projID,userID)
);

ALTER TABLE project_members
ADD FOREIGN KEY (projID) REFERENCES projects(projID);

ALTER TABLE project_members
ADD FOREIGN KEY (userID) REFERENCES users(userID);

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
    PRIMARY KEY(orgID,phone)
);

ALTER TABLE organization_phones
ADD FOREIGN KEY (orgID) REFERENCES organizations(orgID);

CREATE TABLE organization_addresses (
    orgID INT,
    address VARCHAR(30),
    PRIMARY KEY(orgID,address)
);

ALTER TABLE organization_addresses
ADD FOREIGN KEY (orgID) REFERENCES organizations(orgID);

CREATE TABLE organization_emails (
    orgID INT,
    email VARCHAR(20),
    PRIMARY KEY(orgID,email)
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

CREATE TABLE constrains (
    constID INT PRIMARY KEY AUTO_INCREMENT,
    ageFrom INT,
    ageTo INT,
    tagConstrain INT
);

ALTER TABLE constrains
ADD FOREIGN KEY (tagConstrain) REFERENCES categories(catID);

CREATE TABLE supports (
    suppID INT PRIMARY KEY AUTO_INCREMENT,
    fristName VARCHAR(10),
    lastName VARCHAR(10),
    profilePic BLOB,
    isOnline TINYINT(1)
);

CREATE TABLE support_actions (
    saID INT PRIMARY KEY AUTO_INCREMENT,
    suppID INT,
    actionType VARCHAR(20),
    actionTime TIMESTAMP
);

ALTER TABLE support_actions
ADD FOREIGN KEY (suppID) REFERENCES supports(suppID);

ALTER TABLE posts
ADD FOREIGN KEY (saID) REFERENCES support_actions(saID);

ALTER TABLE projects
ADD FOREIGN KEY (saID) REFERENCES support_actions(saID);

CREATE TABLE increase_credits_log (
    incID INT PRIMARY KEY AUTO_INCREMENT,
    orgID INT,
    amount INT,
    bankTrackingCode VARCHAR(20),
    accountNumber INT,
    transactionTime TIMESTAMP,
    saID INT,
    incStatus INT
);

ALTER TABLE increase_credits_log
ADD FOREIGN KEY (orgID) REFERENCES organizations(orgID);

ALTER TABLE increase_credits_log
ADD FOREIGN KEY (saID) REFERENCES support_actions(saID);

-- ----------------
-- Relation Tables
-- ----------------

CREATE TABLE rating (
    userID INT,
    postID INT,
    score INT,
    PRIMARY KEY(userID,postID)
);

ALTER TABLE rating
ADD FOREIGN KEY (userID) REFERENCES users(userID);

ALTER TABLE rating
ADD FOREIGN KEY (postID) REFERENCES posts(postID);

CREATE TABLE post_tags (
    postID INT,
    catID INT,
    isAutoTag TINYINT(1),
    PRIMARY KEY(postID,catID)
);

ALTER TABLE post_tags
ADD FOREIGN KEY (postID) REFERENCES posts(postID);

ALTER TABLE post_tags
ADD FOREIGN KEY (catID) REFERENCES categories(catID);

CREATE TABLE project_tags (
    projID INT,
    catID INT,
    PRIMARY KEY(projID,catID)
);

ALTER TABLE project_tags
ADD FOREIGN KEY (projID) REFERENCES projects(projID);

ALTER TABLE project_tags
ADD FOREIGN KEY (catID) REFERENCES categories(catID);

CREATE TABLE user_favorite_tags (
    userID INT,
    catID INT,
    PRIMARY KEY(userID , catID)
);

ALTER TABLE user_favorite_tags
ADD FOREIGN KEY (userID) REFERENCES users(userID);

ALTER TABLE user_favorite_tags
ADD FOREIGN KEY (catID) REFERENCES categories(catID);

CREATE TABLE summary_reply_sources (
    srepID INT,
    repID INT,
    PRIMARY KEY(srepID,repID)
);

ALTER TABLE summary_reply_sources
ADD FOREIGN KEY (srepID) REFERENCES summary_replies(srepID);

ALTER TABLE summary_reply_sources
ADD FOREIGN KEY (repID) REFERENCES replies(repID);

CREATE TABLE ad_views (
    userID INT,
    adID INT,
    viewTime TIMESTAMP,
    PRIMARY KEY(userID,adID)
);

ALTER TABLE ad_views
ADD FOREIGN KEY (userID) REFERENCES users(userID);

ALTER TABLE ad_views
ADD FOREIGN KEY (adID) REFERENCES ads(adID);

CREATE TABLE ad_clicks (
    userID INT,
    adID INT,
    clickTime TIMESTAMP,
    PRIMARY KEY(userID,adID)
);

ALTER TABLE ad_clicks
ADD FOREIGN KEY (userID) REFERENCES users(userID);

ALTER TABLE ad_clicks
ADD FOREIGN KEY (adID) REFERENCES ads(adID);

CREATE TABLE ad_constrains (
    adID INT,
    constID INT,
    PRIMARY KEY (adID,constID)
);

ALTER TABLE ad_constrains
ADD FOREIGN KEY (constID) REFERENCES constrains(constID);

ALTER TABLE ad_constrains
ADD FOREIGN KEY (adID) REFERENCES ads(adID);

