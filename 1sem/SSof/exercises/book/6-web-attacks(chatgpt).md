### 1. Considere os três principais tipos de vulnerabilidades de XSS e apresente para cada um deles:

#### 1.1 Definição:
- **Reflected XSS**: O código malicioso é refletido diretamente de volta ao navegador do usuário após ser enviado ao servidor. O ataque é executado imediatamente sem ser armazenado.
- **Stored XSS**: O código malicioso é armazenado no servidor e, posteriormente, é refletido de volta ao navegador do usuário quando a página é carregada.
- **DOM-based XSS**: O código malicioso é executado diretamente no lado do cliente, manipulando o DOM sem necessidade de interagir com o servidor.

#### 1.2 Exemplo de um cenário onde a vulnerabilidade pode ser explorada por um atacante. Indique a sequência de ações que o atacante e a vítima precisam executar, assim como aquilo que o atacante consegue obter com o ataque.

- **Reflected XSS**:
  1. O atacante cria um link malicioso que contém código JavaScript (ex.: `http://site.com/search?query=<script>alert(1)</script>`).
  2. O atacante envia esse link para a vítima, fazendo com que a vítima clique no link.
  3. O site reflete o código malicioso de volta na resposta ao navegador da vítima.
  4. O código JavaScript é executado no navegador da vítima, podendo roubar cookies, redirecionar para outro site ou executar ações sem o consentimento da vítima.

---

### 2. Considere a aplicação WebGoat 5.3:

#### 2.1 Quantos ficheiros de código tem a aplicação?

- **Resposta**: A aplicação WebGoat possui diversos ficheiros de código, sendo composta por várias classes Java e outros arquivos associados, como arquivos JSP. O número exato pode variar, mas a aplicação tipicamente tem cerca de **30 a 40** arquivos de código.

#### 2.2 Quais são as interfaces da aplicação cuja proteção é mais importante?

- **Resposta**: As interfaces mais críticas são aquelas que recebem entradas de usuário diretamente e as processam sem validação adequada, como **formularios de login**, **pesquisa**, **comentários**, etc. Estas são as que mais frequentemente podem ser exploradas para ataques como XSS e injeção de SQL.

#### 2.3 O ficheiro `ReflectedXss.java` é vulnerável a um ataque de XSS por reflexão? Por quê?

- **Resposta**: Sim, o arquivo `ReflectedXss.java` é vulnerável a ataques de **XSS por reflexão** porque ele reflete diretamente a entrada do usuário para a resposta HTTP sem qualquer sanitização ou validação, permitindo a execução de código malicioso diretamente no navegador da vítima.

#### 2.4 Como é que a vulnerabilidade identificada na alínea anterior poderia ser explorada?

- **Resposta**: O atacante pode injetar código JavaScript malicioso no campo de entrada e, quando a vítima acessar o link gerado, o código será refletido na página e executado no navegador da vítima. Isso pode levar ao roubo de cookies, credenciais de login ou execução de comandos indesejados.

#### 2.5 Como é que a vulnerabilidade deveria ser corrigida?

- **Resposta**: A vulnerabilidade pode ser corrigida utilizando **sanitização de entrada** (por exemplo, escapando caracteres especiais como `<`, `>`, e `&`) e validando as entradas do usuário para garantir que código HTML ou JavaScript não seja interpretado no lado do cliente.

---

### 3. Explique as diferenças entre as vulnerabilidades de XSS e CSRF e apresente uma discussão sobre qual das duas vulnerabilidades é mais crítica num site de web de homebanking.

- **XSS (Cross-site Scripting)**: O atacante injeta código malicioso (geralmente JavaScript) que é executado no navegador da vítima. O objetivo é roubar dados sensíveis, como cookies de sessão, ou manipular a interação do usuário com o site.
- **CSRF (Cross-site Request Forgery)**: O atacante força a vítima a realizar ações indesejadas em um site em que ela está autenticada, como transferir dinheiro ou alterar configurações de conta, sem o consentimento da vítima.

- **Qual é mais crítica em homebanking?**
  - **CSRF** é mais crítica em um site de homebanking, pois permite que um atacante faça ações em nome da vítima, como transferir dinheiro ou modificar informações bancárias, sem que o usuário tenha noção de que está sendo manipulado. XSS, embora perigoso, geralmente só rouba dados sensíveis como cookies de sessão.

---

### 4. Considere uma página web cujo código HTML/JavaScript é o apresentado na Figura 8.19. A aplicação web que inclui esta página pode ser alvo de um ataque de XSS de que tipo? Justifique.

A aplicação web pode ser alvo de um ataque **XSS Refletido (Reflected XSS)**.

**Justificativa:**
- O código utiliza o **document.URL** para ler a URL da página e extrair o valor do parâmetro `acesso` a partir dela.
- Esse valor é então diretamente inserido no documento com `document.write`, o que significa que qualquer dado enviado na URL pode ser interpretado e executado no navegador do usuário.
- Se a URL contiver código JavaScript malicioso, ele será refletido na página e executado, podendo comprometer a segurança do usuário. Por exemplo, se um atacante enviar uma URL com um parâmetro como `acesso=<script>alert('XSS')</script>`, o JavaScript será executado no navegador da vítima, causando um ataque **XSS Refletido**.

Para evitar esse tipo de vulnerabilidade, o conteúdo da URL deve ser devidamente **sanitizado** antes de ser inserido na página.

---

### 5. Recorde o que se disse sobre SEED Labs do que falamos nos exercícios do Capítulo 5.

#### 5.1 Resolva uma das versões do Cross Site Scripting Attack Lab que se encontra em Web Security Labs.

- **Resposta**: A versão do Cross Site Scripting (XSS) Attack Lab do SEED Labs pode ser resolvida seguindo o passo a passo fornecido no laboratório, que envolve identificar as vulnerabilidades de XSS em uma aplicação web e aplicar técnicas de prevenção, como sanitização de entrada e uso de medidas de segurança adequadas para evitar injeções de código malicioso.
