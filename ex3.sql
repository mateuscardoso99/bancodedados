create table cidade(
	codcid int,
	nomcid varchar(50),
	website varchar(200),
	numhabitantes int,
	primary key (codcid)
);

insert into cidade (codcid,nomcid) values (1,'Camaqua');
insert into cidade (codcid,nomcid) values (2,'Jaguarao');
insert into cidade (codcid,nomcid) values (3,'Herval');

create table especialidade(
	codesp int,
	nomesp varchar(50),
	descesp varchar(200),
	primary key (codesp)
);

insert into especialidade (codesp,nomesp) values (1,'Cozinha Italiana');
insert into especialidade (codesp,nomesp) values (2,'Cozinha Jamaicana');
insert into especialidade (codesp,nomesp) values (3,'Cozinha Uruguaia');


create table restaurante(
	codres int,
	nomres varchar(50),
	email varchar(200),
	endereco varchar(100),
	fone int,
	codcid int,
	primary key(codres),
	foreign key (codcid) references cidade(codcid)
);

insert into restaurante (codres, nomres,codcid) values (1,'R. da Nona',2);
insert into restaurante (codres, nomres,codcid) values (2,'R. da Abuela',2);
insert into restaurante (codres, nomres,codcid) values (3,'R. do Nono',1);
insert into restaurante (codres, nomres,codcid) values (4,'R. do Dindo',1);
insert into restaurante (codres, nomres,codcid) values (5,'R. da Dinda',3);


create table restaurante_especialidade(
	codesp int,
	codres int,
	primary key (codesp, codres),
	foreign key (codesp) references especialidade (codesp),
	foreign key (codres) references restaurante (codres)
);

insert into restaurante_especialidade(codesp,codres) values (1,3);
insert into restaurante_especialidade(codesp,codres) values (1,1);
insert into restaurante_especialidade(codesp,codres) values (1,2);
insert into restaurante_especialidade(codesp,codres) values (2,3);
insert into restaurante_especialidade(codesp,codres) values (3,3);
insert into restaurante_especialidade(codesp,codres) values (2,2);
insert into restaurante_especialidade(codesp,codres) values (2,1);
insert into restaurante_especialidade(codesp,codres) values (1,4);

/*
1) Listar os nomes dos restaurantes
2) Listar os nomes dos restaurantes com os nomes das cidades onde eles estão localizados
3) Listar os nomes dos restaurantes que são da cidade denominada Herval (SQL)
4) Listar os nomes dos restaurantes com os nomes de suas especialidades
5) Listar os nomes dos restaurantes especializados em Cozinha Italiana (SQL)
6) Listar os nomes dos restaurantes com os nomes de suas especialidades e com os nomes das cidades onde eles estão localizados (SQL)
7) Listar quantos restaurantes estão cadastrados (SQL)
8) Listar quantos restaurantes especializados em Cozinha Italiana
*/


/*1) Listar os nomes dos restaurantes*/
select nomres from restaurante

/*2) Listar os nomes dos restaurantes com os nomes das cidades onde eles estão
localizados*/
select nomres, nomcid from restaurante inner join cidade on restaurante.codcid = cidade.codcid

/*3) Listar os nomes dos restaurantes que são da cidade denominada Herval (SQL)*/
select nomres from restaurante join cidade on cidade.codcid = restaurante.codcid where nomcid = 'Herval'

/*4) Listar os nomes dos restaurantes com os nomes de suas especialidades*/
select nomres, nomesp from restaurante 
	join restaurante_especialidade on restaurante.codres = restaurante_especialidade.codres
	join especialidade on especialidade.codesp = restaurante_especialidade.codesp

/*5) Listar os nomes dos restaurantes especializados em Cozinha Italiana (SQL)*/
select nomres from restaurante 
	join restaurante_especialidade on restaurante.codres = restaurante_especialidade.codres
	join especialidade on restaurante_especialidade.codesp = especialidade.codesp
	where especialidade.nomesp = 'Cozinha Italiana'
	
	
/*6) Listar os nomes dos restaurantes com os nomes de suas especialidades e com os
nomes das cidades onde eles estão localizados (SQL)*/
select nomres, nomesp, nomcid from restaurante
	join restaurante_especialidade on restaurante.codres = restaurante_especialidade.codres
	join especialidade on especialidade.codesp = restaurante_especialidade.codesp
	join cidade on restaurante.codcid = cidade.codcid
	
	
/*7) Listar quantos restaurantes estão cadastrados (SQL)*/
select count(*) from restaurante

/*8) Listar quantos restaurantes especializados em Cozinha Italiana*/
select count(*) from restaurante
	join restaurante_especialidade on restaurante.codres = restaurante_especialidade.codres
	join especialidade on especialidade.codesp = restaurante_especialidade.codesp
	where especialidade.nomesp = 'Cozinha Italiana'








select nomres, nomesp, nomcid from restaurante
	join restaurante_especialidade on restaurante.codres = restaurante_especialidade.codres
	join especialidade on especialidade.codesp = restaurante_especialidade.codesp
	join cidade on restaurante.codcid = cidade.codcid
/*
resultado:
R. do Nono		Cozinha Italiana	Camaqua
R. da Nona		Cozinha Italiana	Jaguarao
R. da Abuela	Cozinha Italiana	Jaguarao
R. do Nono		Cozinha Jamaicana	Camaqua
R. do Nono		Cozinha Uruguaia	Camaqua
R. da Abuela	Cozinha Jamaicana	Jaguarao
R. da Nona		Cozinha Jamaicana	Jaguarao
R. do Dindo		Cozinha Italiana	Camaqua
*/



select restaurante.nomres, STRING_AGG(especialidade.nomesp,', '), cidade.nomcid from restaurante
	join restaurante_especialidade on restaurante.codres = restaurante_especialidade.codres
	join especialidade on especialidade.codesp = restaurante_especialidade.codesp
	join cidade on restaurante.codcid = cidade.codcid
	group by restaurante.nomres, cidade.nomcid
/*
resultado:
R. da Abuela	Cozinha Jamaicana, Cozinha Italiana						Jaguarao
R. da Nona		Cozinha Jamaicana, Cozinha Italiana						Jaguarao
R. do Dindo		Cozinha Italiana										Camaqua
R. do Nono		Cozinha Uruguaia, Cozinha Jamaicana, Cozinha Italiana	Camaqua

coloca na mesma linha as duplicidades
*/


/*
outra forma usando array_agg()
exemplo retorno: {"Cozinha Jamaicana","Cozinha Italiana"}
*/
select restaurante.nomres, array_agg(especialidade.nomesp), cidade.nomcid from restaurante
	join restaurante_especialidade on restaurante.codres = restaurante_especialidade.codres
	join especialidade on especialidade.codesp = restaurante_especialidade.codesp
	join cidade on restaurante.codcid = cidade.codcid
	group by restaurante.nomres, cidade.nomcid