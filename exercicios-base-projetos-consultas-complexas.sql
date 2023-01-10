
/*
Demonstre passo a passo a aplicação de cada uma das formas normais (1FN, 2FN e 3FN).
Depois crie as tabelas usando SQL. Usando SQL coloque o conteúdo mostrado no relatório
dos projetos de pesquisa. Depois execute as instruções SQL solicitadas

Projetos de Pesquisa
Cód. professor: 001 Nome professor: Fulano de Tal
	Cód. projeto Nome projeto Número de bolsistas do projeto Horas do professor no projeto
		100 		Projeto100 				25 								3h
 		200 		Projeto200 				50								1h
		
Cód. professor: 002 Nome professor: Beltrano de Tal
	Cód. projeto Nome projeto Número de bolsistas do projeto Horas do professor no projeto
		100 		Projeto100 				25 								1h
 		200			Projeto200 				50								3h

Cód. professor: 003 Nome professor: Siclano de Tal
	Cód. projeto Nome projeto Número de bolsistas do projeto Horas do professor no projeto
		100 		Projeto100 				25 								2h
 		300 		Projeto300 				40								5h


1FN:
(codprofessor, nomeprofessor) pk: codprofessor
(codproj, codprofessor, nomeproj, num_bolsistas, hrs_prof) pk: codproj, codprofessor

2FN:
(codprofessor, nomeprofessor) pk: codprofessor
(codproj, codprofessor, num_bolsistas, hrs_prof) pk: codproj, codprofessor
(codproj, nomeproj) pk: codproj

3FN:
nada a fazer


*/
 


create table professor(
codprofessor int,
nomeprofessor varchar(100),
primary key(codprofessor)
);

create table projeto(
codproj int,
nomeproj varchar(100),
primary key(codproj)
);

create table projeto_professor(
codproj int,
codprofessor int,
num_bolsistas int,
hrs_prof int,
primary key(codproj, codprofessor)
);

insert into professor(codprofessor,nomeprofessor)values(1,'joao');
insert into professor(codprofessor,nomeprofessor)values(2,'maria');
insert into projeto(codproj,nomeproj)values(1,'prj 1');
insert into projeto(codproj,nomeproj)values(2,'prj 2');
insert into projeto_professor(codproj,codprofessor,num_bolsistas,hrs_prof)values(1,1,34,66);
insert into projeto_professor(codproj,codprofessor,num_bolsistas,hrs_prof)values(2,2,4,2);
insert into projeto_professor(codproj,codprofessor,num_bolsistas,hrs_prof)values(1,2,9,12);
insert into projeto_professor(codproj,codprofessor,num_bolsistas,hrs_prof)values(2,1,2,22);


--Listar os nomes dos professores com os nomes dos projetos
select professor.nomeprofessor, projeto.nomeproj from projeto
join projeto_professor on projeto.codproj = projeto_professor.codproj
join professor on projeto_professor.codprofessor = professor.codprofessor


--Listar os nomes dos projetos com o número de professores e a média de horas dos professores nos projetos
select pr.nomeprofessor, projeto.nomeproj, 
(select avg(projeto_professor.hrs_prof) from projeto
join projeto_professor on projeto.codproj = projeto_professor.codproj
join professor on projeto_professor.codprofessor = professor.codprofessor
where professor.nomeprofessor= pr.nomeprofessor) as media 
from projeto
join projeto_professor on projeto.codproj = projeto_professor.codproj
join professor pr on projeto_professor.codprofessor = pr.codprofessor
group by pr.nomeprofessor, projeto.nomeproj


-- select avg(projeto_professor.hrs_prof) from projeto
-- join projeto_professor on projeto.codproj = projeto_professor.codproj
-- join professor on projeto_professor.codprofessor = professor.codprofessor
-- where professor.nomeprofessor='joao'

