
/*All User's gets stored in APP_USER table*/
create table mvc.APP_USER (
   id BIGINT NOT NULL AUTO_INCREMENT,
   sso_id VARCHAR(30) NOT NULL,
   password VARCHAR(100) NOT NULL,
   first_name VARCHAR(30) NOT NULL,
   last_name  VARCHAR(30) NOT NULL,
   email VARCHAR(30) NOT NULL,
   PRIMARY KEY (id),
   UNIQUE (sso_id)
);
   
/* USER_PROFILE table contains all possible roles */ 
create table mvc.USER_PROFILE(
   id BIGINT NOT NULL AUTO_INCREMENT,
   type VARCHAR(30) NOT NULL,
   PRIMARY KEY (id),
   UNIQUE (type)
);
   
/* JOIN TABLE for MANY-TO-MANY relationship*/  
CREATE TABLE mvc.APP_USER_USER_PROFILE (
    user_id BIGINT NOT NULL,
    user_profile_id BIGINT NOT NULL,
    PRIMARY KEY (user_id, user_profile_id),
    CONSTRAINT FK_APP_USER FOREIGN KEY (user_id) REFERENCES mvc.APP_USER (id),
    CONSTRAINT FK_USER_PROFILE FOREIGN KEY (user_profile_id) REFERENCES mvc.USER_PROFILE (id)
);
  
/* Populate USER_PROFILE Table */
INSERT INTO mvc.USER_PROFILE(type) VALUES ('USER');
  
INSERT INTO mvc.USER_PROFILE(type) VALUES ('ADMIN');
  
INSERT INTO mvc.USER_PROFILE(type) VALUES ('DBA');

INSERT INTO mvc.USER_PROFILE(type) VALUES ('ALL');
  
  
/* Populate one Admin User which will further create other users for the application using GUI */
INSERT INTO mvc.APP_USER(sso_id, password, first_name, last_name, eapp_usermail)
VALUES ('sam','$2a$10$4eqIF5s/ewJwHK1p8lqlFOEm2QIA0S8g6./Lok.pQxqcxaBZYChRm', 'Sam','Smith','samy@xyz.com');

INSERT INTO mvc.APP_USER(sso_id, password, first_name, last_name, email)
VALUES ('rah','password', 'rah','r','rah@yahoo.com');
  
  
/* Populate JOIN Table */
INSERT INTO mvc.APP_USER_USER_PROFILE (user_id, user_profile_id)
  SELECT user.id, profile.id FROM mvc.app_user user, mvc.user_profile profile
  where user.sso_id='sam' and profile.type='ADMIN';
  
INSERT INTO mvc.APP_USER_USER_PROFILE (user_id, user_profile_id)
  SELECT user.id, profile.id FROM mvc.app_user user, mvc.user_profile profile
  where user.sso_id='rah' and profile.type='ADMIN';

INSERT INTO mvc.APP_USER_USER_PROFILE (user_id, user_profile_id)
  SELECT user.id, profile.id FROM mvc.app_user user, mvc.user_profile profile where user.sso_id='rah' and profile.type='ALL';
 
/* Create persistent_logins Table used to store rememberme related stuff*/
CREATE TABLE mvc.persistent_logins (
    username VARCHAR(64) NOT NULL,
    series VARCHAR(64) NOT NULL,
    token VARCHAR(64) NOT NULL,
    last_used TIMESTAMP NOT NULL,
    PRIMARY KEY (series)
);