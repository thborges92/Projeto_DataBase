CREATE DATABASE db_concessionaria;

USE db_concessionaria;

CREATE TABLE tab_cliente (
	id int(8) AUTO_INCREMENT PRIMARY KEY,
	nome varchar(20) not null,
	cpf varchar(14) not null,
	telefone varchar(20),
	endereco varchar(100)
);

CREATE TABLE tab_vendedor (
	id int(8) AUTO_INCREMENT PRIMARY KEY,
	nome varchar(20) not null,
	telefone varchar(20),
	cpf varchar(14) not null
);

CREATE TABLE tab_fabricante (
	id int(8) AUTO_INCREMENT PRIMARY KEY,
	marca varchar(20) not null
);

CREATE TABLE tab_veiculos (
	id int(8) AUTO_INCREMENT PRIMARY KEY,
	modelo varchar(20) not null,
	cor varchar(20) not null,
	ano int(4),
	preco float,
	idFabricante int(4),
	CONSTRAINT FK_Fabricante_Carro
	FOREIGN KEY (idFabricante) REFERENCES tab_fabricante(id)
);

CREATE TABLE tab_vendas (
	id int(8) AUTO_INCREMENT PRIMARY KEY,
	data varchar(20),
	idCliente int(4),
	idVendedor int(4),
	idFabricante int(4),
	idVeiculo int(4),
	qtd int(4),
	precoTotal float,
	CONSTRAINT FK_Vendas_Cliente
	FOREIGN KEY (idCliente) REFERENCES tab_cliente(id),
	CONSTRAINT FK_Vendas_Vendedor
	FOREIGN KEY (idVendedor) REFERENCES tab_vendedor(id),
	CONSTRAINT FK_Vendas_Fabricante
	FOREIGN KEY (idFabricante) REFERENCES tab_fabricante(id),
	CONSTRAINT FK_Vendas_Carro
	FOREIGN KEY (idVeiculo) REFERENCES tab_veiculos(id)
);

DELIMITER $$

CREATE PROCEDURE Insert_Cliente (IN nomeCliente varchar(20),
	IN cpfCliente varchar(14),
	IN telefoneCliente varchar(20),
	IN enderecoCliente varchar(100))
BEGIN

INSERT INTO tab_cliente (nome, cpf, telefone, endereco)
	VALUES
		(nomeCliente, cpfCliente, telefoneCliente, enderecoCliente)
;

END $$

DELIMITER ;

CALL Insert_Cliente ("João", "159.357.654-28", "21 98558-1585", "Rua das Artes, 10");
CALL Insert_Cliente ("Thiago", "128.617.545-23", "21 99894-0101", "Rua Monsenhor Marques, 46");
CALL Insert_Cliente ("Marcos", "135.481.215-98", "21 99958-7235", "Rua Dantas, 554");
CALL Insert_Cliente ("Isabel", "179.295.385-24", "21 99273-3919", "Rua Monsenhor Marques, 46");
CALL Insert_Cliente ("Maria", "110.048.465-84", "21 99823-4612", "Rua Cavaleiro, 200");
CALL Insert_Cliente ("Gabriel", "087.359.588-74", "21 98732-2121", "Rua das Árvores, 20");
CALL Insert_Cliente ("Jeferson", "165.396.751-56", "21 99346-2155", "Rua Ipa, 25");
CALL Insert_Cliente ("Arthur", "192.882.365-32", "21 98832-0186", "Rua do Mundo, 10");
CALL Insert_Cliente ("Maitê", "129.346.566-22", "21 99990-2022", "Rua das Flores, 20");
CALL Insert_Cliente ("Rafael", "113.422.689-64", "21 99832-2446", "Rua dos Mares, 44");

DELIMITER $$

CREATE PROCEDURE Insert_Vendedor (IN nomeVendedor varchar(20),
	IN telefoneVendedor varchar(20),
	IN cpfVendedor varchar(14))
BEGIN

INSERT INTO tab_vendedor (nome, telefone, cpf)
	VALUES
		(nomeVendedor, telefoneVendedor, cpfVendedor)
;

END $$

DELIMITER ;

CALL Insert_Vendedor ("Manoel", "21 99683-9823", "123.456.789-00");

CALL Insert_Vendedor ("Chico", "21 98350-5863", "789.456.123-11");

CALL Insert_Vendedor ("José", "21 93569-2646", "159.357.654-20");

DELIMITER $$

CREATE PROCEDURE Insert_Fabricante (IN marcaFabricante varchar(20))
BEGIN

INSERT INTO tab_fabricante (marca)
	VALUES
		(marcaFabricante)
;

END $$

DELIMITER ;

CALL Insert_Fabricante ("Fiat");
CALL Insert_Fabricante ("Nissan");
CALL Insert_Fabricante ("Honda");
CALL Insert_Fabricante ("Toyota");
CALL Insert_Fabricante ("Volkswagen");

DELIMITER $$

CREATE PROCEDURE Insert_Veiculos (IN modeloVeiculo varchar(20),
	IN corVeiculo varchar(10),
	IN anoVeiculo varchar(10),
	IN precoVeiculo float,
	IN fabricanteVeiculo varchar(20))
BEGIN

INSERT INTO tab_veiculos (modelo, cor, ano, preco, idFabricante)
	VALUES
		(modeloVeiculo, corVeiculo, anoVeiculo, precoVeiculo, (SELECT id FROM tab_fabricante WHERE marca like fabricanteVeiculo)
);

END $$

DELIMITER ;

CALL Insert_Veiculos ("Fiat Argo", "Branco", "2021", 68290.00, "F%");
CALL Insert_Veiculos ("Fiat Cronos", "Prata", "2021", 71390.00, "F%");
CALL Insert_Veiculos ("Nissan Kicks", "Azul", "2021", 94990.00, "N%");
CALL Insert_Veiculos ("Nissan Versa", "Vermelho", "2021", 83690.00, "N%");
CALL Insert_Veiculos ("Toyota Yaris", "Branco", "2021", 80990.00, "T%");
CALL Insert_Veiculos ("Toyota Corolla", "Prata", "2021", 126490.00, "T%");
CALL Insert_Veiculos ("Honda Fit", "Preto", "2021", 89000.00, "H%");
CALL Insert_Veiculos ("Honda City", "Cinza", "2021", 89700.00, "H%");
CALL Insert_Veiculos ("Volkswagen Virtus", "Preto", "2021", 90090.00, "V%");
CALL Insert_Veiculos ("Volkswagen Nivus", "Vermelho", "2021", 99540.00, "V%");

DELIMITER $$

CREATE PROCEDURE Insert_Vendas (IN dataVenda varchar(20),
	IN clienteVenda varchar(20),
	IN vendedorVenda varchar(20),
	IN fabricanteVenda varchar(20),
	IN veiculoVenda varchar(20),
	IN qtdVenda int(4),
	IN precoVenda float
	)
BEGIN

INSERT INTO tab_vendas (data, idCliente, idVendedor, idFabricante, idVeiculo, qtd, precoTotal)
	VALUES
		(dataVenda,
		(SELECT id FROM tab_cliente WHERE nome like clienteVenda),
		(SELECT id FROM tab_vendedor WHERE nome like vendedorVenda),
		(SELECT id FROM tab_fabricante WHERE marca like fabricanteVenda),
		(SELECT id FROM tab_veiculos WHERE modelo like veiculoVenda),
		qtdVenda,
		precoVenda
);

END $$

DELIMITER ;

CALL Insert_Vendas ("20/02/2021", "João%", "M%", "F%", "%Argo%", 1, (1 * (SELECT preco FROM tab_veiculos WHERE id = 1)));
CALL Insert_Vendas ("14/01/2021", "Thiago%", "C%", "H%", "%City%", 2, (2 * (SELECT preco FROM tab_veiculos WHERE id = 8)));
CALL Insert_Vendas ("18/03/2021", "Marcos%", "J%", "F%", "%Cronos%", 1, (1 * (SELECT preco FROM tab_veiculos WHERE id = 2)));
CALL Insert_Vendas ("15/01/2021", "Isabel%", "C%", "N%", "%Kicks%", 2, (2 * (SELECT preco FROM tab_veiculos WHERE id = 3)));
CALL Insert_Vendas ("25/06/2021", "Maria%", "J%", "T%", "%Yaris%", 3, (3 * (SELECT preco FROM tab_veiculos WHERE id = 5)));
CALL Insert_Vendas ("20/04/2021", "Gabriel%", "M%", "V%", "%Nivus%", 3, (3 * (SELECT preco FROM tab_veiculos WHERE id = 10)));
CALL Insert_Vendas ("10/05/2021", "Jeferson%", "C%", "V%", "%Virtus%", 2, (2 * (SELECT preco FROM tab_veiculos WHERE id = 9)));
CALL Insert_Vendas ("23/07/2021", "Arthur%", "J%", "H%", "%Fit%", 1, (1 * (SELECT preco FROM tab_veiculos WHERE id = 7)));
CALL Insert_Vendas ("20/04/2021", "Maitê%", "C%", "N%", "%Versa%", 1, (1 * (SELECT preco FROM tab_veiculos WHERE id = 4)));
CALL Insert_Vendas ("05/03/2021", "Rafael%", "M%", "T%", "%Corolla%", 2, (2 * (SELECT preco FROM tab_veiculos WHERE id = 6)));

DELIMITER $$

CREATE PROCEDURE Consulta_VendasVendedor1 (IN vendedor1 varchar(20))
BEGIN

select
	tab_vendas.data AS "Data",
	tab_vendedor.nome AS "Vendedor",
	tab_vendas.precoTotal AS "Vendas"
from tab_vendas
INNER JOIN tab_vendedor
ON tab_vendas.idVendedor = tab_vendedor.id
WHERE tab_vendedor.nome like "m%";

END $$

DELIMITER ;

CALL Consulta_VendasVendedor1 ("Manoel");

DELIMITER $$

CREATE PROCEDURE Consulta_VendasVendedor2 (IN vendedor2 varchar(20))
BEGIN

select
	tab_vendas.data AS "Data",
	tab_vendedor.nome AS "Vendedor",
	tab_vendas.precoTotal AS "Vendas"
from tab_vendas
INNER JOIN tab_vendedor
ON tab_vendas.idVendedor = tab_vendedor.id
WHERE tab_vendedor.nome like "c%";

END $$

DELIMITER ;

CALL Consulta_VendasVendedor2 ("Chico");

DELIMITER $$

CREATE PROCEDURE Consulta_VendasVendedor3 (IN vendedor3 varchar(20))
BEGIN

select
	tab_vendas.data AS "Data",
	tab_vendedor.nome AS "Vendedor",
	tab_vendas.precoTotal AS "Vendas"
from tab_vendas
INNER JOIN tab_vendedor
ON tab_vendas.idVendedor = tab_vendedor.id
WHERE tab_vendedor.nome like "j%";

END $$

DELIMITER ;

CALL Consulta_VendasVendedor3 ("José");

DELIMITER $$

CREATE PROCEDURE Consulta_VendasCliente1 (IN clienteX int(4))
BEGIN

select
	tab_vendas.data AS "Data",
	tab_cliente.nome AS "Cliente",
	tab_vendas.precoTotal AS "Comprou"
from tab_vendas
INNER JOIN tab_cliente
ON tab_vendas.idCliente = tab_cliente.id
WHERE tab_cliente.id = 1;

END $$

DELIMITER ;

CALL Consulta_VendasCliente1 (1);

DELIMITER $$

CREATE PROCEDURE Consulta_VendasCliente2 (IN clienteX int(4))
BEGIN

select
	tab_vendas.data AS "Data",
	tab_cliente.nome AS "Cliente",
	tab_vendas.precoTotal AS "Comprou"
from tab_vendas
INNER JOIN tab_cliente
ON tab_vendas.idCliente = tab_cliente.id
WHERE tab_cliente.id = 2;

END $$

DELIMITER ;

CALL Consulta_VendasCliente2 (2);

DELIMITER $$

CREATE PROCEDURE Consulta_VendasCliente3 (IN clienteX int(4))
BEGIN

select
	tab_vendas.data AS "Data",
	tab_cliente.nome AS "Cliente",
	tab_vendas.precoTotal AS "Comprou"
from tab_vendas
INNER JOIN tab_cliente
ON tab_vendas.idCliente = tab_cliente.id
WHERE tab_cliente.id = 3;

END $$

DELIMITER ;

CALL Consulta_VendasCliente3 (3);

DELIMITER $$

CREATE PROCEDURE Consulta_VendasCliente4 (IN clienteX int(4))
BEGIN

select
	tab_vendas.data AS "Data",
	tab_cliente.nome AS "Cliente",
	tab_vendas.precoTotal AS "Comprou"
from tab_vendas
INNER JOIN tab_cliente
ON tab_vendas.idCliente = tab_cliente.id
WHERE tab_cliente.id = 4;

END $$

DELIMITER ;

CALL Consulta_VendasCliente4 (4);

DELIMITER $$

CREATE PROCEDURE Consulta_VendasCliente5 (IN clienteX int(4))
BEGIN

select
	tab_vendas.data AS "Data",
	tab_cliente.nome AS "Cliente",
	tab_vendas.precoTotal AS "Comprou"
from tab_vendas
INNER JOIN tab_cliente
ON tab_vendas.idCliente = tab_cliente.id
WHERE tab_cliente.id = 5;

END $$

DELIMITER ;

CALL Consulta_VendasCliente5 (5);

DELIMITER $$

CREATE PROCEDURE Consulta_VendasCliente6 (IN clienteX int(4))
BEGIN

select
	tab_vendas.data AS "Data",
	tab_cliente.nome AS "Cliente",
	tab_vendas.precoTotal AS "Comprou"
from tab_vendas
INNER JOIN tab_cliente
ON tab_vendas.idCliente = tab_cliente.id
WHERE tab_cliente.id = 6;

END $$

DELIMITER ;

CALL Consulta_VendasCliente6 (6);

DELIMITER $$

CREATE PROCEDURE Consulta_VendasCliente7 (IN clienteX int(4))
BEGIN

select
	tab_vendas.data AS "Data",
	tab_cliente.nome AS "Cliente",
	tab_vendas.precoTotal AS "Comprou"
from tab_vendas
INNER JOIN tab_cliente
ON tab_vendas.idCliente = tab_cliente.id
WHERE tab_cliente.id = 7;

END $$

DELIMITER ;

CALL Consulta_VendasCliente7 (7);

DELIMITER $$

CREATE PROCEDURE Consulta_VendasCliente8 (IN clienteX int(4))
BEGIN

select
	tab_vendas.data AS "Data",
	tab_cliente.nome AS "Cliente",
	tab_vendas.precoTotal AS "Comprou"
from tab_vendas
INNER JOIN tab_cliente
ON tab_vendas.idCliente = tab_cliente.id
WHERE tab_cliente.id = 8;

END $$

DELIMITER ;

CALL Consulta_VendasCliente8 (8);

DELIMITER $$

CREATE PROCEDURE Consulta_VendasCliente9 (IN clienteX int(4))
BEGIN

select
	tab_vendas.data AS "Data",
	tab_cliente.nome AS "Cliente",
	tab_vendas.precoTotal AS "Comprou"
from tab_vendas
INNER JOIN tab_cliente
ON tab_vendas.idCliente = tab_cliente.id
WHERE tab_cliente.id = 9;

END $$

DELIMITER ;

CALL Consulta_VendasCliente9 (9);

DELIMITER $$

CREATE PROCEDURE Consulta_VendasCliente10 (IN clienteX int(4))
BEGIN

select
	tab_vendas.data AS "Data",
	tab_cliente.nome AS "Cliente",
	tab_vendas.precoTotal AS "Comprou"
from tab_vendas
INNER JOIN tab_cliente
ON tab_vendas.idCliente = tab_cliente.id
WHERE tab_cliente.id = 10;

END $$

DELIMITER ;

CALL Consulta_VendasCliente10 (10);

DELIMITER $$

CREATE PROCEDURE Consulta_VendasFabricante1 (IN fabricante1 varchar(20))
BEGIN

select
	tab_vendas.data AS "Data",
	tab_fabricante.marca AS "Fabricante",
	tab_vendas.precoTotal AS "Vendas"
from tab_vendas
INNER JOIN tab_fabricante
ON tab_vendas.idFabricante = tab_fabricante.id
WHERE tab_fabricante.marca like "Fiat";

END $$

DELIMITER ;

CALL Consulta_VendasFabricante1 ("Fiat");

DELIMITER $$

CREATE PROCEDURE Consulta_VendasFabricante2 (IN fabricante2 varchar(20))
BEGIN

select
	tab_vendas.data AS "Data",
	tab_fabricante.marca AS "Fabricante",
	tab_vendas.precoTotal AS "Vendas"
from tab_vendas
INNER JOIN tab_fabricante
ON tab_vendas.idFabricante = tab_fabricante.id
WHERE tab_fabricante.marca like "Nissan";

END $$

DELIMITER ;

CALL Consulta_VendasFabricante2 ("Nissan");

DELIMITER $$

CREATE PROCEDURE Consulta_VendasFabricante3 (IN fabricante3 varchar(20))
BEGIN

select
	tab_vendas.data AS "Data",
	tab_fabricante.marca AS "Fabricante",
	tab_vendas.precoTotal AS "Vendas"
from tab_vendas
INNER JOIN tab_fabricante
ON tab_vendas.idFabricante = tab_fabricante.id
WHERE tab_fabricante.marca like "Honda";

END $$

DELIMITER ;

CALL Consulta_VendasFabricante3 ("Honda");

DELIMITER $$

CREATE PROCEDURE Consulta_VendasFabricante4 (IN fabricante4 varchar(20))
BEGIN

select
	tab_vendas.data AS "Data",
	tab_fabricante.marca AS "Fabricante",
	tab_vendas.precoTotal AS "Vendas"
from tab_vendas
INNER JOIN tab_fabricante
ON tab_vendas.idFabricante = tab_fabricante.id
WHERE tab_fabricante.marca like "Toyota";

END $$

DELIMITER ;

CALL Consulta_VendasFabricante4 ("Toyota");

DELIMITER $$

CREATE PROCEDURE Consulta_VendasFabricante5 (IN fabricante5 varchar(20))
BEGIN

select
	tab_vendas.data AS "Data",
	tab_fabricante.marca AS "Fabricante",
	tab_vendas.precoTotal AS "Vendas"
from tab_vendas
INNER JOIN tab_fabricante
ON tab_vendas.idFabricante = tab_fabricante.id
WHERE tab_fabricante.marca like "Volkswagen";

END $$

DELIMITER ;

CALL Consulta_VendasFabricante5 ("Volkswagen");