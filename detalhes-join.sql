create table a(codigo);
create table b(codigo);
insert into a values(1);
insert into a values(2);
insert into a values(3);
insert into a values(4);
insert into a values(5);
insert into b values(1);
insert into b values(3);
insert into b values(5);
insert into b values(7);
select a.codigo from a left join b on a.codigo = b.codigo where b.codigo is null;
-- resultado 2,4 pois ao fazer inner join o resultado será 1,3,5 pois são os valores presentes em ambas as tabelas por causa do "on a.codigo = b.codigo"
--ao usar left join faz com que alem de trazer 1,3,5 traga também 2,4 mesmo que eles não tenham nenhuma semelhança (inner join) na tabela B eles vem no resultado por causa do left
--ao usar where b.codigo is null faz com que só venha os registros em que B.codigo é nulo que é no caso do 2,4 apenas pois 2,4 não tem correspondência em B
