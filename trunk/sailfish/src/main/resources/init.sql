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

drop table if exists article;

/*==============================================================*/
/* Table: article                                               */
/*==============================================================*/
create table article
(
   id                   int not null auto_increment,
   category             varchar(100) comment '栏目代码',
   title                varchar(200) comment '标题',
   content              BLOB comment '内容',
   createTime           timestamp comment '创建时间',
   modifyTime           timestamp comment '更新时间',
   status               int comment '0:未发表 1:已发表 2:已删除',
   creater              varchar(100) comment '创建人',
   starLevel            int comment '星级',
   primary key (id)
);

drop table if exists article_static;

/*==============================================================*/
/* Table: article_static                                        */
/*==============================================================*/
create table article_static
(
   id                   integer not null,
   htmlPath             varchar(500) comment '更新时间',
   modifyTime           timestamp comment '更新时间',
   primary key (id)
);