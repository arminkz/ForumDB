CREATE TABLE users (
    userID INT PRIMARY KEY,
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