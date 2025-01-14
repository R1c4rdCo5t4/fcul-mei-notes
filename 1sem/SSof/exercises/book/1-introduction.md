# Introdução à Engenharia de Software
### 1. Considere os três tipos de vulnerabilidades: de projeto, de codificação e operacionais. Apresente para cada um deles: a definição; dois exemplos; uma discussão sobre a dificuldade de correção.

- **Vulnerabilidades de projeto**
	- Definição: falhas no design/arquitetura do software, devido à falta de planeamento
	- Exemplo: não validação de inputs, mecanismos de autenticação inadequados
	- Dificuldade de correção: alta pois exige uma reestruturação do sistema
- **Vulnerabilidades de codificação**
	- Definição: vulnerabilidades devido a bugs no código
	- Exemplos: buffer overflows, format strings
	- Dificuldade de correção: moderada, geralmente limitada a partes específicas do código
- **Vulnerabilidades operacionais**
	- Definição: derivadas a configurações inadequadas do sistema
	- Exemplos: uso de default passwords, não aplicação de patches
	- Dificuldade de correção: baixa, mas depende do tipo de processos operacionais 

### 2. O que é que distingue uma vulnerabilidade 0-day de outra vulnerabilidade de codificação que não seja 0-day?

- **Vulnerabilidade 0-day:** é uma nova vulnerabilidade descoberta que não era conhecida pelo público e que ainda não tem correção
- **Vulnerabilidade de codificação:** vulnerabilidade já conhecida mas introduzida acidentalmente mas que tem correções conhecidas

### 3. Em que é que diferem a Common Weakness Enumeration (CWE) e o Common Vulnerabilities and Exposures (CVE) da MITRE Corporation?

- **CWE:** lista as fraquezas genéricas em software que podem levar a vulnerabilidades
- **CVE:** lista as vulnerabilidades específicas já conhecidas 

### 5. Explique o que significam os quatro valores que pode tomar a métrica vetor de ataque do CVSS: rede, rede adjacente, local, acesso físico.

- **Rede**: a vulnerabilidade pode ser explorada remotamente através da rede ou internet
- **Rede adjacente**: a exploração requer acesso a uma rede limitada, como uma sub-rede local
- **Local**: exige que o atacante tenha acesso ao sistema-alvo, por exemplo, por meio de login
- **Acesso físico**: requer estar fisicamente presente para explorar a vulnerabilidade

### 6. Dê exemplos de componentes da superfície de ataque de uma aplicação à sua escolha.

- User interface, file system, network
### 9. Em qual dos meios usados para garantir a confiabilidade de um sistema se pode considerar que está enquadrado o ato de remover uma vulnerabilidade de um pacote de software em produção usando um remendo: prevenção de faltas, tolerância a faltas, supressão de faltas ou previsão de faltas?

- O ato de remover uma vulnerabilidade de um pacote de software em produção num patch está enquadrado em **supressão de faltas**, pois envolve corrigir diretamente um problema já existente para evitar sua exploração ou impacto