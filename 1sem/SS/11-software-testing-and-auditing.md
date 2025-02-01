# Software Testing and Auditing

### Software Testing
- Security testing is **essential** to building secure applications
- Applications can fail in countless ways - limited resources must focus on risks relevant to the business
- Tools assist but **do not guarantee security** - manual and technical testing are required.
- A balanced testing approach spans all phases of the **Software Development Life Cycle (SDLC)**

### OWASP Testing Framework
- **End-to-end testing framework** for secure software development:
    - **Before Development**: define security standards, select an SDLC, establish metrics
    - **During Definition/Design**:
        - Review security requirements for gaps
        - Analyze architecture and design
        - Conduct threat modeling to identify and mitigate risks
    - **During Development**:
        - Perform code reviews and walkthroughs
        - Ensure adherence to secure coding practices
    - **During Deployment**:
        - Conduct penetration testing
        - Verify configuration management
    - **During Maintenance**:
        - Periodic health checks and security audits
        - Approve and verify changes to maintain security

### Threat/Attack Modeling
- **Objective:** Identify, characterize and prioritize potential threats and how they can affect the system
- Should be **done early** in the SDLC or when the system is about to be rolled out
- Serves as basis for **risk management**
- How we can address attacks:
	- **Mitigate the threat:** placing the protection/control mechanisms to prevent the exploitation
	- **Eliminate threat:** removing the vulnerability (e.g., by eliminating a feature of the system) 
	- **Transferring the threat:** let someone or something else handle the risk (e.g., use other system to do authentication)
	- **Accept the risk:** accept that for some attacks you are willing to live with the risk
- **Steps:**
    1. Define scope and gather information.
    2. Decompose the application (e.g., using Data Flow Diagrams).
    3. Identify vulnerabilities (e.g., STRIDE taxonomy: Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service, Elevation of Privilege).
    4. Build attack/threat trees to model and address vulnerabilities.
    5. Rank vulnerabilities using risk assessment (e.g., DREAD methodology).

#### Step 1 - Information Gathering
- Compile information about the application that might be useful
	- Major components
	- Use cases
	- Entry points
	- Assets
	- External entities
	- External trust levels

#### Step 2 - Decompose Application
- Decompose system in components that make sense from an architectural point of view
- Data Flow Diagrams (DFDs) or UML

#### Step 3 - Identify Vulnerabilities
- Identify potential attack objectives/vulnerabilities for each interaction and component of the decomposition from the previous step
- **STRIDE** Taxonomy:
	- **S**poofing identity - allows an attacker to pose as a valid entity
	- **T**ampering with data - malicious modification of data
	- **R**epudiation - possibly of denying to produce a certain event
	- **I**nformation disclosure - data leak
	- **D**enial of service - negation of some component's service to users/components
	- **E**levation of privilege - increase of the privileges of the attacker
- Tips to stay on track:
	- **Keep some order** when performing the analysis
	- **Never ignore a threat**
	- **Focus on feasible threats** (relevant ones)

#### Step 4 - Build Threat/Attack Trees
- For each identified attack objective/vulnerability, one should describe the impact and possible solutions
- **Fault trees** are used in dependability and software safety to identify failure modes

#### Step 5 - Rank vulnerabilities
- The goal is to **help** prioritize the vulnerabilities that must be addressed first
- **Risk** is a very relevant cost metric that can serve as a basis for the ranking
- Can be assessed from the average of the DREAD values
- **DREAD:**
	- **D**amage potential - potential damage caused by the exploitation of the vulnerability
	- **R**eproducibility - difficulty to replicate the attack in a real environment
	- **E**xploitablity - how much expertise and effort is required
	- **A**ffected users - if the attack is successful
	- **D**iscoverability - how easy for an attacker to discover the vulnerability

### Benefits of Threat Modeling
- Identifies **vulnerabilities** and **bugs** early
- Documents applications for better **team understanding**
- Guides testers on priority areas for **security checks**

### Software Auditing
- Aims at **identifying security flaws** along with their **root causes** in software projects at the:
	- Design phase
	- During the implementation

### Code Review
- Key focus on identifying security flaws in design and implementation phases
- **Code review phases:**
    1. Pre-assessment: Scope definition and information collection
    2. Main review phase: Identify vulnerabilities and their root causes
    3. Documentation: Record findings, analyze risks, and suggest remediations
    4. Support: Assist in implementing fixes
- **Strategies:**
    - Systematic code reading for detailed vulnerability identification
    - Target specific vulnerabilities using taxonomies like STRIDE or tools
    - Assess design logic to detect flaws
- **Tactics:**
    - Focus on error-checking branches and dependencies
    - Reread code and employ desk-checking techniques
    - Use test cases to validate code behavior

#### Tools for Code Review
- Source code navigators (e.g., Cscope, Ctags)
- Binary navigators (e.g., IDA Pro)
- Debuggers and fuzzers for dynamic analysis

#### Challenges and Alternatives
- Attack modeling is **resource-intensive but essential**
- Use **patterns and automated tools** for scalability (e.g., topological vulnerability analysis)
- **Risk assessment frameworks** (e.g., OCTAVE, OWASP CLASP) provide structured methodologies