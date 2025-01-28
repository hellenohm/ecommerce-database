# Banco de Dados Ecommerce

Este projeto contém o banco de dados para um sistema de ecommerce, com tabelas principais para clientes, pedidos, produtos, fornecedores, pagamentos, entregas e relacionamentos entre essas entidades. O objetivo é fornecer uma estrutura organizada para armazenar e gerenciar as informações de um ecommerce.

## Estrutura do Banco de Dados

### Tabelas principais

1. **Cliente**
   - Contém informações sobre os clientes, tanto pessoa física (PF) quanto pessoa jurídica (PJ).
   - Campos: `idCliente`, `Nome`, `Identificacao`, `Endereco`, `CPF`, `CNPJ`, `TipoCliente`

2. **Pedido**
   - Armazena os pedidos feitos pelos clientes, incluindo o status, descrição, frete e relacionamento com o cliente.
   - Campos: `idPedido`, `StatusPedido`, `Descricao`, `Cliente_idCliente`, `Frete`

3. **Produto**
   - Contém informações sobre os produtos disponíveis para venda.
   - Campos: `idProdutos`, `Categoria`, `Descricao`, `Valor`

4. **Fornecedor**
   - Informações dos fornecedores de produtos.
   - Campos: `idFornecedor`, `RazaoSocial`, `CNPJ`

5. **Disponibilizando**
   - Relacionamento entre fornecedores e produtos, indicando quais fornecedores oferecem quais produtos.
   - Campos: `Fornecedor_idFornecedor`, `Produto_idProdutos`

6. **Estoque**
   - Contém informações sobre os locais de estoque dos produtos.
   - Campos: `idEstoque`, `Local`

7. **Produto_has_Estoque**
   - Relaciona produtos aos estoques, indicando a quantidade disponível em cada local de estoque.
   - Campos: `Produto_idProdutos`, `Estoque_idEstoque`, `Quantidade`

8. **Pagamento**
   - Armazena informações sobre os pagamentos feitos pelos clientes, incluindo a forma de pagamento e os dados relacionados.
   - Campos: `idPagamento`, `Forma`, `NumeroCartao`, `CodigoBarras`, `ChavePix`, `CPF`, `CNPJ`, `Cliente_idCliente`

9. **Entrega**
   - Contém detalhes sobre as entregas dos pedidos, incluindo status, código de rastreamento e endereço de entrega.
   - Campos: `idEntrega`, `Status`, `CodigoRastreamento`, `Rua`, `Cidade`, `Estado`, `CEP`, `CPF`, `CNPJ`, `Cliente_idCliente`, `Pagamento_idPagamento`, `Pedido_idPedido`

10. **Produto_has_Pagamento**
    - Relaciona produtos aos pagamentos, indicando quais produtos foram pagos em uma determinada transação.
    - Campos: `Produto_idProdutos`, `Pagamento_idPagamento`

### Tabelas adicionais

1. **Terceiro_Vendedor**
   - Contém informações sobre vendedores terceirizados.
   - Campos: `idTerceiro_Vendedor`, `RazaoSocial`, `Local`

2. **Produtos_por_Vendedor**
   - Relaciona produtos aos vendedores terceirizados, indicando a quantidade disponível de cada produto.
   - Campos: `Terceiro_Vendedor_idTerceiro_Vendedor`, `Produto_idProdutos`, `Quantidade`

3. **Produto_Pedido**
   - Relaciona produtos aos pedidos, indicando quais produtos foram incluídos em cada pedido e a quantidade de cada um.
   - Campos: `Produto_idProdutos`, `Pedido_idPedido`, `QuantidadeProduto`

## Inserção de Dados de Teste

Foram inseridos alguns dados de teste para validação do banco de dados:

- Clientes, produtos, pedidos, estoques, entre outros.

## Consultas SQL

Exemplos de consultas SQL usadas para recuperar dados do banco:

1. **Recuperação simples**:
   ```sql
   SELECT * FROM Cliente;
Filtros com WHERE:

sql
Copiar
Editar
SELECT * FROM Pedido WHERE StatusPedido = 'Entregue';
Atributos derivados:

sql
Copiar
Editar
SELECT idProdutos, Descricao, Valor, Valor * 1.1 AS ValorComImposto FROM Produto;
Ordenação de dados:

sql
Copiar
Editar
SELECT * FROM Produto ORDER BY Valor DESC;
Condições com HAVING:

sql
Copiar
Editar
SELECT Cliente_idCliente, COUNT(*) AS TotalPedidos FROM Pedido
GROUP BY Cliente_idCliente
HAVING COUNT(*) > 1;
Junções entre tabelas:

sql
Copiar
Editar
SELECT Cliente.Nome, Pedido.Descricao, Produto.Descricao AS Produto, Produto.Valor
FROM Pedido
JOIN Produto_Pedido ON Pedido.idPedido = Produto_Pedido.Pedido_idPedido
JOIN Produto ON Produto_Pedido.Produto_idProdutos = Produto.idProdutos
JOIN Cliente ON Pedido.Cliente_idCliente = Cliente.idCliente;
Como Usar
Clone este repositório:

bash
Copiar
Editar
git clone https://github.com/hellenohm/ecommerce-database.git
Acesse o diretório do projeto:

bash
Copiar
Editar
cd ecommerce-database
Importe o arquivo SQL no seu banco de dados MySQL.

Execute as consultas de exemplo para testar as funcionalidades.

Licença
Este projeto está licenciado sob a MIT License - veja o arquivo LICENSE para mais detalhes.

css
Copiar
Editar

Esse `README.md` inclui a descrição geral do projeto, a estrutura do banco de dados, dados de exemplo e consultas SQL, além das instruções básicas de uso. Se precisar adicionar mais detalhes ou ajustes, fique à vontade para adaptar!






