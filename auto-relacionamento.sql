CREATE TABLE PESSOA
	(codpessoa int,
	 nompessoa varchar(50),
	 dtnasc date,
	 email varchar(50),
	 senha varchar(50),
	 primary key (codpessoa));
	 
create table FOTO
	(codfoto int,
	 descfoto varchar(50),
	 foto oid,
	 codpessoa int,
	 foreign key (codpessoa) references pessoa(codpessoa),
	 primary key (codfoto));

create table MARCADA
	 (codpessoa int,
	 codfoto int,
	  data_hora timestamp,
	 foreign key (codpessoa) references pessoa(codpessoa),
	 foreign key (codfoto) references foto(codfoto),
	 primary key(codpessoa, codfoto));

CREATE TABLE MSG
	(codmsg int,
	 texto_msg varchar(50),
	 data_hora_msg timestamp,
	 codpessoa int,
	 foreign key (codpessoa) references pessoa(codpessoa),
	 primary key (codmsg));
	
create table CURTIU
	 (codpessoa int,
	 codmsg int,
	 foreign key (codpessoa) references pessoa(codpessoa),
	 foreign key (codmsg) references msg(codmsg),
	 primary key(codpessoa, codmsg));

create table AMIZADE
	(codpessoa1 int,
	 codpessoa2 int,
	 foreign key (codpessoa1) references pessoa(codpessoa),
	 foreign key (codpessoa2) references pessoa(codpessoa),
	 PRIMARY KEY (codpessoa1, codpessoa2));
	 
insert into pessoa (codpessoa, nompessoa) 
values (1,'fulano');
insert into pessoa (codpessoa, nompessoa) 
values (2,'beltrano');
insert into pessoa (codpessoa, nompessoa) 
values (3,'siclano');
insert into pessoa (codpessoa, nompessoa) 
values (4,'pessoa 4');
select * from pessoa;
insert into amizade values (1,2);
insert into amizade values (1,3);
insert into amizade values (2,4);
insert into amizade values (2,3);

select * from amizade;


select pessoa1.nompessoa, pessoa2.nompessoa
		from pessoa as pessoa1,
			 pessoa as pessoa2,
			 amizade
			 where
			 pessoa1.codpessoa = amizade.codpessoa1
			 and
			 pessoa2.codpessoa = amizade.codpessoa2;







	 
	 
	 