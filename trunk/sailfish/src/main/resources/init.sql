drop table if exists resource_log;

/*==============================================================*/
/* Table: resource_log                                          */
/*==============================================================*/
create table resource_log
(
   id                   int not null auto_increment,
   name                 varchar(100),
   path                 varchar(300),
   modifyTime           timestamp,
   modifier             varchar(50),
   content              blob,
   operateType          int,
   lastName             varchar(100),
   primary key (id)
);

drop table if exists category;

/*==============================================================*/
/* Table: category                                              */
/*==============================================================*/
create table category
(
   enName               varchar(100) not null,
   cnName               varchar(100),
   path                 varchar(100),
   parent               varchar(100),
   articleTemplate      varchar(500),
   indexTemplate        varchar(500),
   sort                 int,
   hidden               int,
   primary key (enName)
);
