# Software Auditing
### 1. O diagrama de fluxo de dados da Figura 12.2 ignora o papel do programador da aplicação web. Estenda esse diagrama de modo a incluir este papel (começando pela nova entidade externa “programador aplicação”).

**Resposta**: Para incluir o "programador aplicação" no diagrama de fluxo de dados, devemos adicionar uma nova entidade externa no diagrama, que interage com a aplicação web. O programador da aplicação pode ter um papel essencial no processo de desenvolvimento, manipulando o código da aplicação, integrando funcionalidades externas e corrigindo vulnerabilidades. O fluxo de dados agora deve incluir interações do programador com a aplicação, como modificações no código, validações de segurança e a implementação de novas funcionalidades, além de como os dados são tratados durante o desenvolvimento.

---

### 2. Introduza o diagrama da Figura 12.2 na SDL Threat Modeling Tool da Microsoft. Complete o processo de análise de ameaças para, pelo menos, um dos processos e uma das interações do diagrama.

**Resposta**: Para realizar este exercício, você precisará importar o diagrama da Figura 12.2 no **SDL Threat Modeling Tool** da Microsoft. Depois de importar o diagrama, o processo de análise de ameaças pode ser feito para um dos processos identificados. A análise de ameaças envolveria a identificação de pontos de vulnerabilidade, como a exposição de dados sensíveis, possíveis ataques de injeção, falhas de autenticação, etc. O diagrama poderia incluir interações como o envio de dados do cliente para o servidor e, em seguida, avaliar potenciais ameaças a partir dessa interação.

---

### 3. Suponha que deve fazer uma revisão manual de código, mas que tem sérias restrições de tempo. Que tipo de estratégia usaria? Uma estratégia de compreensão de código, de pontos candidatos ou de generalização de projeto? Justifique.

**Resposta**: Dado que há **restrições de tempo**, uma **estratégia de compreensão de código** seria a mais eficaz. Isso porque ela foca em identificar rapidamente os pontos mais vulneráveis ou críticos do código. Ao contrário da análise de "pontos candidatos", que poderia ser mais extensa e detalhada, ou da **generalização de projeto**, que pode ser muito ampla e demorada, a compreensão de código permite identificar falhas específicas, como injeções SQL, falhas de autenticação, ou erros em manipulação de dados de maneira mais eficiente.

---

### 4. Compare as estratégias genéricas de compreensão de código (CC) e de pontos candidatos (PC) em termos de:

#### 4.1 Como cada uma é posta em prática.

**Resposta**: 
- **Compreensão de código (CC)**: Requer uma análise linha a linha do código-fonte, identificando erros de lógica e vulnerabilidades específicas no código. Esse processo geralmente é feito de forma manual ou utilizando ferramentas automatizadas que analisam o código.
- **Pontos candidatos (PC)**: Identifica áreas específicas ou componentes do código que são mais suscetíveis a falhas, como módulos que interagem diretamente com a entrada de dados. Foca-se na seleção de pontos de alto risco, e não em uma análise completa do código.

#### 4.2 Consumo de tempo.

**Resposta**: 
- **Compreensão de código (CC)** tende a ser mais demorado, pois envolve uma análise minuciosa de cada linha de código e pode exigir mais esforço manual ou ferramentas de análise.
- **Pontos candidatos (PC)** é mais rápido, pois foca apenas em áreas específicas do código que têm maior probabilidade de serem vulneráveis, economizando tempo ao não exigir uma revisão de todo o código.

#### 4.3 Facilidade em encontrar vulnerabilidades de projeto.

**Resposta**: 
- **Compreensão de código (CC)** pode ser mais eficaz em encontrar vulnerabilidades de projeto, pois envolve uma análise detalhada do código, permitindo detectar erros de implementação ou falhas que não são visíveis na estrutura do projeto.
- **Pontos candidatos (PC)** pode ser eficiente para identificar vulnerabilidades evidentes em componentes específicos do sistema, mas pode não ser tão abrangente na identificação de falhas de projeto mais sutis.

---

# Software Testing
### 1. Considere a noção de monitorização no domínio da injeção de ataques.

#### 1.1 O que se entende por monitorização neste domínio?
- **Resposta**: Monitorização neste domínio refere-se à observação e análise contínua de sistemas e redes para detectar tentativas de injeção de ataques, como **injeção SQL**, **XSS**, ou **injeção de comando**. O objetivo é identificar quando e onde as vulnerabilidades são exploradas por atacantes, permitindo uma resposta rápida e a mitigação dos riscos.

#### 1.2 Por que razão é difícil fazer monitorização com precisão elevada, ou seja, descobrindo exatamente quando são ativadas vulnerabilidades?
- **Resposta**: A monitorização de injeção de ataques é difícil porque muitas vezes as tentativas de exploração não geram sinais visíveis ou imediatos, ou são encobertas por mecanismos como **obfuscação**. Além disso, as vulnerabilidades podem ser exploradas de formas muito específicas, tornando a detecção difícil sem o uso de técnicas avançadas como **análise de comportamento** ou **análise de tráfego** em tempo real. Também pode haver uma grande quantidade de **falsos positivos** e **falsos negativos**.

---

### 2. Suponha que pretende fazer injeção de ataques para fazer auditoria de segurança de um serviço de rede, por exemplo, um servidor de web, DNS, SMTP ou IMAP. Seria preferível usar um injetor de ataques, um **fuzzer** ou um **proxy**? Justifique.

- **Resposta**: 
  - A utilização de um **fuzzer** seria a mais indicada para descobrir falhas de segurança, pois um fuzzer gera entradas aleatórias ou sem estrutura, permitindo testar um grande número de possíveis **caminhos de execução** no serviço de rede. Isso pode ajudar a encontrar vulnerabilidades relacionadas a **buffer overflows**, falhas de validação e outras falhas inesperadas.
  - Um **proxy** é útil para interceptar e modificar requisições entre o cliente e o servidor, permitindo manipulação de parâmetros específicos. Porém, ele é mais eficaz em ataques como **injeção de SQL** ou **XSS**, e não necessariamente para auditorias em serviços de rede mais complexos.
  - Um **injetor de ataques** pode ser útil em alguns casos, mas geralmente é mais específico para ataques predefinidos e pode não cobrir a variedade de falhas que um **fuzzer** pode encontrar.

---

### 3. Compare o **fuzzing aleatório**, **recursivo** e **substitutivo** em termos das vantagens e desvantagens relativas.

- **Fuzzing Aleatório**:
  - **Vantagens**: Simples de implementar e gera entradas rapidamente, testando muitos caminhos de execução. Útil para detectar falhas inesperadas.
  - **Desvantagens**: Não garante uma cobertura de teste adequada. Pode gerar muitos falsos positivos e não explorar bem todas as áreas do código.
  
- **Fuzzing Recursivo**:
  - **Vantagens**: Explora mais profundamente as interações internas e o estado do sistema, permitindo detectar falhas mais complexas.
  - **Desvantagens**: Mais lento e complexo de implementar. Pode exigir mais recursos computacionais e tempo de execução.
  
- **Fuzzing Substitutivo**:
  - **Vantagens**: Foca na substituição de valores existentes para ver como o sistema responde, ideal para encontrar falhas em pontos específicos como buffers ou vetores de dados.
  - **Desvantagens**: Menos abrangente do que os outros métodos. Não explora tanto as diferentes combinações de entradas como no fuzzing aleatório.

---

### 4. Suponha que pretende descobrir se um conjunto de campos de uma página web era vulnerável à injeção de SQL. Seria preferível usar **fuzzing aleatório**, **recursivo** ou **substitutivo**? Justifique.

- **Resposta**: **Fuzzing Substitutivo** seria o mais adequado. A injeção de SQL frequentemente explora parâmetros específicos, como valores de texto ou números em formulários, que podem ser manipulados diretamente. O fuzzing substitutivo, ao substituir valores de entrada por diferentes tipos de dados ou strings maliciosas, pode identificar como o sistema responde a diferentes tipos de injeção de SQL, como falhas de concatenação ou erros de parsing.

---

### 5. Explique as principais diferenças entre um **fuzzer** para aplicações web e um **fuzzer** para varredor de vulnerabilidades web.

- **Resposta**:
  - Um **fuzzer** para **aplicações web** geralmente foca na **entrada do usuário** (como campos de formulários ou URLs) e gera dados maliciosos ou inesperados para verificar como a aplicação lida com essas entradas. Ele testa a robustez da aplicação a falhas de segurança como **XSS**, **injeção de SQL**, **CSRF**, entre outros.
  - Um **fuzzer** para **varredor de vulnerabilidades web** pode ser mais abrangente, realizando uma varredura completa na aplicação e tentando identificar configurações de segurança incorretas, falhas de autenticação, permissões inadequadas e outras vulnerabilidades de segurança em um nível mais profundo. Ele geralmente é usado para testar uma aplicação web de forma mais automática, sem focar exclusivamente em tipos específicos de falhas, mas simulando comportamentos reais do usuário.

