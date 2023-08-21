create table projeto(
	id serial primary key,
	nome varchar(255) not null,
	descricao text not null,
	semestre int not null,
	ativo boolean default true
);
create table aluno(
	id serial primary key,
	nome varchar(255) not null,
	matricula varchar(50) not null
);
create table vinculo_aluno_projeto(
	id_aluno bigint not null,
	id_projeto bigint not null,
	primary key(id_aluno, id_projeto),
	foreign key(id_aluno) references aluno(id) on delete restrict,
	foreign key(id_projeto) references projeto(id) on delete restrict
);
create table nota_projeto(
	id serial primary key,
	nota decimal(8,2) not null,
	id_projeto bigint not null,
	foreign key(id_projeto) references projeto(id) on delete restrict
);
create table edicao(
	id serial primary key,
	numero bigint not null
);
create table nota_edicao_aluno_avaliador(
	id_aluno bigint not null,
	id_edicao bigint not null,
	avaliado boolean default true,
	primary key(id_aluno, id_edicao),
	foreign key(id_aluno) references aluno(id) on delete restrict,
	foreign key(id_edicao) references edicao(id) on delete restrict
);



----------------------------------------------




--VERIFICA SE ALUNO JÁ ESTÁ VINCULADO EM UM PROJETO ATIVO
create or replace function verifica_aluno_vinculado_projeto() returns TRIGGER as $$
declare existe int := 0;
begin
	existe := (select count(*) from aluno join vinculo_aluno_projeto ap on aluno.id = ap.id_aluno
								  join projeto on projeto.id = ap.id_projeto
								  where ap.id_aluno = NEW.id_aluno and projeto.ativo = true);
	if existe > 1 THEN 
		RAISE EXCEPTION 'aluno já está vinculado a um projeto';
	end if;
	return new;
end;
$$ 
language 'plpgsql';



--VERIFICA SE O PROJETO TEM MAIS DE 3 ALUNOS VINCULADOS
create or replace function verifica_total_integrantes_projeto() returns TRIGGER as $$
declare total_de_gente int;
begin								  
	select count(*) into total_de_gente from projeto p join vinculo_aluno_projeto ap on p.id = ap.id_projeto where p.id = NEW.id_projeto;

	if total_de_gente > 3 THEN 
		RAISE EXCEPTION 'projeto está lotado';
	end if;
	return new;
end;
$$ 
language 'plpgsql';



--USUÁRIO NÃO PODE VOTAR NO PRÓPRIO TRABALHO 
-- create or replace function verifica_avaliacao() returns TRIGGER as $$
-- declare tem_vinculo int := 0; ja_votou int := 0;
-- begin								  
-- 	select 1 into tem_vinculo from vinculo_aluno_projeto vap
-- 								join aluno on aluno.id = vap.id_aluno
-- 								join projeto on projeto.id = vap.id_projeto
-- 								where aluno.id in (select id_aluno from projeto p 
-- 				   									join vinculo_aluno_projeto vap on p.id = vap.id_projeto 
-- 				   									where vap.id_aluno = NEW.id_aluno 
-- 												    and vap.id_projeto = NEW.id_projeto);

-- 	if tem_vinculo > 0 THEN 
-- 		RAISE EXCEPTION 'aluno não pode votar em projeto que está vinculado';
-- 	end if;
						
-- 	ja_votou := (select count(*) from nota_edicao_aluno_avaliador nav
-- 									join aluno on aluno.id = nav.id_aluno
-- 									where nav.id_aluno = NEW.id_aluno
-- 									and nav.edicao = NEW.edicao 
-- 									and nav.id_projeto = NEW.id_projeto);

-- 	if ja_votou > 1 THEN 
-- 		RAISE EXCEPTION 'aluno já votou neste projeto nesta edição';
-- 	end if;
	
-- 	return new;
-- end;
-- $$ 
-- language 'plpgsql';



create trigger verifica_vinculo_aluno after insert or update on vinculo_aluno_projeto for each row execute procedure verifica_aluno_vinculado_projeto();
create trigger verifica_integrantes_projeto after insert or update on vinculo_aluno_projeto for each row execute procedure verifica_total_integrantes_projeto();
--create trigger verifica_avaliacao after insert or update on nota_projeto for each row execute procedure verifica_avaliacao();



insert into projeto(nome,descricao,semestre) 
	values('agronegócio','Evidentemente, a constante divulgação das informações é uma das consequências do orçamento setorial',1);
insert into projeto(nome,descricao,semestre) 
	values('pesquisa','A prática cotidiana prova que a valorização de fatores subjetivos auxilia a preparação e a composição do orçamento setorial',1);
insert into projeto(nome,descricao,semestre) 
	values('projeto 1000','É claro que o comprometimento entre as equipes assume importantes posições no estabelecimento dos modos de operação convencionais',1);
insert into projeto(nome,descricao,semestre) 
	values('projeto ensino','O cuidado em identificar pontos críticos na percepção das dificuldades promove a alavancagem das condições financeiras e administrativas exigidas',1);
insert into projeto(nome,descricao,semestre) 
	values('projeto extensão','Neste sentido, a necessidade de renovação processual faz parte de um processo de gerenciamento dos paradigmas corporativos',2);
insert into projeto(nome,descricao,semestre) 
	values('melhorias ruas da cidade','A prática cotidiana prova que a valorização de fatores subjetivos não pode mais se dissociar das formas de ação',2);
insert into projeto(nome,descricao,semestre) 
	values('pesquisa intenção de voto','Podemos já vislumbrar o modo pelo qual a percepção das dificuldades ainda não demonstrou convincentemente que vai participar na mudança dos relacionamentos verticais entre as hierarquias',2);
insert into projeto(nome,descricao,semestre) 
	values('previsão do tempo','Assim mesmo, a expansão dos mercados mundiais representa uma abertura para a melhoria dos métodos utilizados na avaliação de resultados',2);
insert into projeto(nome,descricao,semestre) 
	values('noticias','Acima de tudo, é fundamental ressaltar que a consolidação das estruturas estende o alcance e a importância dos paradigmas corporativo',1);


insert into aluno(nome,matricula) values('joao','493910042');
insert into aluno(nome,matricula) values('maria','6475674');
insert into aluno(nome,matricula) values('carlos','7867867');
insert into aluno(nome,matricula) values('fernanda','4547567674');
insert into aluno(nome,matricula) values('felix','079668567');
insert into aluno(nome,matricula) values('sandro','789567785');
insert into aluno(nome,matricula) values('claudio','542354343');
insert into aluno(nome,matricula) values('marcia','242342234');
insert into aluno(nome,matricula) values('diego','996854353');
insert into aluno(nome,matricula) values('roberto','131231243');
insert into aluno(nome,matricula) values('juan','2423423423');
insert into aluno(nome,matricula) values('carla','476657567');
insert into aluno(nome,matricula) values('jonas','746456333');
insert into aluno(nome,matricula) values('felipe','67567564');
insert into aluno(nome,matricula) values('cleusa','9789685');
insert into aluno(nome,matricula) values('joana','74563533');
insert into aluno(nome,matricula) values('rafaela','686786784');
insert into aluno(nome,matricula) values('tiago','7586755564');
insert into aluno(nome,matricula) values('tales','2132342354');
insert into aluno(nome,matricula) values('vitor','354565467');
insert into aluno(nome,matricula) values('douglas','78967856');
insert into aluno(nome,matricula) values('renato','856734231');

insert into edicao(numero) values(1);
insert into edicao(numero) values(2);


insert into vinculo_aluno_projeto values(1,1);
insert into vinculo_aluno_projeto values(2,1);
insert into vinculo_aluno_projeto values(3,1);
--insert into vinculo_aluno_projeto values(4,1);
insert into vinculo_aluno_projeto values(7,2);
insert into vinculo_aluno_projeto values(5,3);
insert into vinculo_aluno_projeto values(8,8);

begin;
	insert into nota_projeto(nota,id_projeto) values(8.22,1);
	insert into nota_edicao_aluno_avaliador(id_aluno,id_edicao) values(5,1);
commit;

begin;
	insert into nota_projeto(nota,id_projeto) values(7,3);
	insert into nota_edicao_aluno_avaliador(id_aluno,id_edicao) values(2,1);
commit;

--update projeto set ativo = false where id = 1
--select * from projeto 
--select * from aluno
--select * from vinculo_aluno_projeto
--select * from nota_projeto
--select * from nota_edicao_aluno_avaliador
--select * from edicao
-- select nav.id_aluno from nota_edicao_aluno_avaliador nav 
-- join aluno on aluno.id = nav.id_aluno
-- join vinculo_aluno_projeto v on v.id_aluno = aluno.id
-- where v.id_projeto = 3
-- join nota_projeto np on np.id_projeto = p.id

