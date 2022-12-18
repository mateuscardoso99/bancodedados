CREATE TABLE estande (
    codest integer NOT NULL,
    nomest character varying(100),
    val_aluguel numeric(12,2),
    codfiscal integer
);

CREATE TABLE estande_produto (
    codprod integer NOT NULL,
    codest integer NOT NULL,
    val_produto_estande numeric(12,2)
);

CREATE TABLE fiscal (
    codfiscal integer NOT NULL,
    nomfiscal character varying(50),
    salario numeric(12,2)
);


CREATE TABLE produto (
    codprod integer NOT NULL,
    nomprod character varying(50)
);



ALTER TABLE ONLY estande
    ADD CONSTRAINT estande_pkey PRIMARY KEY (codest);

ALTER TABLE ONLY estande_produto
    ADD CONSTRAINT estande_produto_pkey PRIMARY KEY (codprod, codest);

ALTER TABLE ONLY fiscal
    ADD CONSTRAINT fiscal_pkey PRIMARY KEY (codfiscal);

ALTER TABLE ONLY produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (codprod);

ALTER TABLE ONLY estande
    ADD CONSTRAINT estande_codfiscal_fkey FOREIGN KEY (codfiscal) REFERENCES fiscal(codfiscal);

ALTER TABLE ONLY estande_produto
    ADD CONSTRAINT estande_produto_codest_fkey FOREIGN KEY (codest) REFERENCES estande(codest);

ALTER TABLE ONLY estande_produto
    ADD CONSTRAINT estande_produto_codprod_fkey FOREIGN KEY (codprod) REFERENCES produto(codprod);


insert into fiscal (codfiscal,nomfiscal,salario) values(002,'Beltrano de tal',7000.00)
insert into fiscal (codfiscal,nomfiscal,salario) values(003,'Fulano de tal',4000.00)

insert into produto(codprod,nomprod) values(002,'Brigadeiro');
insert into produto(codprod,nomprod) values(003,'Camafeu');
insert into produto(codprod,nomprod) values(007,'Pastel de Santa Clara');

insert into estande(codest,nomest,val_aluguel,codfiscal) values(001,'Estande da Princesa',400,003);
insert into estande(codest,nomest,val_aluguel,codfiscal) values(002,'Estande do Rei',190,002);
insert into estande(codest,nomest,val_aluguel,codfiscal) values(003,'Estande do Doce',122.90,002);

insert into estande_produto(codprod,codest,val_produto_estande) values(002,001,4)
insert into estande_produto(codprod,codest,val_produto_estande) values(003,001,5)
insert into estande_produto(codprod,codest,val_produto_estande) values(007,001,7)
insert into estande_produto(codprod,codest,val_produto_estande) values(002,002,4)
insert into estande_produto(codprod,codest,val_produto_estande) values(003,002,6)
insert into estande_produto(codprod,codest,val_produto_estande) values(002,003,4.50)
insert into estande_produto(codprod,codest,val_produto_estande) values(003,003,6.50)

/*
1)Listar os dados dos fiscais
2)Listar o número de fiscais cadastrados
3)Listar a média do salário dos fiscais
4)Listar os nomes dos fiscais ordenando pelo salário
5)Listar os nomes dos fiscais com os nomes dos estandes
6)Listar os nomes dos estantes, com os nomes dos produtos e o valor dos produtos em cada estandes
*/

/*
1)Listar os dados dos fiscais
*/
select * from fiscal

/*
2)Listar o número de fiscais cadastrados
*/
select count(*) from fiscal

/*
3)Listar a média do salário dos fiscais
*/
select avg(salario) media from fiscal

/*
4)Listar os nomes dos fiscais ordenando pelo salário
*/
select nomfiscal from fiscal order by salario asc

/*
5)Listar os nomes dos fiscais com os nomes dos estandes
*/
select nomfiscal, nomest from fiscal inner join estande on fiscal.codfiscal = estande.codfiscal

/*
6)Listar os nomes dos estantes, com os nomes dos produtos e o valor dos produtos em cada estandes
*/
select nomest, nomprod, val_produto_estande from estande 
	join estande_produto on estande.codest = estande_produto.codest
	join produto on produto.codprod = estande_produto.codprod