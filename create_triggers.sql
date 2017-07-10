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
    IF (NEW.isDeleted != OLD.isDeleted ) THEN
        INSERT INTO user_profile_changelogs
        VALUES 
        (DEFAULT,NEW.userID, "isDeleted ", OLD.isDeleted , NEW.isDeleted , NOW());
    END IF;
END;


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