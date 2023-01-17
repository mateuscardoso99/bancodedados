create table cidade
(codcid int,
 nomcid varchar(50),
 primary key (codcid));

create table cultura
(codcultura int,
 nomcultura varchar(50),
 primary key (codcultura));

create table producao
(codcultura int,
codcid int,
ano int,
qtde_producao int,
foreign key (codcultura) references cultura (codcultura),
foreign key (codcid) references cidade(codcid),
primary key (codcultura, codcid, ano));


insert into cultura (codcultura,nomcultura) values (1,'SOJA');
insert into cultura (codcultura,nomcultura) values (2,'MILHO');
insert into cultura (codcultura,nomcultura) values (3,'ARROZ');

insert into cidade (codcid, nomcid) values (1,'Arroio Grande');
insert into cidade (codcid, nomcid) values (2,'Jaguarão');
insert into cidade (codcid, nomcid) values (3,'Santa Maria');

insert into producao (codcultura,codcid,ano,qtde_producao) values (3,1,2012,255129);
insert into producao (codcultura,codcid,ano,qtde_producao) values (3,2,2012,168629);
insert into producao (codcultura,codcid,ano,qtde_producao) values (3,3,2012,200000);

insert into producao (codcultura,codcid,ano,qtde_producao) values (2,1,2012,40000);
insert into producao (codcultura,codcid,ano,qtde_producao) values (2,2,2012,50000);
insert into producao (codcultura,codcid,ano,qtde_producao) values (2,3,2012,45000);

insert into producao (codcultura,codcid,ano,qtde_producao) values (1,1,2012,340000);
insert into producao (codcultura,codcid,ano,qtde_producao) values (1,2,2012,350000);
insert into producao (codcultura,codcid,ano,qtde_producao) values (1,3,2012,345000);

insert into producao (codcultura,codcid,ano,qtde_producao) values (3,1,2013,355129);
insert into producao (codcultura,codcid,ano,qtde_producao) values (3,2,2013,368629);
insert into producao (codcultura,codcid,ano,qtde_producao) values (3,3,2013,300000);

insert into producao (codcultura,codcid,ano,qtde_producao) values (2,1,2013,30000);
insert into producao (codcultura,codcid,ano,qtde_producao) values (2,2,2013,40000);
insert into producao (codcultura,codcid,ano,qtde_producao) values (2,3,2013,35000);

insert into producao (codcultura,codcid,ano,qtde_producao) values (1,1,2013,440000);
insert into producao (codcultura,codcid,ano,qtde_producao) values (1,2,2013,450000);
insert into producao (codcultura,codcid,ano,qtde_producao) values (1,3,2013,445000);

/*views sao como tabelas virtuais
pode usar o resultado da consulta em outras consultas diminuindo a complexidade, afinal você fará referência a uma tabela virtual montada fora desta consulta. 
De uma certa forma podemos considerar como syntax sugar para uma query. Você tem uma visão mais limitada dos dados sem grandes preocupações.
*/

CREATE VIEW v_cidade AS SELECT * FROM cidade
select * from v_cidade