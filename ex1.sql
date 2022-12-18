/*
Considere este modelo lógico:

CURSO (codcurso, nomecurso)
ALUNO (codaluno,nomealuno, codcurso )
	codcurso referencia CURSO(codcurso)

Envie um arquivo que tenha os comando em SQL para:

1) Criar as tabelas

2) Inserir dados na tabelas (2 linhas em cada)

3) Listar o conteúdo das tabelas
*/

create table curso(
	codcurso serial,
	nomecurso varchar(255) not null,
	primary key(codcurso)
);

create table aluno(
	codaluno serial,
	nomealuno varchar(255) not null,
	codcurso int,
	primary key(codaluno),
	foreign key(codcurso) references curso (codcurso)
);

insert into curso(nomecurso) values('fisica');
insert into aluno(nomealuno,codcurso) values('joao',1),('carlos',1)
select * from curso
select * from aluno
