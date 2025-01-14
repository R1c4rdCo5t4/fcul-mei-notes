### 1. Considere um PC doméstico e um servidor de homebanking de um banco. Qual deles está sujeito a um maior risco na Internet? Justifique usando para tal a fórmula de cálculo do risco.

- O servidor de homebanking está sujeito a um maior risco na internet
- **Risco = Ameaça x Vulnerabilidade x Impacto**
	- **Ameaça:** os servidores de homebanking são alvos mais atrativos para atacantes
	- **Vulnerabilidade:** a complexidade de um sistema bancário pode aumentar a attack surface e a possibilidade de falhas
	- **Impacto:** seria muito maior, afetando milhares de clientes e o banco

### 2. Considere que determinada aplicação de uma empresa tem um determinado nível de risco. Quais dos fatores da fórmula do risco seriam afetados:

#### 2.1 Pela descoberta e encarceramento de um gangue de ciber-criminosos que ameaçavam a aplicação.

- **Ameaça**, pois reduziria a probabilidade de ataca, diminuindo o risco

#### 2.2 Pelo facto de a empresa descobrir e remover diversas vulnerabilidades da aplicação.

- **Vulnerabilidade**, pois reduz a probabilidade de exploração, diminuindo o risco

### 3. Discuta as vantagens e desvantagens, em termos de segurança de software, da utilização de código aberto versus código fechado.

- **Open source:**
	- Vantagens:
		- Transparência - ao ser acessível a todos, permite auditorias independentes para identificar vulnerabilidades
		- Colaboração - todos podem contribuir para patches de bugs
	- Desvantagens:
		- Exposição - os atacantes também conseguem visualizar o código, tornando o seu trabalho mais fácil
		- Falta de suporte dedicado - a correção de falhas depende da comunidade, podendo ter qualidade variável
- **Closed source:**
	- Vantagens:
		- Acesso restrito - o código não está publicamente acessível, o que dificulta um pouco os atacantes a analisar o código
		- Suporte centralizado - os developers fornecem suporte e atualizações controladas, com uma responsabilidade definida
	- Desvantagens:
		- Security by obscurity - os atacantes conseguem visualizar o código na mesma através de decompiling tools
		- Correção lenta - patches dependem exclusivamente de uma única entidade
- Resumindo:
	- O **código aberto** é ideal para projetos com uma comunidade forte e ativa, mas depende dela para evitar riscos
	- O **código fechado** oferece controlo centralizado e proteção por obscuridade, mas a sua segurança depende exclusivamente da empresa
	
### 4. Em que fase do modelo em cascata (waterfall model) deve ser levada em linha de conta a legislação sobre o roubo de dados pessoais?

- Deve ser considerada durante a fase de requisitos, em que são identificados e documentados os requisitos legais que o sistema deve cumprir.

