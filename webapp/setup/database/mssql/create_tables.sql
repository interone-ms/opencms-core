USE ${database};

CREATE TABLE CMS_USERS (
	USER_ID NVARCHAR(36)  NOT NULL,
	USER_NAME NVARCHAR(64)  NOT NULL,
	USER_PASSWORD NVARCHAR(32)  NOT NULL,
	USER_DESCRIPTION NVARCHAR(255) NOT NULL,
	USER_FIRSTNAME NVARCHAR(50) NOT NULL,
	USER_LASTNAME NVARCHAR(50) NOT NULL,
	USER_EMAIL NVARCHAR(100) NOT NULL,
	USER_LASTLOGIN BIGINT NOT NULL,
	USER_FLAGS INT NOT NULL,
	USER_INFO IMAGE,
	USER_ADDRESS NVARCHAR(100) NOT NULL,
	USER_TYPE INT NOT NULL,
	PRIMARY KEY	(USER_ID), 
	UNIQUE (USER_NAME)
);

CREATE TABLE CMS_GROUPS (
	GROUP_ID NVARCHAR(36)  NOT NULL,
	PARENT_GROUP_ID NVARCHAR(36)  NOT NULL,
	GROUP_NAME NVARCHAR(64)  NOT NULL,
	GROUP_DESCRIPTION NVARCHAR(255) NOT NULL,
	GROUP_FLAGS INT NOT NULL,
	PRIMARY KEY (GROUP_ID),
	UNIQUE (GROUP_NAME)
);



CREATE TABLE CMS_GROUPUSERS (
	GROUP_ID NVARCHAR(36)  NOT NULL,
	USER_ID NVARCHAR(36)  NOT NULL,
	GROUPUSER_FLAGS INT NOT NULL,
	PRIMARY KEY (GROUP_ID,USER_ID),
	FOREIGN KEY (GROUP_ID) references CMS_GROUPS(GROUP_ID),
	FOREIGN KEY (USER_ID) references CMS_USERS(USER_ID)
);

CREATE TABLE CMS_PROJECTS (
	PROJECT_ID INT NOT NULL,
	PROJECT_NAME NVARCHAR(64)  NOT NULL,
	PROJECT_DESCRIPTION NVARCHAR(255) NOT NULL,
	PROJECT_FLAGS INT NOT NULL,
	PROJECT_TYPE INT NOT NULL,
	USER_ID NVARCHAR(36)  NOT NULL,
	GROUP_ID NVARCHAR(36)  NOT NULL, 
	MANAGERGROUP_ID NVARCHAR(36)  NOT NULL,
	DATE_CREATED BIGINT NOT NULL,
	PRIMARY KEY (PROJECT_ID), 
	UNIQUE (PROJECT_NAME, DATE_CREATED),
	FOREIGN KEY (GROUP_ID) REFERENCES CMS_GROUPS(GROUP_ID) ,
	FOREIGN KEY (MANAGERGROUP_ID) REFERENCES CMS_GROUPS(GROUP_ID),
	FOREIGN KEY (USER_ID) references CMS_USERS(USER_ID)
);

CREATE TABLE CMS_BACKUP_PROJECTS (
	PROJECT_ID INT NOT NULL,
	PROJECT_NAME NVARCHAR(64)  NOT NULL,
	PROJECT_DESCRIPTION NVARCHAR(255) NOT NULL,
	PROJECT_TYPE INT NOT NULL,
	USER_ID NVARCHAR(36)  NOT NULL,
	GROUP_ID NVARCHAR(36)  NOT NULL,
	MANAGERGROUP_ID NVARCHAR(36)  NOT NULL,
	DATE_CREATED BIGINT NOT NULL,	
	PUBLISH_TAG INT NOT NULL,
	PROJECT_PUBLISHDATE DATETIME,
	PROJECT_PUBLISHED_BY NVARCHAR(36)  NOT NULL,
	PROJECT_PUBLISHED_BY_NAME NVARCHAR(167),
	USER_NAME NVARCHAR(167),
	GROUP_NAME NVARCHAR(64) ,
	MANAGERGROUP_NAME NVARCHAR(64) ,	
	PRIMARY KEY (PUBLISH_TAG)
);

CREATE TABLE CMS_PROJECTRESOURCES (
	PROJECT_ID INT NOT NULL,
	RESOURCE_PATH nvarchar(440) NOT NULL,
	PRIMARY KEY (PROJECT_ID, RESOURCE_PATH)
);

CREATE TABLE CMS_BACKUP_PROJECTRESOURCES (
	PUBLISH_TAG INT NOT NULL,
	PROJECT_ID INT NOT NULL,
	RESOURCE_PATH NVARCHAR(440) NOT NULL,
	PRIMARY KEY (PUBLISH_TAG, PROJECT_ID, RESOURCE_PATH)
);

CREATE TABLE CMS_OFFLINE_PROPERTYDEF (
	PROPERTYDEF_ID NVARCHAR(36)  NOT NULL, 
	PROPERTYDEF_NAME NVARCHAR(128)  NOT NULL,
	PRIMARY KEY (PROPERTYDEF_ID), 
	UNIQUE (PROPERTYDEF_ID),
	UNIQUE (PROPERTYDEF_NAME)
);
                           
CREATE TABLE CMS_ONLINE_PROPERTYDEF (
	PROPERTYDEF_ID NVARCHAR(36)  NOT NULL, 
	PROPERTYDEF_NAME NVARCHAR(128)  NOT NULL,
	PRIMARY KEY (PROPERTYDEF_ID), 
	UNIQUE (PROPERTYDEF_ID),
	UNIQUE (PROPERTYDEF_NAME)	
);
                                        
CREATE TABLE CMS_BACKUP_PROPERTYDEF (
	PROPERTYDEF_ID NVARCHAR(36)  NOT NULL, 
	PROPERTYDEF_NAME NVARCHAR(128)  NOT NULL,
	PRIMARY KEY (PROPERTYDEF_ID), 
	UNIQUE (PROPERTYDEF_ID),
	UNIQUE (PROPERTYDEF_NAME)	
);

CREATE TABLE CMS_OFFLINE_PROPERTIES (
	PROPERTY_ID NVARCHAR(36)  NOT NULL,
	PROPERTYDEF_ID NVARCHAR(36)  NOT NULL,
	PROPERTY_MAPPING_ID NVARCHAR(36)  NOT NULL,
	PROPERTY_MAPPING_TYPE INT NOT NULL,
	PROPERTY_VALUE NTEXT NOT NULL,
	PRIMARY KEY (PROPERTY_ID)
);
                                         
CREATE TABLE CMS_ONLINE_PROPERTIES (
	PROPERTY_ID NVARCHAR(36)  NOT NULL,
	PROPERTYDEF_ID NVARCHAR(36)  NOT NULL,
	PROPERTY_MAPPING_ID NVARCHAR(36)  NOT NULL,
	PROPERTY_MAPPING_TYPE INT NOT NULL,
	PROPERTY_VALUE NTEXT NOT NULL,
	PRIMARY KEY(PROPERTY_ID)
);
                                                                              
CREATE TABLE CMS_BACKUP_PROPERTIES (
	BACKUP_ID NVARCHAR(36)  NOT NULL,
	PROPERTY_ID NVARCHAR(36)  NOT NULL,
	PROPERTYDEF_ID NVARCHAR(36)  NOT NULL,
	PROPERTY_MAPPING_ID NVARCHAR(36)  NOT NULL,
	PROPERTY_MAPPING_TYPE INT NOT NULL,
	PROPERTY_VALUE NTEXT NOT NULL,
	PUBLISH_TAG INT,
	VERSION_ID	INT NOT NULL,
	PRIMARY KEY(PROPERTY_ID)
);

CREATE TABLE CMS_ONLINE_ACCESSCONTROL (
	RESOURCE_ID NVARCHAR(36)  NOT NULL,
	PRINCIPAL_ID NVARCHAR(36)  NOT NULL,
	ACCESS_ALLOWED INT,
	ACCESS_DENIED INT,
	ACCESS_FLAGS INT,
	PRIMARY KEY (RESOURCE_ID, PRINCIPAL_ID),
);

CREATE TABLE CMS_OFFLINE_ACCESSCONTROL (
	RESOURCE_ID NVARCHAR(36)  NOT NULL,
	PRINCIPAL_ID NVARCHAR(36)  NOT NULL,
	ACCESS_ALLOWED INT,
	ACCESS_DENIED INT,
	ACCESS_FLAGS INT,
	PRIMARY KEY (RESOURCE_ID, PRINCIPAL_ID)
);

CREATE TABLE CMS_PUBLISH_HISTORY (
	HISTORY_ID NVARCHAR(36)  NOT NULL,
	PUBLISH_TAG INT NOT NULL,
	STRUCTURE_ID NVARCHAR(36)  NOT NULL,
	RESOURCE_ID NVARCHAR(36)  NOT NULL,
	RESOURCE_PATH NVARCHAR(440) NOT NULL,
	RESOURCE_STATE INT NOT NULL,
	RESOURCE_TYPE INT NOT NULL,
	SIBLING_COUNT INT NOT NULL,
	PRIMARY KEY (HISTORY_ID, PUBLISH_TAG, STRUCTURE_ID, RESOURCE_PATH)
);

CREATE TABLE CMS_PUBLISH_JOBS (
	HISTORY_ID VARCHAR(36) NOT NULL,
	PROJECT_ID VARCHAR(36) NOT NULL,
	PROJECT_NAME NVARCHAR(64) NOT NULL,
	USER_ID VARCHAR(36) NOT NULL,
	USER_NAME NVARCHAR(64) NOT NULL,
	PUBLISH_LOCALE VARCHAR(16) NOT NULL,
	PUBLISH_FLAGS INT NOT NULL,
	PUBLISH_LIST IMAGE,
	PUBLISH_REPORT IMAGE,
	RESOURCE_COUNT INT NOT NULL,
	ENQUEUE_TIME BIGINT NOT NULL,
	START_TIME BIGINT NOT NULL,
	FINISH_TIME BIGINT NOT NULL,
	PRIMARY KEY(HISTORY_ID)
);

CREATE TABLE CMS_RESOURCE_LOCKS (
  RESOURCE_PATH TEXT NOT NULL,
  USER_ID varchar(36) NOT NULL default '',
  PROJECT_ID INT NOT NULL default 0,
  LOCK_TYPE INT NOT NULL default 0
);


CREATE TABLE CMS_STATICEXPORT_LINKS (
	LINK_ID NVARCHAR(36)  NOT NULL,
	LINK_RFS_PATH NVARCHAR(440) NOT NULL,
	LINK_TYPE INT NOT NULL,
	LINK_PARAMETER TEXT,
	LINK_TIMESTAMP BIGINT,	
	PRIMARY KEY (LINK_ID)	
);

CREATE TABLE CMS_OFFLINE_STRUCTURE (
	STRUCTURE_ID NVARCHAR(36)  NOT NULL,
	RESOURCE_ID NVARCHAR(36)  NOT NULL,
	PARENT_ID NVARCHAR(36)  NOT NULL,
	RESOURCE_PATH NVARCHAR(440) NOT NULL,
	STRUCTURE_STATE INT NOT NULL,
	DATE_RELEASED BIGINT NOT NULL,
	DATE_EXPIRED BIGINT NOT NULL,
	PRIMARY KEY (STRUCTURE_ID)
);

CREATE TABLE CMS_ONLINE_STRUCTURE (
	STRUCTURE_ID NVARCHAR(36)  NOT NULL,
	RESOURCE_ID NVARCHAR(36)  NOT NULL,
	PARENT_ID NVARCHAR(36)  NOT NULL,
	RESOURCE_PATH NVARCHAR(440) NOT NULL,
	STRUCTURE_STATE INT NOT NULL,
	DATE_RELEASED BIGINT NOT NULL,
	DATE_EXPIRED BIGINT NOT NULL,
	PRIMARY KEY (STRUCTURE_ID)
);

CREATE TABLE CMS_BACKUP_STRUCTURE (
	BACKUP_ID NVARCHAR(36)  NOT NULL,
	PUBLISH_TAG INT NOT NULL,
	VERSION_ID INT NOT NULL,
	STRUCTURE_ID NVARCHAR(36)  NOT NULL,
	RESOURCE_ID NVARCHAR(36)  NOT NULL,
	RESOURCE_PATH NVARCHAR(440) NOT NULL,
	STRUCTURE_STATE INT NOT NULL,
	DATE_RELEASED BIGINT NOT NULL,
	DATE_EXPIRED BIGINT NOT NULL,
	PRIMARY KEY (BACKUP_ID)
);

CREATE TABLE CMS_OFFLINE_RESOURCES (
	RESOURCE_ID NVARCHAR(36)  NOT NULL,
	RESOURCE_TYPE INT NOT NULL,
	RESOURCE_FLAGS INT NOT NULL,
	RESOURCE_STATE	INT NOT NULL,
	RESOURCE_SIZE INT NOT NULL,                                         
	SIBLING_COUNT INT NOT NULL,
	DATE_CREATED BIGINT NOT NULL,
	DATE_LASTMODIFIED BIGINT NOT NULL,
	USER_CREATED NVARCHAR(36)  NOT NULL,                                         
	USER_LASTMODIFIED NVARCHAR(36)  NOT NULL,
	PROJECT_LASTMODIFIED INT NOT NULL,          
	PRIMARY KEY(RESOURCE_ID)
);

CREATE TABLE CMS_ONLINE_RESOURCES (
	RESOURCE_ID NVARCHAR(36)  NOT NULL,
	RESOURCE_TYPE INT NOT NULL,
	RESOURCE_FLAGS INT NOT NULL,
	RESOURCE_STATE	INT NOT NULL,
	RESOURCE_SIZE INT NOT NULL,
	SIBLING_COUNT INT NOT NULL,	
	DATE_CREATED BIGINT NOT NULL,
	DATE_LASTMODIFIED BIGINT NOT NULL,
	USER_CREATED NVARCHAR(36)  NOT NULL,                                         
	USER_LASTMODIFIED NVARCHAR(36)  NOT NULL,
	PROJECT_LASTMODIFIED INT NOT NULL,
	PRIMARY KEY(RESOURCE_ID)
);
                                         
CREATE TABLE CMS_BACKUP_RESOURCES (
	BACKUP_ID NVARCHAR(36)  NOT NULL,
	RESOURCE_ID NVARCHAR(36)  NOT NULL,
	RESOURCE_TYPE INT NOT NULL,
	RESOURCE_FLAGS INT NOT NULL,
	RESOURCE_STATE	INT NOT NULL,
	RESOURCE_SIZE INT NOT NULL,
	SIBLING_COUNT INT NOT NULL,	
	DATE_CREATED BIGINT NOT NULL,
	DATE_LASTMODIFIED BIGINT NOT NULL,
	USER_CREATED NVARCHAR(36)  NOT NULL,
	USER_LASTMODIFIED NVARCHAR(36)  NOT NULL,
	PROJECT_LASTMODIFIED INT NOT NULL,
	PUBLISH_TAG INT NOT NULL,
	VERSION_ID INT NOT NULL,
	USER_CREATED_NAME NVARCHAR(64) NOT NULL,
	USER_LASTMODIFIED_NAME NVARCHAR(64) NOT NULL,
	PRIMARY KEY(BACKUP_ID)
);

CREATE TABLE CMS_OFFLINE_CONTENTS (
	CONTENT_ID NVARCHAR(36)  NOT NULL,
	RESOURCE_ID NVARCHAR(36)  NOT NULL,
	FILE_CONTENT IMAGE NOT NULL,
	UNIQUE (RESOURCE_ID),
	PRIMARY KEY(CONTENT_ID)
);

CREATE TABLE CMS_ONLINE_CONTENTS (
	CONTENT_ID NVARCHAR(36)  NOT NULL,
	RESOURCE_ID NVARCHAR(36)  NOT NULL,
	FILE_CONTENT IMAGE NOT NULL,
	UNIQUE (RESOURCE_ID),
	PRIMARY KEY(CONTENT_ID)
);

CREATE TABLE CMS_BACKUP_CONTENTS (
	BACKUP_ID NVARCHAR(36)  NOT NULL,
	CONTENT_ID NVARCHAR(36)  NOT NULL,
	RESOURCE_ID NVARCHAR(36)  NOT NULL,
	FILE_CONTENT IMAGE NOT NULL,
	PUBLISH_TAG INT,
	VERSION_ID INT NOT NULL,
	PRIMARY KEY(BACKUP_ID)
);

CREATE NONCLUSTERED INDEX IX_CMS_OFFLINE_PROPERTIES ON CMS_OFFLINE_PROPERTIES
( PROPERTYDEF_ID );

CREATE NONCLUSTERED INDEX IX_CMS_OFFLINE_PROPERTIES_1 ON CMS_OFFLINE_PROPERTIES
(PROPERTY_MAPPING_ID);

CREATE NONCLUSTERED INDEX IX_CMS_OFFLINE_PROPERTIES_2 ON CMS_OFFLINE_PROPERTIES
(PROPERTYDEF_ID,PROPERTY_MAPPING_ID);


CREATE NONCLUSTERED INDEX IX_CMS_ONLINE_PROPERTIES ON CMS_ONLINE_PROPERTIES
( PROPERTYDEF_ID );

CREATE NONCLUSTERED INDEX IX_CMS_ONLINE_PROPERTIES_1 ON CMS_ONLINE_PROPERTIES
(PROPERTY_MAPPING_ID);

CREATE NONCLUSTERED INDEX IX_CMS_ONLINE_PROPERTIES_2 ON CMS_ONLINE_PROPERTIES
(PROPERTYDEF_ID,PROPERTY_MAPPING_ID);


CREATE NONCLUSTERED INDEX IX_CMS_BACKUP_PROPERTIES ON CMS_BACKUP_PROPERTIES
( PROPERTYDEF_ID );

CREATE NONCLUSTERED INDEX IX_CMS_BACKUP_PROPERTIES_1 ON CMS_BACKUP_PROPERTIES
(PROPERTY_MAPPING_ID);

CREATE NONCLUSTERED INDEX IX_CMS_BACKUP_PROPERTIES_2 ON CMS_BACKUP_PROPERTIES
(PROPERTYDEF_ID,PROPERTY_MAPPING_ID);



CREATE NONCLUSTERED INDEX IX_CMS_ONLINE_ACCESSCONTROL ON CMS_ONLINE_ACCESSCONTROL
(PRINCIPAL_ID);

CREATE NONCLUSTERED INDEX IX_CMS_OFFLINE_ACCESSCONTROL ON CMS_OFFLINE_ACCESSCONTROL
(PRINCIPAL_ID);

CREATE NONCLUSTERED INDEX IX_CMS_OFFLINE_STRUCTURE ON CMS_OFFLINE_STRUCTURE
(STRUCTURE_ID, RESOURCE_PATH);

CREATE NONCLUSTERED INDEX IX_CMS_OFFLINE_STRUCTURE_1 ON CMS_OFFLINE_STRUCTURE
(RESOURCE_PATH, RESOURCE_ID);

CREATE NONCLUSTERED INDEX IX_CMS_OFFLINE_STRUCTURE_2 ON CMS_OFFLINE_STRUCTURE
(STRUCTURE_ID, RESOURCE_ID);

CREATE NONCLUSTERED INDEX IX_CMS_OFFLINE_STRUCTURE_3 ON CMS_OFFLINE_STRUCTURE
(STRUCTURE_STATE);

CREATE NONCLUSTERED INDEX IX_CMS_OFFLINE_STRUCTURE_4 ON CMS_OFFLINE_STRUCTURE
(PARENT_ID);

CREATE NONCLUSTERED INDEX IX_CMS_OFFLINE_STRUCTURE_5 ON CMS_OFFLINE_STRUCTURE
(RESOURCE_ID);

CREATE NONCLUSTERED INDEX IX_CMS_OFFLINE_STRUCTURE_6 ON CMS_OFFLINE_STRUCTURE
(RESOURCE_PATH);


CREATE NONCLUSTERED INDEX IX_CMS_ONLINE_STRUCTURE ON CMS_ONLINE_STRUCTURE
(STRUCTURE_ID, RESOURCE_PATH);

CREATE NONCLUSTERED INDEX IX_CMS_ONLINE_STRUCTURE_1 ON CMS_ONLINE_STRUCTURE
(RESOURCE_PATH, RESOURCE_ID);

CREATE NONCLUSTERED INDEX IX_CMS_ONLINE_STRUCTURE_2 ON CMS_ONLINE_STRUCTURE
(STRUCTURE_ID, RESOURCE_ID);

CREATE NONCLUSTERED INDEX IX_CMS_ONLINE_STRUCTURE_3 ON CMS_ONLINE_STRUCTURE
(STRUCTURE_STATE);

CREATE NONCLUSTERED INDEX IX_CMS_ONLINE_STRUCTURE_4 ON CMS_ONLINE_STRUCTURE
(PARENT_ID);

CREATE NONCLUSTERED INDEX IX_CMS_ONLINE_STRUCTURE_5 ON CMS_ONLINE_STRUCTURE
(RESOURCE_ID);

CREATE NONCLUSTERED INDEX IX_CMS_ONLINE_STRUCTURE_6 ON CMS_ONLINE_STRUCTURE
(RESOURCE_PATH);


CREATE NONCLUSTERED INDEX IX_CMS_BACKUP_STRUCTURE ON CMS_BACKUP_STRUCTURE
(STRUCTURE_ID, RESOURCE_PATH);

CREATE NONCLUSTERED INDEX IX_CMS_BACKUP_STRUCTURE_1 ON CMS_BACKUP_STRUCTURE
(RESOURCE_PATH, RESOURCE_ID);

CREATE NONCLUSTERED INDEX IX_CMS_BACKUP_STRUCTURE_2 ON CMS_BACKUP_STRUCTURE
(STRUCTURE_ID, RESOURCE_ID);

CREATE NONCLUSTERED INDEX IX_CMS_BACKUP_STRUCTURE_3 ON CMS_BACKUP_STRUCTURE
(STRUCTURE_STATE);

CREATE NONCLUSTERED INDEX IX_CMS_BACKUP_STRUCTURE_4 ON CMS_BACKUP_STRUCTURE
(PUBLISH_TAG);

CREATE NONCLUSTERED INDEX IX_CMS_BACKUP_STRUCTURE_5 ON CMS_BACKUP_STRUCTURE
(RESOURCE_ID);

CREATE NONCLUSTERED INDEX IX_CMS_BACKUP_STRUCTURE_6 ON CMS_BACKUP_STRUCTURE
(RESOURCE_PATH);

CREATE NONCLUSTERED INDEX IX_CMS_BACKUP_STRUCTURE_7 ON CMS_BACKUP_STRUCTURE
(VERSION_ID);


CREATE NONCLUSTERED INDEX IX_CMS_OFFLINE_RESOURCES ON CMS_OFFLINE_RESOURCES
(PROJECT_LASTMODIFIED);

CREATE NONCLUSTERED INDEX IX_CMS_OFFLINE_RESOURCES_1 ON CMS_OFFLINE_RESOURCES
(PROJECT_LASTMODIFIED,RESOURCE_SIZE);

CREATE NONCLUSTERED INDEX IX_CMS_OFFLINE_RESOURCES_2 ON CMS_OFFLINE_RESOURCES
(RESOURCE_SIZE);

CREATE NONCLUSTERED INDEX IX_CMS_OFFLINE_RESOURCES_3 ON CMS_OFFLINE_RESOURCES
(DATE_LASTMODIFIED);

CREATE NONCLUSTERED INDEX IX_CMS_OFFLINE_RESOURCES_4 ON CMS_OFFLINE_RESOURCES
(RESOURCE_TYPE);

CREATE NONCLUSTERED INDEX IX_CMS_ONLINE_RESOURCES ON CMS_ONLINE_RESOURCES
(PROJECT_LASTMODIFIED);

CREATE NONCLUSTERED INDEX IX_CMS_ONLINE_RESOURCES_1 ON CMS_ONLINE_RESOURCES
(PROJECT_LASTMODIFIED,RESOURCE_SIZE);

CREATE NONCLUSTERED INDEX IX_CMS_ONLINE_RESOURCES_2 ON CMS_ONLINE_RESOURCES
(RESOURCE_SIZE);

CREATE NONCLUSTERED INDEX IX_CMS_ONLINE_RESOURCES_3 ON CMS_ONLINE_RESOURCES
(DATE_LASTMODIFIED);

CREATE NONCLUSTERED INDEX IX_CMS_ONLINE_RESOURCES_4 ON CMS_ONLINE_RESOURCES
(RESOURCE_TYPE);

CREATE NONCLUSTERED INDEX IX_CMS_BACKUP_RESOURCES ON CMS_BACKUP_RESOURCES
(PROJECT_LASTMODIFIED);

CREATE NONCLUSTERED INDEX IX_CMS_BACKUP_RESOURCES_1 ON CMS_BACKUP_RESOURCES
(PROJECT_LASTMODIFIED,RESOURCE_SIZE);

CREATE NONCLUSTERED INDEX IX_CMS_BACKUP_RESOURCES_2 ON CMS_BACKUP_RESOURCES
(RESOURCE_SIZE);

CREATE NONCLUSTERED INDEX IX_CMS_BACKUP_RESOURCES_3 ON CMS_BACKUP_RESOURCES
(DATE_LASTMODIFIED);

CREATE NONCLUSTERED INDEX IX_CMS_BACKUP_RESOURCES_4 ON CMS_BACKUP_RESOURCES
(RESOURCE_TYPE);



CREATE NONCLUSTERED INDEX IX_CMS_BACKUP_CONTENTS ON CMS_BACKUP_CONTENTS
(RESOURCE_ID);

