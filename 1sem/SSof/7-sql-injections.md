# Database Vulnerabilities
### SQL
- **Structured Query Language (SQL)**
	- Language for retrieval and management of data in **Relational DBMS**
	- ANSI/ISO standard with **proprietary extensions**
- Relational model: **relations, attributes, domains**
- SQL elements

```sql
update country
set population = population + 1
where name = 'USA';
```

### SQL Injection
- Caused by unsanitized user input used directly in SQL commands, containing metacharacters that alter the commands
- **Example:**
	- username: `root`
	- password: `root' OR pass <> 'root`

```sql
SELECT * FROM logintable
WHERE user = 'root' AND pass = 'root' OR pass <> 'root' -- always true, returns whole table => information leak
```

- **Alternatives:**
	- username: `root' --`, turning the rest of the statement into a comment
- If the variable is an integer:
	- id: `1 or 1=1`, tautology to get the whole table

#### Injection Sources
- User input
- Cookies
- Environment variables
- HTTP headers

#### Second-Order Injection
- Input is provided so that it is kept in the system (often in the database) and later used
- Example:
	- Attacker registers a new user called `admin' --`
	- The site escapes and accepts the input
	- The attacker changes the password, gaining access to the admin account

```sql
update users set password='newpwd'
where username='admin' -- 'AND password='oldpwd'
```

- This problem can occur in **any application that manages data through a database**, not just web applications

### Attack Steps
- Identify parameters vulnerable to injection
- Database fingerprinting - find the **type+version** of the DB using queries that cause different responses
- Discover **DB schema** - table names, column names, column data types
- **Extract data from the DB** (breaking confidentiality)
- **Add/modify data in the DB** (breaking integrity)
- **Delete DB, tables or users** (breaking availability)
- Evade detection - clear fingerprints and history data (logs)
- Arbitrary command execution in the database
- Privilege escalation at the level of web application or database

### Protection
- **Parameterized SQL commands**
	- Separate the command from the potentially malicious data that is used at execution time
	- Ensure that data is only interpreted as data, and **not commands**

```java
PreparedStatement cmd = conn.prepareStatement("select accounts from users where login=? AND pass=?");
cmd.setString(1, login);
cmd.setString(2, password);
```

- **Whitelisting**
	- Only accept good input, instead of rejecting bad input
- **Input type checking**
	- Remove malicious input
	- Transform malicious input into something that cannot do any harm
- **Encoding of input to something that can be trusted**
	- Allow input with characters that might be interpreted as metacharacters

### Attack Strategies
#### Tautologies
- Inject code in or or more **conditional statements** so that it always evaluate to **true**, used in the where clause
- Most common uses:
	- Bypass authentication
	- Extract data
- Example: `' or 1=1 --`

#### Union Query
- Trick the application into returning arbitrary data by injection `union select ...`
- This allows an attacker to get information from **any table** in the system
- Only works with the `select` command
- Returns union of the intended data with injected query
- Requires that the **domain** and **number** of attributes of both selects to be equal
- Example: `select (...) where id='' union select (...) --`

#### Piggy-Backed Queries
- Add more independent queries
- Often can be injected in **any field** and allows the injection of **any type of command**
- Requires DB to be configured to **accept multiple statements** in a single string
- Uses the `;` metacharacter
- Example: `select (...) where id=''; drop table users --`

#### Stored Procedures
- Stored procedures are stored and executed inside the DBMS
- Sometimes it is assumed that stored procedures are the solution to avoid SQL injection attacks
- In practice, this does not solve the problem
- Vulnerability can either be SQL injection or the execution of commands at the OS level

#### Illegal/Incorrect Queries
- The objective is to find injectable parameters, DBMS type+version and schema by causing errors:
	- **Syntax errors:** allow the identification of injectable parameters
	- **Type errors:** support the deduction of data types of columns
	- **Logical errors:** often reveal names of tables and columns
- This queries both **SQL injection vulnerability** and **verbose error messages**

#### Inference
- With the same goal as illegal/incorrect queries
- For DBMS protected from those attacks by not returning any result with indicative information
- This type of attack attempts to infer if a certain condition on the state of the DBMS is true or false
- Two techniques:
	- **Blind injection**
		- Information is inferred by **asking true/false questions**
		- If answer is true the site typically continues normally
		- Otherwise the result will be different, although not descriptive
	- **Timing attacks**
		- Information is inferred from **timing delays in the response**
		- Usually with a branch that executes a `WAITFOR DELAY`

#### Alternate Encoding
- Useful to complement other attacks but a good trick to **evade detection mechanisms** (e.g., blacklists)
- The idea is to **encode input in an unusual format**: hexadecimal, ASCII, Unicode
- Example: `; exec(char(0x73687574646f776e)) --`, performs `exec(shutdown)`

### Other Vulnerabilities in DBMS's
- Blank or default password
- Default privileged accounts
- Unprotected communication
- Several open ports