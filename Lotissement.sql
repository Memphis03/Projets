/*==============================================================*/
/* Nom de SGBD :  Sybase SQL Anywhere 11                        */
/* Date de création :  3/28/2024 8:50:22 PM                     */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_CONCERNE_CONCERNE_PROJET') then
    alter table CONCERNE
       delete foreign key FK_CONCERNE_CONCERNE_PROJET
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_CONCERNE_CONCERNE2_PARCELLE') then
    alter table CONCERNE
       delete foreign key FK_CONCERNE_CONCERNE2_PARCELLE
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_INFRASTR_COMPORTE_PARCELLE') then
    alter table INFRASTRUCTURE
       delete foreign key FK_INFRASTR_COMPORTE_PARCELLE
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PARCELLE_INCLURE_TERRAIN') then
    alter table PARCELLE
       delete foreign key FK_PARCELLE_INCLURE_TERRAIN
end if;

if exists(
   select 1 from sys.systable 
   where table_name='CONCERNE'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table CONCERNE
end if;

if exists(
   select 1 from sys.systable 
   where table_name='INFRASTRUCTURE'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table INFRASTRUCTURE
end if;

if exists(
   select 1 from sys.systable 
   where table_name='PARCELLE'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table PARCELLE
end if;

if exists(
   select 1 from sys.systable 
   where table_name='PROJET'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table PROJET
end if;

if exists(
   select 1 from sys.systable 
   where table_name='TERRAIN'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table TERRAIN
end if;

/*==============================================================*/
/* Table : CONCERNE                                             */
/*==============================================================*/
create table CONCERNE 
(
   ID_PARCELLE          integer                        not null,
   ID_P                 integer                        not null,
   constraint PK_CONCERNE primary key (ID_PARCELLE, ID_P)
);

/*==============================================================*/
/* Table : INFRASTRUCTURE                                       */
/*==============================================================*/
create table INFRASTRUCTURE 
(
   ID_I                 integer                        not null,
   ID_PARCELLE          integer                        not null,
   TYPE                 char(20)                       not null,
   SUP_INFRACTRUCTURE   char(10)                       not null,
   constraint PK_INFRASTRUCTURE primary key (ID_I)
);

/*==============================================================*/
/* Table : PARCELLE                                             */
/*==============================================================*/
create table PARCELLE 
(
   ID_PARCELLE          integer                        not null,
   ID_TERRAIN           integer                        not null,
   SUP_PARCELLE         float                          not null,
   STATU                char(20)                       not null,
   constraint PK_PARCELLE primary key (ID_PARCELLE)
);

/*==============================================================*/
/* Table : PROJET                                               */
/*==============================================================*/
create table PROJET 
(
   ID_P                 integer                        not null,
   NOM                  char(20)                       not null,
   DESCRIPTION          char(1000)                     not null,
   DATE_DEBUT           date                           not null,
   DATE_FIN             date                           not null,
   constraint PK_PROJET primary key (ID_P)
);

/*==============================================================*/
/* Table : TERRAIN                                              */
/*==============================================================*/
create table TERRAIN 
(
   ID_TERRAIN           integer                        not null,
   SUPPERFICIE          float                          not null,
   COORDONNEE           integer                        not null,
   constraint PK_TERRAIN primary key (ID_TERRAIN)
);

alter table CONCERNE
   add constraint FK_CONCERNE_CONCERNE_PROJET foreign key (ID_P)
      references PROJET (ID_P)
      on update restrict
      on delete restrict;

alter table CONCERNE
   add constraint FK_CONCERNE_CONCERNE2_PARCELLE foreign key (ID_PARCELLE)
      references PARCELLE (ID_PARCELLE)
      on update restrict
      on delete restrict;

alter table INFRASTRUCTURE
   add constraint FK_INFRASTR_COMPORTE_PARCELLE foreign key (ID_PARCELLE)
      references PARCELLE (ID_PARCELLE)
      on update restrict
      on delete restrict;

alter table PARCELLE
   add constraint FK_PARCELLE_INCLURE_TERRAIN foreign key (ID_TERRAIN)
      references TERRAIN (ID_TERRAIN)
      on update restrict
      on delete restrict;

