### 1. No contexto das técnicas de injeção de SQL, explique as diferenças principais entre tautologias e injeção de uniões. Dê exemplos.  

**Tautologias**: 
- **Definição**: A injeção de tautologia ocorre quando o atacante manipula a consulta SQL para tornar uma condição sempre verdadeira, forçando o retorno de todos os registros.
- **Exemplo**:  Se a consulta original for:   

```sql
SELECT * FROM users WHERE username = 'user' AND password = 'password';
```

O atacante pode injetar:

```sql
' OR 1=1 --
```

O que resulta em:

```sql
SELECT * FROM users WHERE username = '' OR 1=1 -- AND password = 'password';
```

Isso fará a consulta retornar todos os registros da tabela, ignorando a verificação da senha.

**Injeção de Uniões (Union Injection)**:

- **Definição**: A injeção de união é uma técnica onde o atacante tenta combinar a consulta original com outra consulta usando a palavra-chave `UNION` para obter dados de tabelas adicionais.
- **Exemplo**: Se a consulta original for:
    
```sql
SELECT name, age FROM employees WHERE id = 1;
```
    
O atacante pode injetar:

```sql
UNION SELECT username, password FROM users --
```

Isso combinaria os resultados da consulta original com os dados da tabela `users`.

---

### 2. Considere uma aplicação web desenvolvida em Java que utiliza um determinado SGBD e é acessada pelos utilizadores via navegador. Dada a sua natureza, esta aplicação inclui potenciais vulnerabilidades de injeção de SQL. Das seguintes afirmações, indique as verdadeiras e justifique a sua resposta.

#### 2.1 É difícil explorar este tipo de vulnerabilidade se os comandos SQL não forem produzidos no navegador (i.e., se forem produzidos pelo código Java da aplicação web).

- **Resposta**: Falsa. Embora a aplicação Java evite que os comandos SQL sejam visíveis diretamente no navegador, isso não impede a injeção de SQL. Se a aplicação Java não validar corretamente as entradas do usuário ou usar consultas SQL dinâmicas sem parametrização, o atacante ainda pode explorar a vulnerabilidade.

#### 2.2 É difícil explorar este tipo de vulnerabilidade se a interface do utilizador incluir campos de texto que apenas permitem a introdução de valores numéricos.

- **Resposta**: Verdadeira. Se a interface só permite valores numéricos, é mais difícil para um atacante injetar código SQL, porque os números são mais restritivos para manipulação em consultas SQL. No entanto, se o valor numérico for mal utilizado na consulta, ainda pode ser possível explorar a vulnerabilidade.

#### 2.3 É difícil explorar este tipo de vulnerabilidade se a interface do utilizador não incluir campos de texto.

- **Resposta**: Falsa. A ausência de campos de texto não elimina a possibilidade de injeção de SQL, pois o ataque pode ser realizado de outras formas, como manipulando parâmetros da URL ou outros dados de entrada que são usados nas consultas SQL.

---

### 3. Considere a aplicação WebGoat 5.3:

#### 3.1 A aplicação tem várias vulnerabilidades de injeção de SQL. Encontre estas vulnerabilidades nos ficheiros `SqlStringInjection.java` e `SqlNumericInjection.java` (note que, em Java, um comando SQL do tipo SELECT é feito através da chamada da função `executeQuery`).

- **Resposta**: O arquivo `SqlStringInjection.java` provavelmente contém uma vulnerabilidade onde uma string fornecida pelo usuário é concatenada diretamente a uma consulta SQL sem validação ou parametrização. Isso permite que um atacante insira código SQL malicioso.
- O arquivo `SqlNumericInjection.java` provavelmente lida com valores numéricos, mas sem sanitização, o que também pode permitir injeção de SQL se o número for utilizado diretamente na consulta.

#### 3.2 Para a vulnerabilidade no primeiro ficheiro, percorra o fluxo dos dados que chegam à linha vulnerável. Em que ficheiros/instruções entram os dados na aplicação? Por que ficheiros/instruções passam esses dados antes de chegarem à BD?

- **Resposta**: No `SqlStringInjection.java`, o fluxo dos dados pode começar com a entrada do usuário, como um campo de texto. O valor da entrada é então passado para uma função de construção de consultas SQL, como `String query = "SELECT * FROM users WHERE username = '" + userInput + "'";`. Essa consulta é posteriormente enviada ao banco de dados através de `executeQuery`. O ponto vulnerável ocorre porque a entrada do usuário não é tratada corretamente (ex: sem parametrização), permitindo que o atacante insira código SQL malicioso.

#### 3.3 Como poderia esta vulnerabilidade ser explorada?

- **Resposta**: O atacante poderia inserir um valor como `admin' OR '1'='1` no campo de entrada. Isso faria com que a consulta SQL fosse modificada para:  `SELECT * FROM users WHERE username = 'admin' OR '1'='1';` o que faria com que todos os registros da tabela `users` fossem retornados, permitindo ao atacante acessar dados sensíveis.

#### 3.4 Como deveria o código (genericamente) ser modificado para prevenir a exploração da vulnerabilidade?

- **Resposta**: O código deve ser modificado para usar **consultas parametrizadas** ou **prepared statements** em vez de concatenar diretamente as entradas do usuário nas consultas SQL. Por exemplo, no caso do Java, pode-se usar `PreparedStatement`:

```java
String query = "SELECT * FROM users WHERE username = ?";
PreparedStatement stmt = connection.prepareStatement(query);
stmt.setString(1, userInput);
ResultSet rs = stmt.executeQuery();
```

- Isso garante que a entrada do usuário seja tratada de maneira segura e evita a injeção de SQL.