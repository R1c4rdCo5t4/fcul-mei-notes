### 1. Considere um programa a correr em user mode. Explique detalhadamente como é que o SO e o processador cooperam de modo a impedir esse programa de executar operações arbitrárias (p. ex., escrever em qualquer posição do disco).

- Em user mode, a CPU e o SO cooperam de modo a impedir operações arbitrárias, usando:
	- **Proteção de memória:** os processos têm acesso à sua própria memória virtual
	- **System calls:** operações que requerem solicitações ao kernel, que verifica as permissões do chamador antes de as executar
	- **Modos de execução:** a CPU diferencia entre user mode kernel mode
	- **Interrupções e falhas:** tentativas de acesso não autorizado gerem exceções que interrompem o processo

### 2. Considere os quatro principais tipos de separação entre processos que podem existir num SO (física, temporal, lógica e criptográfica) e apresente para cada um deles:

#### 2.1 Definição.

- **Física:** cada processo é executado num hardware diferente
- **Temporal:** cada processo é executado em momentos diferentes
- **Lógica:** processos são executados no mesmo hardware e ao mesmo tempo mas executam isoladamente, através de memória virtual
- **Criptográfica:** dados de diferentes processos são encriptados

#### 2.2 Vantagens e desvantagens em termos de segurança, complexidade de concretização e eficiência de utilização de recursos.

- Física:
	- Vantagens: alta segurança
	- Desvantagens: alto custo e baixa eficiência
- Temporal:
	- Vantagens: menor custo
	- Desvantagens: maior complexidade, menor eficiência, vulnerável a timing attacks
- Lógica:
	- Vantagens: eficiência de recursos e alta flexibilidade com mecanismos de isolamento
	- Desvantagens: 

### 3. Um programa é executado num sistema Unix com setuid root.

#### 3.1 O que é que significa essa afirmação, ou seja, o que significa dizer que o programa corre com setuid root?

- O setuid root é uma permissão que permite que qualquer programa seja executado com privilégios de root, independentemente de quem o estiver a executar
- É usado para elevar temporariamente os privilégios de um programa para realizar tarefas específicas

#### 3.2 Será que este mecanismo é uma forma adequada de aplicar o princípio dos privilégios mínimos?

- Não, pois porque esse princípio estabelece que um processo ou utilizador deve ter apenas os privilégios necessários à sua execução, o que não e o caso
- Um programa com setuid root herda todos os privilégios de root, mesmo que apenas precise de alguns deles
- Se o programa tiver vulnerabilidades, estas podem ser exploradas para obter acesso root ao sistema

#### 3.3 O que são os sticky bits de utilizador e de grupo?

- Permissão para diretorias que restringe que utilizadores apaguem ou renomeiem arquivos dentro dessa diretoria
- Aparecem como `t` no final das permissões da diretoria `drwxrwxrwt`
- Útil em diretórios partilhados para evitar modificações indevidas

#### 3.4 Como é que os sticky bits se relacionam com a noção de setuid root?

- São ambos permissões especiais mas com propósitos diferentes
- Ambos afetam o comportamento de ficheiros ou diretorias e oferecem controlo sobre acesso e execução
- **setuid root**: permite que um programa seja executado com os privilégios de root, independentemente de quem o executa
- **sticky bit**: restringe a exclusão ou renomeação de ficheiros numa diretoria partilhada
- Ambos oferecem mecanismos adicionais de controlo, mas enquanto o setuid root lida com **elevação de privilégios** em executáveis, o sticky bit reforça o **controlo de acesso** em diretorias partilhadas.
- Ambos devem ser configurados com cuidado para evitar riscos de segurança
### 4. Uma forma de limitar os efeitos de uma intrusão num processo Linux consiste em usar o comando chroot. Como é que este comando limita esses efeitos concretamente?

- O comando **chroot** cria um ambient isolado conhecido como *chroot jail* onde o processo e os seus filhos têm uma visão limitada do sistema de ficheiros
- Util para limitar danos potenciais a uma intrusão
- Limitação dos efeitos de uma intrusão:
	- Redefinição do root directory
	- Isolamento
	- Proteção do sistema

### 5. Sob o ponto de vista do controlo de acesso, que impacto teria a opção de deixar utilizadores pouco privilegiados introduzirem código no núcleo do SO em tempo de execução (p. ex., em Linux, dando a todos os utilizadores a possibilidade de inserir módulos no núcleo – `su insmod`)?

- Tal seria altamente inseguro
- Quebra de isolamento, escalamento privilégios e compretimento o sistema
- Viola os princípios básicos de segurança

