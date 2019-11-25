use trabalho_final;

--- Alterar para InnoDB
ALTER TABLE cidade ENGINE = InnoDB;
ALTER TABLE contato ENGINE = InnoDB;
ALTER TABLE endereco ENGINE = InnoDB;
ALTER TABLE estado ENGINE = InnoDB;
ALTER TABLE funcionario_cliente ENGINE = InnoDB;
ALTER TABLE historico ENGINE = InnoDB;
ALTER TABLE pessoa ENGINE = InnoDB;
ALTER TABLE pessoa_cliente ENGINE = InnoDB;

SET FOREIGN_KEY_CHECKS=0;
--- Alteração tabela cliente
alter table cliente
DROP key `fk_CLIENTE_CATEGORIA1`, -- remoção do index antigo
	add index `IDX_CLIENTE_&_CATEGORIA` (ID_CATEGORIA), -- criação do novo index
    add Constraint `fk_CLIENTE_&_CATEGORIA` foreign key (ID_CATEGORIA) references categoria(ID_CATEGORIA) 
    on update restrict on delete restrict;
    
---  Alteração tabela cidades   
alter table cidade
DROP key `ESTADO_CIDADE_FK`, -- remoção do index antigo
	add index `IDX_CIDADE_ESTADO` (ID_ESTADO), -- criação do novo index 
    add Constraint `fk_CIDADE_&_ESTADO` foreign key (ID_ESTADO) references estado(ID_ESTADO) 
    on update cascade on delete cascade;    

---  Alteração tabela contato 
alter table contato
DROP key `fk_CONTATO_PESSOA1`,
DROP key `fk_CONTATO_CLIENTE1`,  -- remoção do index antigo
	add index `IDX_CONTATO_&_PESSOA` (ID_PESSOA), -- criação do novo index
    add index `IDX_CONTATO_&_CLIENTE` (ID_CLIENTE),
    add Constraint `fk_CONTATO_&_PESSOA` foreign key (ID_PESSOA) references pessoa(ID_PESSOA) 
    on update cascade on delete restrict,
    add Constraint `fk_CONTATO_&_CLIENTE` foreign key (ID_CLIENTE) references cliente(ID_CLIENTE) 
    on update cascade on delete restrict;

--- Alteração tabela contrato
alter table contrato
DROP key `fk_CONTRATO_CLIENTE1`,
DROP key `fk_CONTRATO_PESSOA1`,
DROP key `fk_CONTRATO_FORMA_PAGAMENTO1`,  -- remoção do index antigo
	add index `IDX_CONTRATO_&_CLIENTE` (ID_CLIENTE), -- criação do novo index
    add index `IDX_CONTRATO_&_PESSOA` (ID_PESSOA),
    add index `IDX_CONTRATO_&_FORMA_PAG` (ID_FORMA_PAGAMENTO),
    add Constraint `fk_CONTRATO_&_CLIENTE` foreign key (ID_CLIENTE) references cliente(ID_CLIENTE) 
    on update cascade on delete restrict,
    add Constraint `fk_CONTRATO_&_PESSOA` foreign key (ID_PESSOA) references pessoa(ID_PESSOA) 
    on update cascade on delete restrict,
    add Constraint `fk_CONTRATO_&_FORMA_PAG` foreign key (ID_FORMA_PAGAMENTO) references forma_pagamento(ID_FORMA_PAGAMENTO) 
    on update cascade on delete restrict;


--- Alteração tabela contrato_servicos
alter table contrato_servicos
DROP key `fk_CONTRATO_SERVICOS_SERVICOS1`,
DROP key `fk_CONTRATO_SERVICOS_CONTRATO1`,
	 add index `IDX_CONTSERV_&_SERVICOS` (ID_SERVICOS),
     add index `IDX_CONTSERV_&_CONTRATO` (ID_CONTRATO),
	 add Constraint `fk_CONTSERV_&_SERVICOS` foreign key (ID_SERVICOS) references servicos(ID_SERVICOS) 
     on update cascade on delete restrict,
     add Constraint `IDX_CONTSERV_&_CONTRATO` foreign key (ID_CONTRATO) references contrato(ID_CONTRATO) 
     on update cascade on delete restrict;

--- Alteração tabela endereco
alter table endereco
DROP key `fk_ENDERECO_PESSOA1`,
DROP key `fk_ENDERECO_CLIENTE1`,
	 add index `IDX_ENDERECO_&_PESSOA` (ID_PESSOA),
	 add index `IDX_ENDERECO_&_CLIENTE` (ID_CLIENTE),
     add index `IDX_ENDERECO_&_CIDADE` (ID_CIDADE),
     add Constraint `fk_ENDERECO_&_PESSOA` foreign key (ID_PESSOA) references pessoa(ID_PESSOA) 
     on update cascade on delete restrict,
     add Constraint `fk_ENDERECO_&_CLIENTE` foreign key (ID_CLIENTE) references cliente(ID_CLIENTE) 
     on update cascade on delete restrict,
     add Constraint `fk_ENDERECO_&_CIDADE` foreign key (ID_CIDADE) references cidade(ID_CIDADE) 
     on update cascade on delete restrict;



--- Alteração tabela estado
alter table estado
DROP key `PAIS_ESTADO_FK`,
	add index `IDX_ESTADO_&_PAIS` (ID_PAIS);

--- Alteração tabela funcionario_cliente   
alter table funcionario_cliente
	add index `IDX_FUNCIONARIO_&_CLIENTE` (ID_CLIENTE),
    add Constraint `fk_FUNCIONARIO_&_CLIENTE` foreign key (ID_CLIENTE) references cliente(ID_CLIENTE) 
	on update cascade on delete restrict;
    
--- Alteração tabela historico
alter table historico
DROP key `fk_HISTORICO_CLIENTE1`,
DROP key `fk_HISTORICO_PESSOA1`,
	add index `IDX_HISTORICO_&_CLIENTE` (ID_CLIENTE),
    add index `IDX_HISTORICO_&_PESSOA`(ID_PESSOA),
    add Constraint `fk_HISTORICO_&_CLIENTE` foreign key (ID_CLIENTE) references cliente(ID_CLIENTE) 
	on update cascade on delete restrict,
    add Constraint `fk_HISTORICO_&_PESSOA` foreign key (ID_PESSOA) references pessoa(ID_PESSOA)
	on update cascade on delete restrict;
    
--- Alteração tabela parcelas
alter table parcelas
DROP key `fk_PARCELAS_CONTRATO1`, 
	add index  `IDX_PARCELAS_&_CONTRATO`(ID_CONTRATO),
    add Constraint `fk_PARCELAS_&_CONTRATO` foreign key (ID_CONTRATO) references contrato(ID_CONTRATO) 
	on update cascade on delete restrict;

--- Alteração tabela pessoa_cliente
alter table pessoa_cliente
DROP key `fk_PESSOA_CLIENTE_CLIENTE1`,
DROP key `fk_PESSOA_CLIENTE_PESSOA1`,
	add index `IDX_PESSOA_&_CLIENTE` (ID_CLIENTE),
    add index `IDX_PESSOA_&_PESSOA` (ID_PESSOA),
	add Constraint `fk_PESSOA_&_CLIENTE` foreign key (ID_CLIENTE) references cliente(ID_CLIENTE)
	on update cascade on delete restrict,
    add Constraint `fk_PESSOA_&_PESSOA` foreign key (ID_PESSOA) references pessoa(ID_PESSOA)
	on update cascade on delete restrict;
    
/*Mudanças e atualizações*/ 

--- CRIAÇÃO DA TABELA PAIS
DROP TABLE IF EXISTS `pais`;
CREATE TABLE `pais`(
  `ID_PAIS` int(11) AUTO_INCREMENT,
  `NOME_PAIS` char(255) DEFAULT NULL,
  PRIMARY KEY (`ID_PAIS`)
  )ENGINE=InnoDB;
  
--- Inserção --do pais   
INSERT INTO pais 
(ID_PAIS, NOME_PAIS)
VALUES (1, 'BRASIL');

 --- Alteração da tabela estado
 alter table estado
	add Constraint `fk_ESTADO_&_PAIS` foreign key (ID_PAIS) references pais(ID_PAIS)
	on update cascade on delete cascade;
    
insert into estado
(ID_PAIS)
value (1);

/*Criação da tabela Cliente_Endereco*/
DROP TABLE IF EXISTS `endereco_cliente`;
CREATE TABLE `endereco_cliente`(
  `ID_ENDERECO` int(11) NOT NULL,
  `ID_CLIENTE` int(11) NOT NULL,
  PRIMARY KEY (`ID_ENDERECO`,`ID_CLIENTE`),
  index `IDX_ENDCLIENTE_&_ENDERECO` (ID_ENDERECO),
  index `IDX_ENDCLIENTE_&_CLIENTE` (ID_CLIENTE),
  Constraint `fk_ENDCLIENTE_&_ENDERECO` foreign key (ID_ENDERECO) references endereco(ID_ENDERECO)
  on update cascade on delete restrict,
  Constraint `fk_ENDCLIENTE_&_CLIENTE` foreign key (ID_CLIENTE) references cliente(ID_CLIENTE)
  on update cascade on delete restrict
  )ENGINE=InnoDB;

INSERT INTO endereco_cliente (ID_ENDERECO,ID_CLIENTE)
select ID_ENDERECO,ID_CLIENTE from endereco where id_endereco = id_cliente;
	
                       /*Fase 02–Desenvolva as seguintes operações na banco de dados:*/
SET FOREIGN_KEY_CHECKS=1;
/*Montar script para as seguintes operações:
 Inclusão (verificar tabelas periféricas)
o Incluir 3 novos clientes;*/

insert into cliente
VALUES 
(6834,'Cliente 6834','Cliente Fantasia 6834','18.888.177/2222-32','24.51-6-10','Comércios de artefatos têxteis e peças do vestuário','Maria Bala','',100,'201-12-02',1,3,'(47) 3349-1638','Cliente chato',1,'CONTABILIDADE CASADORES','(47) 3330-0187','contabil@casadores.com'),
(6835,'Cliente 6835','Cliente Fantasia 6835','12.639.154/1892-34','47.55-8-12','Comércio de Games','Maria Bala','',4,'2015-12-02',1,3,'(47) 2883-5820','Cliente doido',1,'CONTABILIDADE BNU','(47) 3330-0083','contabil_bnu@contabilbnu.com'),
(6836,'Cliente 6836','Cliente Fantasia 6836','18.983.188/5554-83','87.68-9-56','Seguros altomotivos','Juka Bala','',83,'2015-12-02',1,4,'(47) 8356-25525','Cliente lokaço',1,'CONTABILIDADE BEIRA RIO','(47) 99993-8583','contabil6@beirario.com');

SELECT * FROM trabalho_final.contrato;
/*o Incluir 1 contrato para cada cliente;*/
insert into contrato
values
(15990,18001,'2019-12-02','2019-12-04',5000.00,6834,2974,1,NULL,1,1,'Pgto dia do exame'),
(15991,18050,'2019-12-02','2019-12-04',8000.00,6835,2957,16,NULL,16,1,'Pgto dia do exame'),
(15992,18100,'2019-12-02','2019-12-04',1000.00,6836,2950,14,NULL,14,1,'Pgto dia do exame');

/*o Incluir duas parcelas para cada contrato;*/
insert into parcelas
values
(29748,2500.00,'2019-12-02',NULL,'Pagamento por boleto',15990,100.00,0,35,NULL,0,NULL,10.0,1),
(29750,2500.00,'2020-01-02',NULL,'Pagamento por boleto',15990,100.00,1,35,NULL,0,NULL,10.0,1),

(29752,4000.00,'2019-12-02',NULL,'Pagamento por boleto',15991,400.00,1,36,NULL,0,NULL,10.0,1),
(29754,4000.00,'2020-01-04',NULL,'Pagamento por boleto',15991,400.00,0,36,NULL,0,NULL,10.0,1),

(29756,50000.00,'2019-12-02',NULL,'Pagamento por boleto',15992,5000.00,0,37,NULL,0,NULL,10.0,1),
(29758,50000.00,'2020-01-04',NULL,'Pagamento por boleto',15992,5000.00,1,37,NULL,0,NULL,10.0,1);

/*o Incluir 5 novos funcionários para cada um dos clientes;*/
insert into funcionario_cliente
values
(72256,'Funcionario 72256','2019-12-02',6834,'6.883.349','1983-08-01',NULL,'ASSIST. VENDAS '),
(72257,'Funcionario 72257','2019-12-02',6834,'7.848.458','1995-05-30',NULL,'ESTOQUISTA'),
(72258,'Funcionario 72258','2019-12-02',6834,'9.118.897','1999-02-27',NULL,'VENDEDOR'),
(72259,'Funcionario 72259','2019-12-02',6834,'3.993.349','1943-12-14',NULL,'VENDEDOR '),
(72260,'Funcionario 72260','2019-12-02',6834,'1.483.349','1960-08-20',NULL,'ESTOQUISTA'),

(72261,'Funcionario 72261','2019-12-02',6835,'9.843.456','1955-09-30',NULL,'VENDEDOR'),
(72262,'Funcionario 72262','2019-12-02',6835,'6.852.589','2000-06-10',NULL,'VENDEDOR'),
(72263,'Funcionario 72263','2019-12-02',6835,'3.835.825','1998-08-15',NULL,'VENDEDOR'),
(72264,'Funcionario 72264','2019-12-02',6835,'4.845.879','1990-03-17',NULL,'VENDEDOR'),
(72265,'Funcionario 72265','2019-12-02',6835,'7.985.950','1980-04-24',NULL,'VENDEDOR'),

(72266,'Funcionario 72266','2019-12-02',6836,'8.633.389','1985-02-28',NULL,'ANALISTA DE VENDAS'),
(72267,'Funcionario 72267','2019-12-02',6836,'4.433.583','1987-01-03',NULL,'ANALISTA DE FINANCEIRO'),
(72268,'Funcionario 72268','2019-12-02',6836,'2.348.879','1998-04-07',NULL,'OPERADOR DE VENDAS'),
(72269,'Funcionario 72269','2019-12-02',6836,'9.185.139','2000-10-09',NULL,'AUXILIAR DE SEGUROS'),
(72270,'Funcionario 72270','2019-12-02',6836,'1.893.349','1965-11-16',NULL,'DIRETOR');


/*Atualizaçõeso
A família “Bala” teve seu nome escrito errado em todos os registros onde aparece
como   responsável pelo cliente.Você   deve   atualizar   o sobrenome dos resposáveis para “Bombom”.
(estudar a função replace para esta ação);*/
UPDATE cliente
SET NOME_RESPONSAVEL = REPLACE (NOME_RESPONSAVEL,'Maria Bala','Maria Bombom') 
  WHERE NOME_RESPONSAVEL LIKE '%Maria Bala%';

UPDATE cliente
SET NOME_RESPONSAVEL = REPLACE (NOME_RESPONSAVEL,'Juka Bala','Juka Bombom') 
  WHERE NOME_RESPONSAVEL LIKE '%Juka Bala%';

/*Todos os clientes que não tiverem contratos ativos devem ser marcados como não ativos (ativo_cliente, 0=Inativo, 1=Ativo)*/
update cliente
set ATIVO_CLIENTE = 0
where ID_CLIENTE in (select c.ID_CLIENTE from contrato as c
						where c.ATIVO_CONTRATO = 0);


/*Excluir  do  banco  de  dados  todas  estados,  que  não  tenham  cidades sendo   utilizadas   nos   cadastros   
(clientes,   pessoas,   funcionários). Consequetemente excluir todas as cidades dos respectivos estados.*/

Select * from estado as et where ID_ESTADO not in (select ID_ESTADO from endereco);

DELETE FROM estado
WHERE ID_ESTADO not in (select ID_ESTADO from endereco);

                          /* Fase 03–Desenvolva os scripts para responder as seguintes questões:*/
/*/1)Listar  o  Id,  nome,  razão  social, CNPJ,  Data  de  Cadastro  do  Cliente
  de  todos  os clientes ativos que tenham sido cadastrados no ano de 2015.
  Os resultados devem ser  ordenados dos  mais  antigos  para  os  mais  novos,
  considerando  a  data  de cadastro.(considere o campo ativo_cliente. 1 Ativo, 0 Inativo)*/
  
select c.ID_CLIENTE, c.NOME_FANTASIA, c.RAZAO_SOCIAL, c.CNPJ_CLIENTE, c.DATA_CADASTRO_CLIENTE , C.ATIVO_CLIENTE
	from cliente as c
    where c.ATIVO_CLIENTE = 1
    and YEAR(c.DATA_CADASTRO_CLIENTE) BETWEEN '2015' AND '2015'
    ORDER BY DATA_CADASTRO_CLIENTE DESC;
    
    
/*2)Quantos clientes estão ativos e inativos(considere o campo ativo_cliente. 1Ativo, 0 Inativo);*/

SELECT COUNT(*),ATIVO_CLIENTE  FROM CLIENTE
GROUP BY ATIVO_CLIENTE;

/*3)Repetir os mesmos dados do exercício 1, incluir os seguintes dados do endereço: Número, Rua, Bairro, Cidade e Estado;*/

select a.ID_CLIENTE, a.NOME_FANTASIA, a.RAZAO_SOCIAL, a.CNPJ_CLIENTE, a.DATA_CADASTRO_CLIENTE, c.NUMERO_ENDERECO, c.RUA_ENDERECO,
	   c.BAIRRO_ENDERECO,d.NOME_CIDADE,e.NOME_ESTADO
	from cliente as a, endereco_cliente as b, endereco as c, cidade as d, estado as e
    where a.ID_CLIENTE = b.ID_CLIENTE
        and b.ID_ENDERECO = c.ID_ENDERECO
        and c.ID_CIDADE = d.ID_CIDADE
        and d.ID_ESTADO = e.ID_ESTADO
		and a.DATA_CADASTRO_CLIENTE BETWEEN '2015-01-01' AND '2015-12-31';
        
select b.ID_ENDERECO a, c.ID_ENDERECO b from endereco_cliente as b, endereco as c
	where b.ID_ENDERECO  = c.ID_ENDERECO;
        
        
/*4)Exibir  um  relatório  com  a  quantidade  de  clientes  por  cidade.  
Devem  ser  exibidas somente  as  cidades  que  apresentarem mais  de  10  clientes  cadastrados.
Os resultados devem ser ordenados em ordem crescente de quantidade de  clientes. 
A exibição final deve conter os seguintes campos: Estado, Cidade, Quantidade de Clientes.*/
  
SELECT c.NOME_ESTADO, b.NOME_CIDADE, COUNT(a.ID_CLIENTE) Qtd_Cliente
  FROM cliente AS a, cidade AS b,estado as c, endereco as d, endereco_cliente as e
	where a.ID_CLIENTE = e.ID_CLIENTE
		and e.ID_CLIENTE = d.ID_CLIENTE
        and e.ID_ENDERECO = d.ID_ENDERECO
        and d.ID_CIDADE = b.ID_CIDADE
        and b.ID_ESTADO = c.ID_ESTADO
GROUP BY NOME_CIDADE having Qtd_Cliente > 10 
order by Qtd_Cliente ;

/*5)Executar  a  consulta  4  acrescentando  a  participação daquela  cidade  no  total cadastrado  na  base.
Esse  resultado  deve  ser  exibido  em  %  e  deverá  ser  obtido através  de  uma  regra  de  3.
A  exibição  final  será  Estado,  Cidade,  Quantidade  de Clientes, % de participação no total de clientes.
(a leitura dessa informação será: A cidade de xxxxxxxx tem x% de participação no total de clientes cadastrados)*/
SELECT D.NOME_ESTADO,C.NOME_CIDADE,COUNT(A.ID_CLIENTE) AS QTDE_CLIENTE,
ROUND(COUNT(A.ID_CLIENTE) * 100 / (SELECT COUNT(*) FROM ENDERECO_CLIENTE),2) AS PORCENTAGEM
 FROM ENDERECO_CLIENTE A
INNER JOIN ENDERECO B
	ON A.ID_ENDERECO = B.ID_ENDERECO
INNER JOIN CIDADE C
	ON B.ID_CIDADE = C.ID_CIDADE
INNER JOIN ESTADO D
	ON C.ID_ESTADO = D.ID_ESTADO
GROUP BY C.ID_CIDADE
HAVING QTDE_CLIENTE > 10
ORDER BY QTDE_CLIENTE;

/*6)Apresentar  o  nome  fantasia  do  cliente,  CNPJ,  Número  do  Contrato,  Valor  do Contrato e a forma de pagamento.
 Devem ser apresentados somente os dados de clientes  ativos,  com  contrato  ativos.
 (são  considerados  contratos  ativos  os  que possuem data de encerramento posterior a data atual) */
 select a.NOME_FANTASIA, a.CNPJ_CLIENTE, b.NUMERO_CONTRATO , b.VALOR_CONTRATO, c.DESCRICAO_FORMA_PAGAMENTO
	from cliente as a, contrato as b, forma_pagamento as c
		where a.ID_CLIENTE = b.ID_CLIENTE
			and b.ID_FORMA_PAGAMENTO = c.ID_FORMA_PAGAMENTO
            and b.DATA_ENCERRAMENTO >= NOW();

/*7)Devido  a  um  ajuste  contábil,  todos  os  constratos  com  vencimento  no  mês  de fevereiro de 2016 devem ter o
 vencimento prorrogado por 15 dias.*/
 select a.ID_CONTRATO, b.ID_PARCELAS, b.VENCIMENTO_PARCELA 
 from contrato as a, parcelas as b
		where a.ID_CONTRATO = b.ID_CONTRATO
			and b.VENCIMENTO_PARCELA BETWEEN '2016-02-01' AND '2016-02-28';
 
UPDATE parcelas SET 
VENCIMENTO_PARCELA = ADDDATE( VENCIMENTO_PARCELA, INTERVAL 15 DAY)
where ID_PARCELAS in 
(select b.ID_PARCELAS
 from contrato as a, parcelas as b
		where a.ID_CONTRATO = b.ID_CONTRATO
			and b.VENCIMENTO_PARCELA BETWEEN '2016-02-01' AND '2016-02-28');
            
            
/*8)Monte  uma  consulta  por  aproximação  que  usará  como  chave  principal  o  nome  do funcionário
 (parâmetro  %Texto%).  Deverão  ser  exibidos  como  resultados  os seguintes  dados:
 Nome  do  Funcionário,  data  de  Admissão,  data  de  nascimento, nome  da  empresa  e  número do contrato.
 (somente  deverão  ser  exibidas  os resultados de empresas que estejam ativas com contratos ativos).*/
select a.NOME, a.DATA_ADMISSAO, a.DATA_NASCIMENTO, b.NOME_FANTASIA, c.NUMERO_CONTRATO
from funcionario_cliente as a, cliente as b, contrato as c
	where a.ID_CLIENTE = b.ID_CLIENTE
		and b.ID_CLIENTE = c.ID_CLIENTE
        and b.ATIVO_CLIENTE = 1
        and c.ATIVO_CONTRATO = 1
        AND a.nome  like '%41%';
        
 /*9)Qual foi o valor vendido por mês nos últimos 12 meses. Exempo de saída 01/2015 -120.000;  */

select MONTH(DATA_ASSINATURA),YEAR(DATA_ASSINATURA), (a.VALOR_CONTRATO) from contrato as a
where a.DATA_ASSINATURA > month(-12)
group by MONTH(DATA_ASSINATURA),YEAR(DATA_ASSINATURA);	



/*10)Qual o valor de parcelas em atraso por mês de vencimento;*/
select year(a.VENCIMENTO_PARCELA) AS Ano,month(a.VENCIMENTO_PARCELA) as Mes, sum(VALOR_PARCELA) as Valor_Parcela
from parcelas as a 
group by MONTH(VENCIMENTO_PARCELA)
order by Ano;

/*11)Listar  o  nome  fantasia, número  do  contrato,  valor  do  contrato,
valor  recebido  e valor devido dos clientes que possuem parcelas não pagas (pago=0);*/

Select C.ID_PARCELAS,a.NOME_FANTASIA, b.NUMERO_CONTRATO, b.VALOR_CONTRATO, 
(select sum(a.VALOR_PARCELA) from parcelas as a, cliente as b, contrato as c
	where A.ID_CONTRATO = c.ID_CONTRATO 
    and b.ID_CLIENTE = c.ID_CLIENTE
    and a.pago = 1) as Valor_recebido,
sum((select sum(a.VALOR_PARCELA) from parcelas as a, cliente as b, contrato as c
	where A.ID_CONTRATO = c.ID_CONTRATO 
    and b.ID_CLIENTE = c.ID_CLIENTE
    and a.pago = 1) 
    - 
    (select sum(a.VALOR_PARCELA) from parcelas as a, cliente as b, contrato as c
	where A.ID_CONTRATO = c.ID_CONTRATO 
    and b.ID_CLIENTE = c.ID_CLIENTE
    and a.pago = 0)) as Valor_Devido
from cliente as a, contrato as b, parcelas as c
where a.ID_CLIENTE = b.ID_CLIENTE
	and b.ID_CONTRATO = c.ID_CONTRATO
group by ID_PARCELAS;	

/*12) Apresentar o percentual de clientes inadimplentes por cidade. O percentual deve
ser aplicado sobre a quantidade de clientes da própria cidade. É considerado
inadimplente todo cliente que possue parcela com data de pagamento menor do
que a data atual e que não tenha sido paga.*/

SELECT  b.NOME_CIDADE, ROUND(COUNT(A.ID_CLIENTE) * 100 / (SELECT COUNT(*) FROM cidade),2) AS PORCENTAGEM
, COUNT(a.ID_CLIENTE) Qtd_Cliente
  FROM cliente AS a, cidade AS b, endereco as d, endereco_cliente as e
	where a.ID_CLIENTE = e.ID_CLIENTE
		and e.ID_CLIENTE = d.ID_CLIENTE
        and e.ID_ENDERECO = d.ID_ENDERECO
        and d.ID_CIDADE = b.ID_CIDADE
GROUP BY NOME_CIDADE
order by Qtd_Cliente;






  
/*TESTES*/	


/*Executar no final do script
SET SQL_SAFE_UPDATES = 1;
SET FOREIGN_KEY_CHECKS = 1;*/





 