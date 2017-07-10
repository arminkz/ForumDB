-- Q1

CREATE TEMPORARY TABLE deletedUsers (
SELECT * FROM user_profile_changelogs
WHERE fieldName = 'isDeleted' AND newValue = 1);

SELECT U.* , D.updateDate FROM users AS U , 
deletedUsers AS D
WHERE U.userID = D.userID;

-- Q2

CREATE TEMPORARY TABLE user_repliedToPost (
SELECT U.username , R.postID FROM users AS U ,replies AS R
WHERE U.userID = R.userID );

SELECT URTP.username , C.cName FROM user_repliedToPost AS URTP , post_tags AS PT , categories AS C
WHERE URTP.postID = PT.postID AND PT.catID = C.catID;

-- Q3

CREATE TEMPORARY TABLE user_repliedToPost (
SELECT U.username , R.postID FROM users AS U ,replies AS R
WHERE U.userID = R.userID );

CREATE TEMPORARY TABLE user_repiledToTag (
SELECT URTP.username , C.cName FROM user_repliedToPost AS URTP , post_tags AS PT , categories AS C
WHERE URTP.postID = PT.postID AND PT.catID = C.catID
);

CREATE TEMPORARY TABLE user_replyToTagCount (
SELECT username , cName , count(*) AS reply_count FROM user_repiledToTag
GROUP BY cName
);

SELECT * FROM user_replyToTagCount 
ORDER BY reply_count DESC
LIMIT 10;

-- Q4

CREATE TEMPORARY TABLE user_repliedToPost (
SELECT U.username , R.postID FROM users AS U ,replies AS R
WHERE U.userID = R.userID );

CREATE TEMPORARY TABLE user_repiledToTag (
SELECT URTP.username , C.cName FROM user_repliedToPost AS URTP , post_tags AS PT , categories AS C
WHERE URTP.postID = PT.postID AND PT.catID = C.catID
);

CREATE TEMPORARY TABLE user_replyToTagCount (
SELECT username , cName , count(*) AS reply_count FROM user_repiledToTag
GROUP BY cName
);

SELECT * FROM user_replyToTagCount 
ORDER BY reply_count DESC
WHERE cName = 'Computer'
LIMIT 10;

-- Q5

SELECT ICL.bankTrackingCode , ICL.transactionTime , SA.actionTime , ICL.amount , O.credits AS new_credits , S.fristName , S.lastName
FROM increase_credits_log AS ICL , organizations AS O , support_actions AS SA , supports AS S
WHERE ICL.orgID = O.orgID AND ICL.saID = SA.saID AND SA.suppID = S.suppID;

-- Q6

SELECT * FROM user_profile_changelogs

-- Q7

CREATE TEMPORARY TABLE project_post_count (
    SELECT Q.projID , Q.projTitle , count(*)
    FROM posts AS P , projects AS Q
    WHERE P.relatedProject = Q.projID
    GROUP BY Q.projID
);

CREATE TEMPORARY TABLE project_admins (
    SELECT P.projID , U.fristName , U.lastName  
    FROM projects AS P , project_members AS PM , users AS U
    WHERE P.projID = PM.projID AND PM.userID = U.userID
);

SELECT PRJ.projTitle , PRJ.description , PM.fristName , PM.lastName 
FROM projects AS PRJ , project_post_count AS PPC , project_admins AS PM
WHERE PPC.projID = PRJ.projID AND PM.projID = PRJ.projID;

-- Q8

SELECT CAT.cName , A.orgID , count(*) AS view_count
FROM ad_views AS AV , ads AS A , ad_constrains AS AC , constrains AS CON , categories AS CAT
WHERE AV.adID = A.adID AND A.adID = AC.adID AND AC.constID = CON.constID AND CON.tagConstrain = CAT.catID
GROUP BY CAT.cName , A.orgID;

SELECT CAT.cName , A.orgID , count(*) AS click_count
FROM ad_clicks AS AV , ads AS A , ad_constrains AS AC , constrains AS CON , categories AS CAT
WHERE AV.adID = A.adID AND A.adID = AC.adID AND AC.constID = CON.constID AND CON.tagConstrain = CAT.catID
GROUP BY CAT.cName , A.orgID;