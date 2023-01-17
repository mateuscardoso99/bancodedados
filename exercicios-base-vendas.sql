CREATE TABLE estado
(siglaestado char(2),
 nomestado varchar(50),
 primary key (siglaestado));
 
CREATE TABLE cidade
 (codcid int,
 nomcid varchar(50),
 siglaestado char(2),
 primary key(codcid),
 foreign key (siglaestado) references estado(siglaestado));
 
CREATE TABLE cliente
 (codcli int,
 nomcli varchar(100),
 codcid int,
 primary key (codcli),
 foreign key (codcid) references cidade(codcid));
 
CREATE TABLE tipo
 (codtipo int,
 nomtipo varchar(50),
 primary key(codtipo));
 
CREATE TABLE fabricante
(codfab int,
nomfab varchar(50),
primary key (codfab));

CREATE TABLE vendedor
(codvend int,
nomvend varchar(100),
primary key(codvend));

CREATE TABLE produto
(codprod int,
nomprod varchar(100),
valorprod numeric (12,2),
codfab int,
codtipo int,
primary key (codprod),
foreign key (codfab) references fabricante (codfab),
foreign key (codtipo) references tipo (codtipo));

CREATE TABLE compra
(codcompra int,
data_compra date,
codcli int,
codvend int,
primary key(codcompra),
foreign key (codcli) references cliente(codcli),
foreign key(codvend) references vendedor(codvend));

CREATE TABLE item_compra
(codcompra int,
codprod int,
quantidade int,
primary key(codcompra,codprod),
foreign key (codprod) references produto(codprod),
foreign key(codcompra) references compra(codcompra));

CREATE TABLE fornecedor
(codfornec int,
nomfornec varchar(100),
primary key(codfornec));

CREATE TABLE fornece
(codfornec int,
codprod int,
valor_prod_fornec numeric(14,2),
primary key(codfornec,codprod),
foreign key (codprod) references produto(codprod),
foreign key(codfornec) references fornecedor(codfornec));


insert into estado(siglaestado,nomestado)values('RS','santa maria');
insert into cidade(codcid,nomcid,siglaestado)values(1,'santa maria','RS'),(2,'caxias','RS');
insert into tipo(codtipo, nomtipo)values(1,'carnes'),(2,'frutas'),(3,'bebidas')
insert into cliente(codcli,nomcli,codcid)values(1,'joao',1),(2,'maria',2)
insert into fabricante(codfab,nomfab) values(1,'fabricante 1'),(2,'fabricante 2')
insert into vendedor(codvend,nomvend) values(1,'marcos'),(2,'carolina'),(3,'carlos')
insert into produto(codprod,nomprod,valorprod,codfab,codtipo) values(1,'frango',10.90,1,1);
insert into produto(codprod,nomprod,valorprod,codfab,codtipo) values(2,'uva',2.99,1,2);
insert into produto(codprod,nomprod,valorprod,codfab,codtipo) values(3,'banana',1.00,2,2);
insert into produto(codprod,nomprod,valorprod,codfab,codtipo) values(4,'lingua',14.20,2,1);
insert into produto(codprod,nomprod,valorprod,codfab,codtipo) values(5,'pera',6.89,1,2);
insert into produto(codprod,nomprod,valorprod,codfab,codtipo) values(6,'salsichao',26.09,2,1);
insert into compra(codcompra,data_compra,codcli,codvend)values(1,'2022-11-23',1,2);
insert into compra(codcompra,data_compra,codcli,codvend)values(2,'2022-09-09',2,1);
insert into compra(codcompra,data_compra,codcli,codvend)values(3,'2014-06-19',1,2);
insert into compra(codcompra,data_compra,codcli,codvend)values(4,'2018-07-11',1,2);
insert into item_compra(codcompra,codprod,quantidade) values(1,4,7);
insert into item_compra(codcompra,codprod,quantidade) values(2,2,4);
insert into item_compra(codcompra,codprod,quantidade) values(1,3,10);
insert into item_compra(codcompra,codprod,quantidade) values(3,5,8);
insert into item_compra(codcompra,codprod,quantidade) values(2,5,2);
insert into item_compra(codcompra,codprod,quantidade) values(1,1,3);
insert into item_compra(codcompra,codprod,quantidade) values(3,2,1);
insert into item_compra(codcompra,codprod,quantidade) values(4,6,1);
insert into fornecedor(codfornec,nomfornec) values(1,'fornecedor 1');
insert into fornecedor(codfornec,nomfornec) values(2,'fornecedor 2');
insert into fornecedor(codfornec,nomfornec) values(3,'HZL');
insert into fornece(codfornec,codprod,valor_prod_fornec)values(1,1,34.000);
insert into fornece(codfornec,codprod,valor_prod_fornec)values(1,2,1277.00);
insert into fornece(codfornec,codprod,valor_prod_fornec)values(2,3,10.00);
insert into fornece(codfornec,codprod,valor_prod_fornec)values(2,5,100.000);
insert into fornece(codfornec,codprod,valor_prod_fornec)values(1,4,58.00);
insert into fornece(codfornec,codprod,valor_prod_fornec)values(3,6,88.00);






--a) Listas os nomes dos clientes, com as datas de suas compras, os nomes dos produtos comprados e o nome do vendedor relacionado a compra. Ordenar pelo nome do cliente.
select cliente.nomcli, compra.data_compra, vendedor.nomvend, produto.nomprod 
from cliente join compra on compra.codcli = cliente.codcli
join vendedor on vendedor.codvend = compra.codvend
join item_compra on compra.codcompra = item_compra.codcompra
join produto on produto.codprod = item_compra.codprod
order by cliente.nomcli


--b) Listar os nomes dos produtos com os nomes dos produtos por eles fornecidos
SELECT produto.nomprod, fornecedor.nomfornec FROM produto, fornecedor, fornece
WHERE fornece.codprod = produto.codprod AND fornece.codfornec = fornecedor.codfornec


--c) Listar os nomes dos fornecedores que NÃO fornecem produtos do TIPO denominado “BRINQUEDOS”
select f.nomfornec from fornecedor f
where not exists(select f.nomfornec from tipo
		   	join produto on produto.codtipo = tipo.codtipo 
		   	join fornece on produto.codprod = fornece.codprod
		  	where f.codfornec = fornece.codfornec 
			and tipo.nomtipo='frutas')
---ou
select fornecedor.nomfornec from fornecedor
where fornecedor.codfornec not in( select fornecedor.codfornec from tipo
		   	join produto on produto.codtipo = tipo.codtipo 
		   	join fornece on produto.codprod = fornece.codprod
		  	join fornecedor on fornecedor.codfornec = fornece.codfornec 
			where tipo.nomtipo='frutas')



--d) Listar os nomes dos fabricantes, com o número de produtos que eles fabricam e o valor médio dos produtos de cada fabricante. Para calcular o valor médio considere a coluna valorprod da tabela produto
select fabricante.nomfab, count(*), avg(produto.valorprod) from produto join fabricante on produto.codfab = fabricante.codfab group by fabricante.nomfab
--sem group by nao funciona pois count(*) e avg() junto com uma coluna como o nome se perdem e não sabem o que contar ou baseado em que, por isso o agrupamento


--e) Listar os nomes dos tipos de produto com os nomes dos respectivos produtos.
--Aqui liste inclusive os nomes dos tipos que não possuam produtos cadastrados
select tipo.nomtipo, produto.nomprod from tipo left join produto on tipo.codtipo = produto.codtipo
--ou:
select tipo.nomtipo, produto.nomprod from produto right join tipo on tipo.codtipo = produto.codtipo


--f) Listar os nomes dos produtos com os nomes dos frabricantes e os nomes dos tipos de produto
select produto.nomprod, fabricante.nomfab, tipo.nomtipo from produto, fabricante, tipo
where produto.codfab = fabricante.codfab and produto.codtipo = tipo.codtipo


--g) Listar os nomes dos clientes que não compraram produtos do fornecedor denomidado HZL
select cliente.nomcli from cliente where cliente.nomcli not in(
	select cliente.nomcli from cliente 
	join compra on cliente.codcli = compra.codcli
	join item_compra on compra.codcompra = item_compra.codcompra
	join produto on produto.codprod = item_compra.codprod
	join fornece on produto.codprod = fornece.codprod
	join fornecedor on fornecedor.codfornec = fornece.codfornec
	where fornecedor.nomfornec = 'HZL'
)

--outra forma
--dica: fazer primeiro na consulta interna e depois negar ela

--nao precisa usar tabela de fora na consulta interna no not exists, apenas a variavel
select nomcli from
	cliente where codcli not in
		(select codcli from
		 compra, item_compra, produto, fornece, fornecedor
		 where compra.codcompra = item_compra.codcompra
		 and produto.codprod = item_compra.codprod
		 and produto.codprod = fornece.codprod
		 and fornecedor.codfornec = fornece.codfornec
		 and fornecedor.nomfornec = 'HZL'
		)
		
		
		
		
--h) Listar os nomes dos produtos mais caros
select valorprod from produto order by valorprod desc limit 3



--i) Listar os nomes dos vendedores que não auxiliaram em nenhuma compra
select vendedor.nomvend from vendedor where vendedor.nomvend not in(
	select vendedor.nomvend from vendedor join compra on vendedor.codvend = compra.codvend
)
--ou
select v.nomvend from vendedor v where not exists(
	select v.nomvend from vendedor join compra on v.codvend = compra.codvend
)

--outra forma
select nomvend from vendedor where not exists(select * from compra where compra.codvend = vendedor.codvend)




--j) Criar uma visão que contenha os nomes das cidades com mais de 500 clientes
create view viewCidades as
select cidade.nomcid, count(*) from cliente join cidade on cidade.codcid = cliente.codcid 
group by cidade.nomcid having count(cidade.nomcid) > 0

select * from viewCidades


--l) Listar os nomes dos produtos que NÃO foram comprados
select p.nomprod from produto p where not exists(select produto.nomprod from produto join item_compra on p.codprod = item_compra.codprod)
--ou
select produto.nomprod from produto where produto.codprod not in(select produto.codprod from produto join item_compra on produto.codprod = item_compra.codprod)
--ou
--nao precisa usar tabela produto na consulta interna apenas comparar com a variavel (p) com not exists
select p.nomprod from produto p where not exists(select item_compra.codprod from item_compra where p.codprod = item_compra.codprod)



--m) Listar o(s) nome(s) do(s) produto(s) mais baratos
select produto.nomprod, produto.valorprod from produto order by produto.valorprod asc limit 3
--ou
select produto.nomprod from produto where produto.valorprod = (select min(valorprod) from produto)


--n) Listar os nomes das cidades com os nomes dos clientes. Listar inclusive as cidades que não possuem clientes cadastrados. 
select cidade.nomcid, cliente.nomcli from cidade left join cliente on cliente.codcid = cidade.codcid



-------------------------------------------------------------------

select fornecedor.nomfornec, tipo.nomtipo from fornecedor
join fornece on fornecedor.codfornec = fornece.codfornec
join produto on produto.codprod = fornece.codprod
join tipo on produto.codtipo = tipo.codtipo group by fornecedor.nomfornec, tipo.nomtipo
--vai criar no resultado uma linha pra cada combinação de fornecedor.nomfornec e tipo.nomtipo ex:
--fornecedor 1 carnes
--fornecedor 1 frutas
--fornecedor 2 frutas
--fornecedor 2 carnes




select p.nomprod from produto p where not exists(select item_compra.codprod from item_compra where p.codprod = item_compra.codprod)
/*com not exists nao tem problema de na consulta interna retornar um valor de um tipo diferente da consulta externa*/



select produto.nomprod from produto where produto.codprod not in(select produto.codprod from produto join item_compra on produto.codprod = item_compra.codprod)
/*
na consulta encadeada se a tabela produto tem 50 linhas essa consulta acima será executada pra cada linha da tabela
então ele vai na linha 1 executa a consulta e verifica se a linha corresponde ao padrao da consulta que é not in
depois vai na linha 2 e faz o mesmo, na linha 3 e faz o mesmo e assim por diante, nesse caso, ao todo serão 100 consultas
*/
