	/* No foreign keys reference table 'dbo.ar_internal_metadata', or you do not have permissions on referencing tables. */
	/* No views with schema binding reference table 'dbo.ar_internal_metadata'. */

CREATE TABLE dbo.ar_internal_metadata
	( key        nvarchar(4000)  NOT NULL
	, value      nvarchar(4000)      NULL
	, created_at datetime        NOT NULL
	, updated_at datetime        NOT NULL
	)

ALTER TABLE dbo.ar_internal_metadata ADD CONSTRAINT PK__ar_inter__DFD83CAED0FD6C21 PRIMARY KEY clustered (key)

	/* No foreign keys reference table 'dbo.articles', or you do not have permissions on referencing tables. */
	/* No views with schema binding reference table 'dbo.articles'. */

CREATE TABLE dbo.articles
	( id         bigint          NOT NULL
	, title      nvarchar(4000)      NULL
	, text       nvarchar(max)        NULL
	, created_at datetime        NOT NULL
	, updated_at datetime        NOT NULL
	)

ALTER TABLE dbo.articles ADD CONSTRAINT PK__articles__3213E83F141EEE6D PRIMARY KEY clustered (id)

	/* No views with schema binding reference table 'dbo.large_classifications'. */

CREATE TABLE dbo.large_classifications
	( large_classification_id nvarchar(6)     NOT NULL
	, description             nvarchar(240)       NULL
	, created_staff           nvarchar(40)        NULL
	, updated_staff           nvarchar(40)        NULL
	, created_at              datetime        NOT NULL
	, updated_at              datetime        NOT NULL
	)

ALTER TABLE dbo.large_classifications ADD CONSTRAINT PK__large_cl__C16D20FF795FF2DE PRIMARY KEY clustered (large_classification_id)

	/* No foreign keys reference table 'dbo.ldap_departments', or you do not have permissions on referencing tables. */
	/* No views with schema binding reference table 'dbo.ldap_departments'. */

CREATE TABLE dbo.ldap_departments
	( usncreated  bigint          NOT NULL
	, name        nvarchar(4000)      NULL
	, whencreated datetime            NULL
	, whenchanged datetime            NULL
	, created_at  datetime        NOT NULL
	, updated_at  datetime        NOT NULL
	)

ALTER TABLE dbo.ldap_departments ADD CONSTRAINT PK__ldap_dep__66DAAC36DAE1DAEE PRIMARY KEY clustered (usncreated)

	/* No constraints are defined on object 'dbo.ldap_role_users', or you do not have permissions. */
	/* No foreign keys reference table 'dbo.ldap_role_users', or you do not have permissions on referencing tables. */
	/* No views with schema binding reference table 'dbo.ldap_role_users'. */

CREATE TABLE dbo.ldap_role_users
	( department_id int                 NULL
	, role_id       int                 NULL
	, user_id       int                 NULL
	, department    nvarchar(4000)      NULL
	, role          nvarchar(4000)      NULL
	, user          nvarchar(4000)      NULL
	, created_at    datetime        NOT NULL
	, updated_at    datetime        NOT NULL
	)

CREATE unique nonclustered INDEX index_ldap_role_users_on_department_and_role_and_user on dbo.ldap_role_users(department, role, user)

	/* No foreign keys reference table 'dbo.ldap_roles', or you do not have permissions on referencing tables. */
	/* No views with schema binding reference table 'dbo.ldap_roles'. */

CREATE TABLE dbo.ldap_roles
	( usncreated  bigint          NOT NULL
	, name        nvarchar(4000)      NULL
	, department  nvarchar(4000)      NULL
	, mail        nvarchar(4000)      NULL
	, whencreated datetime            NULL
	, whenchanged datetime            NULL
	, created_at  datetime        NOT NULL
	, updated_at  datetime        NOT NULL
	)

ALTER TABLE dbo.ldap_roles ADD CONSTRAINT PK__ldap_rol__66DAAC36E1C5D6B1 PRIMARY KEY clustered (usncreated)

	/* No foreign keys reference table 'dbo.ldap_users', or you do not have permissions on referencing tables. */
	/* No views with schema binding reference table 'dbo.ldap_users'. */

CREATE TABLE dbo.ldap_users
	( usncreated               bigint          NOT NULL
	, samaccountname           nvarchar(4000)      NULL
	, name                     nvarchar(4000)      NULL
	, department               nvarchar(4000)      NULL
	, title                    nvarchar(4000)      NULL
	, mail                     nvarchar(4000)      NULL
	, info                     nvarchar(4000)      NULL
	, description              nvarchar(4000)      NULL
	, telephonenumber          nvarchar(4000)      NULL
	, facsimiletelephonenumber nvarchar(4000)      NULL
	, whencreated              datetime            NULL
	, whenchanged              datetime            NULL
	, accountexpires           datetime            NULL
	, is_disable_account       bit                 NULL
	, is_left_job              bit                 NULL
	, is_retired               bit                 NULL
	, created_at               datetime        NOT NULL
	, updated_at               datetime        NOT NULL
	)

ALTER TABLE dbo.ldap_users ADD CONSTRAINT PK__ldap_use__66DAAC360E291B81 PRIMARY KEY clustered (usncreated)

	/* No views with schema binding reference table 'dbo.medium_classifications'. */

CREATE TABLE dbo.medium_classifications
	( large_classification_id  nvarchar(6)     NOT NULL
	, medium_classification_id nvarchar(6)     NOT NULL
	, description              nvarchar(240)       NULL
	, value_1                  float               NULL
	, value_2                  float               NULL
	, remark                   nvarchar(480)       NULL
	, created_staff            nvarchar(40)        NULL
	, updated_staff            nvarchar(40)        NULL
	, created_at               datetime        NOT NULL
	, updated_at               datetime        NOT NULL
	)

ALTER TABLE dbo.medium_classifications ADD CONSTRAINT PK__medium_c__15ED811AD073E7A2 PRIMARY KEY clustered (large_classification_id, medium_classification_id)

	/* No foreign keys reference table 'dbo.menubars', or you do not have permissions on referencing tables. */
	/* No views with schema binding reference table 'dbo.menubars'. */

CREATE TABLE dbo.menubars
	( menu_id        nvarchar(16)    NOT NULL
	, menu_name      nvarchar(80)        NULL
	, parent_menu_id nvarchar(12)        NULL
	, menu_sn        int                 NULL
	, program_id     nvarchar(4000)      NULL
	, program_url    nvarchar(4000)      NULL
	, lock_version   int             NOT NULL
	, created_at     datetime        NOT NULL
	, updated_at     datetime        NOT NULL
	)

ALTER TABLE dbo.menubars ADD CONSTRAINT PK__menubars__4CA0FADC29EF1BFD PRIMARY KEY clustered (menu_id)

	/* No foreign keys reference table 'dbo.schema_migrations', or you do not have permissions on referencing tables. */
	/* No views with schema binding reference table 'dbo.schema_migrations'. */

CREATE TABLE dbo.schema_migrations
	( version nvarchar(4000)  NOT NULL
	)

ALTER TABLE dbo.schema_migrations ADD CONSTRAINT PK__schema_m__79B5C94C60B39730 PRIMARY KEY clustered (version)

	/* No foreign keys reference table 'dbo.small_classifications', or you do not have permissions on referencing tables. */
	/* No views with schema binding reference table 'dbo.small_classifications'. */

CREATE TABLE dbo.small_classifications
	( large_classification_id  nvarchar(6)     NOT NULL
	, medium_classification_id nvarchar(6)     NOT NULL
	, small_classification_id  nvarchar(6)     NOT NULL
	, description              nvarchar(240)       NULL
	, remark                   nvarchar(480)       NULL
	, created_staff            nvarchar(40)        NULL
	, updated_staff            nvarchar(40)        NULL
	, created_at               datetime        NOT NULL
	, updated_at               datetime        NOT NULL
	)

ALTER TABLE dbo.small_classifications ADD CONSTRAINT PK__small_cl__5AF286943DBCB67B PRIMARY KEY clustered (large_classification_id, medium_classification_id, small_classification_id)

	/* No foreign keys reference table 'dbo.users', or you do not have permissions on referencing tables. */
	/* No views with schema binding reference table 'dbo.users'. */

CREATE TABLE dbo.users
	( id                  bigint          NOT NULL
	, login               nvarchar(4000)  NOT NULL
	, remember_created_at datetime            NULL
	, sign_in_count       int             NOT NULL
	, current_sign_in_at  datetime            NULL
	, last_sign_in_at     datetime            NULL
	, current_sign_in_ip  nvarchar(4000)      NULL
	, last_sign_in_ip     nvarchar(4000)      NULL
	, created_at          datetime        NOT NULL
	, updated_at          datetime        NOT NULL
	)

CREATE unique nonclustered INDEX index_users_on_login on dbo.users(login)

ALTER TABLE dbo.users ADD CONSTRAINT PK__users__3213E83FB68CCC03 PRIMARY KEY clustered (id)

	/* No foreign keys reference table 'dbo.wh1s', or you do not have permissions on referencing tables. */
	/* No views with schema binding reference table 'dbo.wh1s'. */

CREATE TABLE dbo.wh1s
	( id         bigint          NOT NULL
	, WH100      nvarchar(2)     NOT NULL
	, WH101      nvarchar(40)    NOT NULL
	, WH102      nvarchar(160)   NOT NULL
	, WH103      nvarchar(40)    NOT NULL
	, WH104      nvarchar(40)    NOT NULL
	, WH105      float               NULL
	, WH106      float               NULL
	, WH107      float               NULL
	, WH108      float               NULL
	, WH109      float               NULL
	, WH110      float               NULL
	, WH111      float               NULL
	, WH112      float               NULL
	, WH113      nvarchar(2)     NOT NULL
	, CreUserId  nvarchar(20)    NOT NULL
	, UpdUserId  nvarchar(20)    NOT NULL
	, created_at datetime        NOT NULL
	, updated_at datetime        NOT NULL
	)

ALTER TABLE dbo.wh1s ADD CONSTRAINT PK__wh1s__3213E83F9BB0FC47 PRIMARY KEY clustered (id)

INSERT INTO [schema_migrations] (version) VALUES
(N'20180320112421'),
(N'20180504095408'),
(N'20180504100530'),
(N'20180504103830'),
(N'20181112095422'),
(N'20181113063441'),
(N'20190128023804'),
(N'20190509022638'),
(N'20190516035111'),
(N'20190516035548'),
(N'20190516040205'),
(N'20190517035038'),
(N'20190807095722');


