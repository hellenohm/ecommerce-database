-- Criação do banco de dados
CREATE DATABASE Ecommerce;
USE Ecommerce;

-- Criação das tabelas principais
CREATE TABLE Cliente (
    idCliente INT PRIMARY KEY,
    Nome VARCHAR(45),
    Identificacao VARCHAR(45),
    Endereco VARCHAR(45),
    CPF VARCHAR(45),
    CNPJ VARCHAR(45),
    TipoCliente ENUM('PF', 'PJ') NOT NULL
);

CREATE TABLE Pedido (
    idPedido INT PRIMARY KEY,
    StatusPedido VARCHAR(45),
    Descricao VARCHAR(45),
    Cliente_idCliente INT,
    Frete FLOAT,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE Produto (
    idProdutos INT PRIMARY KEY,
    Categoria VARCHAR(45),
    Descricao VARCHAR(45),
    Valor FLOAT
);

CREATE TABLE Fornecedor (
    idFornecedor INT PRIMARY KEY,
    RazaoSocial VARCHAR(45),
    CNPJ VARCHAR(45)
);

CREATE TABLE Disponibilizando (
    Fornecedor_idFornecedor INT,
    Produto_idProdutos INT,
    PRIMARY KEY (Fornecedor_idFornecedor, Produto_idProdutos),
    FOREIGN KEY (Fornecedor_idFornecedor) REFERENCES Fornecedor(idFornecedor),
    FOREIGN KEY (Produto_idProdutos) REFERENCES Produto(idProdutos)
);

CREATE TABLE Estoque (
    idEstoque INT PRIMARY KEY,
    Local VARCHAR(45)
);

CREATE TABLE Produto_has_Estoque (
    Produto_idProdutos INT,
    Estoque_idEstoque INT,
    Quantidade INT,
    PRIMARY KEY (Produto_idProdutos, Estoque_idEstoque),
    FOREIGN KEY (Produto_idProdutos) REFERENCES Produto(idProdutos),
    FOREIGN KEY (Estoque_idEstoque) REFERENCES Estoque(idEstoque)
);

CREATE TABLE Pagamento (
    idPagamento INT PRIMARY KEY,
    Forma VARCHAR(45),
    NumeroCartao VARCHAR(45),
    CodigoBarras VARCHAR(45),
    ChavePix VARCHAR(45),
    CPF VARCHAR(45),
    CNPJ VARCHAR(45),
    Cliente_idCliente INT,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE Entrega (
    idEntrega INT PRIMARY KEY,
    Status VARCHAR(45),
    CodigoRastreamento VARCHAR(45),
    Rua VARCHAR(45),
    Cidade VARCHAR(45),
    Estado VARCHAR(45),
    CEP VARCHAR(45),
    CPF VARCHAR(45),
    CNPJ VARCHAR(45),
    Cliente_idCliente INT,
    Pagamento_idPagamento INT,
    Pedido_idPedido INT,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (Pagamento_idPagamento) REFERENCES Pagamento(idPagamento),
    FOREIGN KEY (Pedido_idPedido) REFERENCES Pedido(idPedido)
);

CREATE TABLE Produto_has_Pagamento (
    Produto_idProdutos INT,
    Pagamento_idPagamento INT,
    PRIMARY KEY (Produto_idProdutos, Pagamento_idPagamento),
    FOREIGN KEY (Produto_idProdutos) REFERENCES Produto(idProdutos),
    FOREIGN KEY (Pagamento_idPagamento) REFERENCES Pagamento(idPagamento)
);

-- Tabelas adicionais
CREATE TABLE Terceiro_Vendedor (
    idTerceiro_Vendedor INT PRIMARY KEY,
    RazaoSocial VARCHAR(45),
    Local VARCHAR(45)
);

CREATE TABLE Produtos_por_Vendedor (
    Terceiro_Vendedor_idTerceiro_Vendedor INT,
    Produto_idProdutos INT,
    Quantidade INT,
    PRIMARY KEY (Terceiro_Vendedor_idTerceiro_Vendedor, Produto_idProdutos),
    FOREIGN KEY (Terceiro_Vendedor_idTerceiro_Vendedor) REFERENCES Terceiro_Vendedor(idTerceiro_Vendedor),
    FOREIGN KEY (Produto_idProdutos) REFERENCES Produto(idProdutos)
);

-- Relação de Produto por Pedido
CREATE TABLE Produto_Pedido (
    Produto_idProdutos INT,
    Pedido_idPedido INT,
    QuantidadeProduto INT,
    PRIMARY KEY (Produto_idProdutos, Pedido_idPedido),
    FOREIGN KEY (Produto_idProdutos) REFERENCES Produto(idProdutos),
    FOREIGN KEY (Pedido_idPedido) REFERENCES Pedido(idPedido)
);

-- Inserção de dados para testes
INSERT INTO Cliente (idCliente, Nome, Identificacao, Endereco, CPF, CNPJ, TipoCliente) VALUES
(1, 'João Silva', '12345', 'Rua A, 123', '12345678900', '12345678000199', 'PF'),
(2, 'Maria Oliveira', '54321', 'Rua B, 456', '09876543211', '98765432000199', 'PJ');

INSERT INTO Produto (idProdutos, Categoria, Descricao, Valor) VALUES
(1, 'Eletrônicos', 'Smartphone', 1500.00),
(2, 'Eletrodomésticos', 'Geladeira', 2500.00);

INSERT INTO Pedido (idPedido, StatusPedido, Descricao, Cliente_idCliente, Frete) VALUES
(1, 'Entregue', 'Pedido de Eletrônicos', 1, 30.00),
(2, 'Pendente', 'Pedido de Eletrodomésticos', 2, 50.00);

INSERT INTO Estoque (idEstoque, Local) VALUES
(1, 'Centro de Distribuição A'),
(2, 'Centro de Distribuição B');

INSERT INTO Produto_has_Estoque (Produto_idProdutos, Estoque_idEstoque, Quantidade) VALUES
(1, 1, 100),
(2, 2, 50);

-- Consultas SQL complexas
-- Recuperação simples
SELECT * FROM Cliente;

-- Filtros com WHERE
SELECT * FROM Pedido WHERE StatusPedido = 'Entregue';

-- Atributos derivados
SELECT idProdutos, Descricao, Valor, Valor * 1.1 AS ValorComImposto FROM Produto;

-- Ordenação de dados
SELECT * FROM Produto ORDER BY Valor DESC;

-- Condições com HAVING
SELECT Cliente_idCliente, COUNT(*) AS TotalPedidos FROM Pedido
GROUP BY Cliente_idCliente
HAVING COUNT(*) > 1;

-- Junções entre tabelas
SELECT Cliente.Nome, Pedido.Descricao, Produto.Descricao AS Produto, Produto.Valor
FROM Pedido
JOIN Produto_Pedido ON Pedido.idPedido = Produto_Pedido.Pedido_idPedido
JOIN Produto ON Produto_Pedido.Produto_idProdutos = Produto.idProdutos
JOIN Cliente ON Pedido.Cliente_idCliente = Cliente.idCliente;
