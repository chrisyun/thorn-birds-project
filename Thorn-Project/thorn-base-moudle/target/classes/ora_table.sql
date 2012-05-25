drop table T_SYS_DICT_TYPE cascade constraints;

/*==============================================================*/
/* Table: T_SYS_DICT_TYPE                                       */
/*==============================================================*/
create table T_SYS_DICT_TYPE  (
   ENAME                VARCHAR2(100)                   not null,
   CNAME                VARCHAR2(200),
   CREATTIME            DATE,
   constraint PK_T_SYS_DICT_TYPE primary key (ENAME)
);


drop table T_SYS_DICT cascade constraints;

/*==============================================================*/
/* Table: T_SYS_DICT                                            */
/*==============================================================*/
create table T_SYS_DICT  (
   DNAME                VARCHAR2(200)                   not null,
   DVALUE               VARCHAR2(200),
   SORT                 NUMBER,
   TYPEID               VARCHAR2(200),
   constraint PK_T_SYS_DICT primary key (DNAME)
);

drop table T_SYS_USER cascade constraints;

/*==============================================================*/
/* Table: T_SYS_USER                                            */
/*==============================================================*/
create table T_SYS_USER  (
   "UID"                VARCHAR2(200)                   not null,
   UNAME                VARCHAR2(200),
   SN                   VARCHAR2(200),
   ACCOUNT              VARCHAR2(500),
   PASSWORD             VARCHAR2(500),
   SEX                  VARCHAR2(100),
   CUMAIL               VARCHAR2(200),
   PHONE                VARCHAR2(100),
   COMPANYID            VARCHAR2(200),
   ORGID                VARCHAR2(200),
   ISVALID              VARCHAR2(100),
   ISDISABLED           VARCHAR2(100),
   ISSHOW               VARCHAR2(100),
   SORT                 NUMBER                         default 999,
   DEFAULTROLE          VARCHAR2(100),
   constraint PK_T_SYS_USER primary key ("UID")
);

drop table T_SYS_USER_ROLE cascade constraints;

/*==============================================================*/
/* Table: T_SYS_USER_ROLE                                       */
/*==============================================================*/
create table T_SYS_USER_ROLE  (
   "UID"                VARCHAR2(200)                   not null,
   RID                  VARCHAR2(200)                   not null,
   REMARK               VARCHAR2(200),
   CREATTIME            DATE,
   constraint PK_T_SYS_USER_ROLE primary key ("UID", RID)
);

drop table T_SYS_ROLE_RES cascade constraints;

/*==============================================================*/
/* Table: T_SYS_ROLE_RES                                        */
/*==============================================================*/
create table T_SYS_ROLE_RES  (
   RID                  VARCHAR2(200)                   not null,
   SID                  VARCHAR2(200)                   not null,
   REMARK               VARCHAR2(200),
   CREATTIME            DATE,
   constraint PK_T_SYS_ROLE_RES primary key (RID, SID)
);

drop table T_SYS_ROLE cascade constraints;

/*==============================================================*/
/* Table: T_SYS_ROLE                                            */
/*==============================================================*/
create table T_SYS_ROLE  (
   RID                  VARCHAR2(200)                   not null,
   ROLENAME             VARCHAR2(200),
   REMARK               VARCHAR2(500),
   constraint PK_T_SYS_ROLE primary key (RID)
);

drop table T_SYS_ORG cascade constraints;

/*==============================================================*/
/* Table: T_SYS_ORG                                             */
/*==============================================================*/
create table T_SYS_ORG  (
   OID                  VARCHAR2(200)                   not null,
   OU                   VARCHAR2(500),
   PARENTORG            VARCHAR2(200),
   SHOWNAME             VARCHAR2(500),
   ORGTYPE              VARCHAR2(100),
   ORGMAIL              VARCHAR2(200),
   SORT                 NUMBER                         default 999,
   ISSHOW               VARCHAR2(100),
   ISVALID              VARCHAR2(100),
   ISDISABLED           VARCHAR2(100),
   constraint PK_T_SYS_ORG primary key (OID)
);


drop table T_SYS_RES cascade constraints;

/*==============================================================*/
/* Table: T_SYS_RES                                             */
/*==============================================================*/
create table T_SYS_RES  (
   SID                  VARCHAR2(200)                   not null,
   SNAME                VARCHAR2(200),
   URL                  VARCHAR2(500),
   ISLEAF               VARCHAR2(100),
   ISSHOW               VARCHAR2(100),
   PARENTRES            VARCHAR2(200),
   ISMODULE             VARCHAR2(100),
   SORT                 NUMBER                         default 999,
   constraint PK_T_SYS_RES primary key (SID)
);


drop table T_SYS_LOG cascade constraints;

/*==============================================================*/
/* Table: T_SYS_LOG                                             */
/*==============================================================*/
create table T_SYS_LOG  (
   LOGID                VARCHAR2(200)                   not null,
   OPERATER             VARCHAR2(200),
   OPETYPR              VARCHAR2(100),
   OPERTIME             DATE,
   OPERRESULT           VARCHAR2(100),
   OPERMODULE           VARCHAR2(100),
   OPERMETHOD           VARCHAR2(2000),
   constraint PK_T_SYS_LOG primary key (LOGID)
);

drop table T_SYS_INCRE cascade constraints;

/*==============================================================*/
/* Table: T_SYS_INCRE                                           */
/*==============================================================*/
create table T_SYS_INCRE  (
   TABLEID              VARCHAR2(50)                    not null,
   TABLENAME            VARCHAR2(200),
   MAXNUM               NUMBER                         default 1,
   INCRENUM             NUMBER                         default 1,
   constraint PK_T_SYS_INCRE primary key (TABLEID)
);

drop table T_SYS_ATTACH cascade constraints;

/*==============================================================*/
/* Table: T_SYS_ATTACH                                          */
/*==============================================================*/
create table T_SYS_ATTACH  (
   ATTID                VARCHAR2(200)                   not null,
   ATTNAME              VARCHAR2(500),
   ATTTYPE              VARCHAR2(100),
   ATTPATH              VARCHAR2(2000),
   UPLOADER             VARCHAR2(200),
   UPLOADTIME           DATE,
   ATTACH               CLOB,
   TABLEID              VARCHAR2(100),
   PID                  VARCHAR2(200),
   constraint PK_T_SYS_ATTACH primary key (ATTID)
);








































