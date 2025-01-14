### 1. Considere o excerto de código C da Figura 5.32 (exercícios do Capítulo 5) que contém uma vulnerabilidade de buffer overflow:

#### 1.1 De que modo uma ferramenta de análise estática que faça análise de lista de léxico (p.ex., RATS, Flawfinder, ITSA) processaria este programa e descobriria a vulnerabilidade? Explique o processo de análise, comparando-o com o processo de compilação.

**Resposta**: 
- Ferramentas de **análise estática** como RATS ou Flawfinder verificam o código-fonte em busca de padrões de vulnerabilidades conhecidas. Estas ferramentas analisam as chamadas de funções como `strcpy`, que podem ser fontes de vulnerabilidades de buffer overflow se não houver validação de tamanho.
- Durante a **análise estática**, essas ferramentas detectam locais onde entradas não verificadas são copiadas para buffers de tamanho fixo, identificando potenciais riscos sem precisar compilar ou executar o programa.
- Em comparação com o processo de **compilação**, que gera o código executável, a análise estática foca em identificar problemas durante o desenvolvimento, antes mesmo de o programa ser executado.

#### 1.2 Responda à mesma pergunta considerando uma ferramenta de análise de comprometimento (p.ex., QUAL ou Splint).

**Resposta**: 
- Ferramentas de **análise de comprometimento** como QUAL ou Splint verificam se o código pode ser vulnerável a falhas de segurança, analisando fluxos de dados e chamadas de funções arriscadas.
- **QUAL** pode verificar as interações dos dados com funções como `strcpy`, enquanto **Splint** pode garantir que os dados não sejam manipulados de maneira insegura, verificando o tipo e a origem dos dados. Essas ferramentas ajudam a detectar falhas potenciais de forma mais abrangente do que a análise de listas de léxico, ao focar nas propagação de dados de forma mais dinâmica.

---

### 2. Considere um programa C que lê uma `string` de uma entrada não confiável, por exemplo, da rede, e depois copia-a para uma `string` `str` de comprimento fixo, usando a função `strcpy`. O programa é vulnerável a buffer overflows, pois a `string` recebida pode ser mais longa do que o espaço disponível em `str`. Como é que uma ferramenta de análise de comprometimento analisaria o programa e encontraria essa vulnerabilidade? Explique especificamente como a noção de comprometimento é usada na análise. Indique as regras de propagação de comprometação para as entradas de dados.

**Resposta**:
- A ferramenta de análise de comprometimento analisaria o fluxo de dados da entrada para a variável `str`. O comprometimento ocorre quando dados de uma fonte não confiável (como a rede) são usados sem validação em funções que manipulam buffers de tamanho fixo, como `strcpy`.
- A análise se concentraria na **origem dos dados** (entrada da rede) e no **destino** (buffer `str`), verificando se o programa pode ser afetado por dados inesperados que ultrapassam o limite do buffer, resultando em **buffer overflow**.
- As regras de propagação de comprometimento indicariam que os dados provenientes da rede (entrada não confiável) são manipulados diretamente em `strcpy`, criando uma falha de segurança.

---

### 3. Considere um programa semelhante ao da pergunta anterior e com a mesma vulnerabilidade, mas no qual a `string` é recebida de uma nova função `f1` e copiada para `str` através de uma função `strcpy`. Qual seria o efeito de usar uma ferramenta de análise de comprometimento e como ela encontraria essa vulnerabilidade? Note que nesse caso é preciso fazer análise à chamada global, não apenas local.

**Resposta**:
- A ferramenta de análise de comprometimento verificaria a **origem da `string`** (que agora vem de uma função `f1`) e seguiria o caminho até a função que copia a `string` para o buffer `str`. Mesmo que a vulnerabilidade tenha se movido para uma função separada, a ferramenta ainda analisaria como os dados fluem de uma função para outra.
- A análise de comprometimento deve rastrear as **entradas externas** (dados provenientes da função `f1`) e garantir que elas sejam tratadas corretamente antes de serem passadas para `strcpy`. A vulnerabilidade ocorre quando a entrada não é validada e a função `strcpy` a usa para sobrescrever o buffer sem verificar o tamanho, causando o **buffer overflow**.

---

### 4. Considerando o mesmo exemplo do exercício anterior, explique os três passos do funcionamento de uma ferramenta que conduza a análise através de entradas sintáticas abstratas realizadas pelos **scanners**, **pré-processadores** ou **parsers**.

**Resposta**:
- **Scanner**: O scanner examina o código-fonte em busca de padrões de texto que possam representar entradas de dados ou funções perigosas, como `strcpy`. Ele marca pontos críticos no código.
- **Pré-processador**: O pré-processador verifica e manipula o código antes da análise, lidando com macros, definições e diretivas que podem afetar como os dados são tratados, como expandir funções e condicionais.
- **Parser**: O parser interpreta a estrutura do código, analisando como as funções e variáveis interagem, e verifica se a propagação dos dados pode resultar em falhas como buffer overflows. Ele constrói uma árvore de sintaxe abstrata para representar o fluxo do código e identifica onde os dados podem ser comprometidos.

---

### 5. Considere uma ferramenta de análise de controle de fluxo. Explique qual é a importância dessa análise e como ela pode ser usada para encontrar vulnerabilidades de segurança.

**Resposta**:
- A **análise de controle de fluxo** verifica como os dados fluem através do programa, especialmente em estruturas de controle como loops, condições e chamadas de funções. Ela pode identificar onde entradas não validadas são manipuladas em funções críticas, ajudando a detectar pontos de vulnerabilidade.
- Essa análise é importante porque permite identificar onde os dados podem ser corrompidos ou manipulados indevidamente, e garante que dados confiáveis não sejam utilizados em operações inseguras, como funções de cópia de buffer.

---

### 6. O programa PHP da Figura 14.11 é vulnerável a ataques de injeção de SQL. Explique como esse código poderia ser vulnerável.

**Resposta**:
- O programa PHP provavelmente utiliza **entradas de usuário** (como campos de formulários ou parâmetros de URL) diretamente em consultas SQL sem **sanitização adequada**. Isso cria uma vulnerabilidade de **injeção de SQL**, onde um atacante pode injetar código SQL malicioso em uma entrada de usuário, comprometendo a segurança do banco de dados.