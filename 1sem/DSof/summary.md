### Software Design
- **Conceptual Design** focuses on the system's behavior, user perception, and impact on the environment, with emphasis on requirements analysis and specification
- **Representation Design** handles the structural realization, including software architecture, module design and implementation
- **Architectural Design** organizes software into components and defines their interactions​​
- **Detailed Design** specifies the desired behavior of individual components

### Software Engineering
- Management processes of projects, requirements or settings to ensure that software development is completed on time, within budget and according to specifications
- Design, implementation, testing and documentation
- Engineering involves making rational decisions within limited time, knowledge and resources, forcing decisions based on tradeoffs
- Types of design:
	- **Normal design:** solving familiar problems with already existing solutions
	- **Radical design:** finding new solutions to unfamiliar problems (greater risk)
- Still not at the stage of **professional engineering** because there are no universal standards and consistent regulations, unlike, for example, civil engineering.
### Design Process
- The **design process** involves decision-making to produce a detailed and executable plan. It evaluates trade-offs and uses methods like **abstraction** to manage complexity.
- While good design may be marred by poor fabrication, usually no amount of constructional skill makes up to poor design.
- Unique aspects of software include its intangibility, complexity, and evolution. Challenges like **entropy** and **technical debt** impact long-term maintainability​.
- Software is **malleable**:
	- It allows for incremental development;
	- Consequently, it is more susceptible to the effects of entropy, accumulating technical debt;
	- Restoring order requires a explicit effort.
- **Entropy**: measure of disorder in a system.
- **Technical debt**: implied cost of future reworking needed when choosing an easy but limited short-term solution instead of a better and well-thought one.
- **Intangibility/Invisibility:** software is symbolic and abstract, which hinders communication
- **Conformity**: software, being *pliable*, is expected to conform to the standards imposed by other components, such as hardware, external bodies or existing software.
- **Atypical cost distribution**: the older a problem is, the harder it will be to detect and correct it, and the less likely it will be appropriately fixed.
- Development processes include:
    - **Waterfall Model**: Sequential stages with feedback loops.
    - **Incremental Development**: Prototypes evolve based on changing requirements.
    - **Spiral Model**: Iterative approach emphasizing risk management​.
- **Verification vs Validation:**
	- **Verification**: Are we building the product right? - detects inconsistencies between design and specification. 
	- **Validation**: Are we building the right product? - detects inconsistencies between design and actual user needs.
- #### Maintenance Types 
	- **Perfective Maintenance**: extending/improving a system with new functionality. 
	- **Adaptive Maintenance**: adjusting to external changes like new laws or operating systems. 
	- **Corrective Maintenance**: fixing bugs in the operational system. 
### Software Quality
- Key attributes include **reliability, performance efficiency, maintainability, usability, availability, and security**.
- **Quality dimensions** span technical, business, process, and human factors.
- **Design principles** like modularity, separation of concerns and SOLID principles help achieve quality goals.
- **Techniques:**
	- **Decomposition/Modularity**: the process of breaking a system into smaller, manageable and independent components (modules), improving maintainability and scalability.
		- **Information Hiding**: a module's internal details are hidden, exposing only what is necessary to the outside, reducing complexity and interdependencies.
		- **Encapsulation**: the bundling of data and methods that operate on that data within a single unit (e.g., a class), ensuring that the internal workings are protected from outside interference and misuse.
	- **Standardization:** algorithms, data structures, coding standards, documentation practices, design patterns, architectural patterns, APIs, ...
- **Complexity metrics:**
	- **Halstead Volume**: measures the size of the code based on the number of operators and operands, estimating the cognitive effort needed to understand the program.
	- **Cyclomatic Complexity**: indicates the number of linearly independent paths through the code, reflecting its logical complexity and potential for errors.
	- **Maintainability Index**: a composite metric that assesses how easy it is to maintain code, factoring in cyclomatic complexity, Halstead Volume and lines of code (LoC).
	- **Information Flow Complexity**: evaluates the complexity based on the flow of information between modules, considering how data is passed through the system.


### Scenarios and Tactics
- Quality attributes (e.g., usability, performance) are achieved through **architectural tactics**:
    - **Modifiability**: Increase cohesion, reduce coupling.
    - **Performance**: Prioritize resource allocation, use concurrency.
    - **Security**: Implement encryption, intrusion detection.
    - **Usability**: Provide user feedback, mitigate errors​.

### Software Architecture
 - The software architecture of a system is the **set of structures** needed to reason about the system, which comprise:
	- software **elements**
	- **relations** among them
	- external visible **properties** of both
 - **Prescriptive**:
	- Decisions of the future - architecture as it should be
	- Idealized version of the past - architecture as it should have been
- **Descriptive**:
	- Decisions of the past - architecture as it is
	- Maybe complex due to repeated violations and shortcuts taken
	- May have to be "recovered" from actual system (architectural archeology)
- Three major aspects:
	- **Communication among stakeholders**
	- **Early design decisions**
	- **Transferable abstraction of a system**
- A documented architecture is an effective **communication vehicle** within the project, among all parties involved - basis for **mutual understanding**.
### Stakeholders
- Each party involved in a system is concerned with its different characteristics, which depend on the chosen architecture, and often, their interests conflict.
- Some stakeholders include:
	- **End user:** the architecture ensures the reliability, usability and availability of the system.
	- **Client:** possibility of the system with this architecture being implemented within a certain timeframe and budget.
	- **Project manager:** ensuring that the client's expectations are met plus the possibility of the system being developed by different teams independently, interacting in a disciplined and controlled manner.
	- **Architect:** strategies to achieve all these objectives that are difficult to reconcile.

### Architectural Views
- Represent and document software structures with a set of system elements and the relations associated with them.
- **Module Views**: Describe code structure and relationships like decomposition, uses, and layering.
- **C&C Views**: Focus on runtime behavior using components (services, processes) and connectors (protocols, data flows).
- **Allocation Views**: Map software elements to hardware, file systems, or organizational units​​.

### Architectural Styles
- **Module-Centered Styles**:
    - **Layered**: Promotes modifiability and testability; used in hierarchical systems.
-  **C&C Styles**:
    - **Pipe-and-Filter**: Sequential, independent data processing.
    - **Client-Server**: Centralized servers serving distributed clients.
    - **Publish-Subscribe**: Loosely coupled components communicating via events.
    - **Repository**: Central data store accessed by clients.
-  **Distributed Styles**:
    - **Broker**: Decouples clients and servers using a mediator.
    - **Service-Oriented Architecture (SOA)**: Independent services communicate using standards like SOAP or REST.
    - **Microservices**: Independent, small-scale services focusing on modularity and scalability​​.
- Style vs Pattern:
	- Styles are broad and focus on system structure, patterns address specific design problems.
- Reference Model vs Reference Architecture:
	- The **reference model** defines standard functionality and data flows, providing a mature solution to common problems.
	- The **reference architecture** Implements the reference model in software, mapping it to system elements and their interactions.

### Scenarios and Tactics
- **Quality Attributes:**
	- Measurable or testable properties that **indicate how well a system satisfies the stakeholder needs**.
	- Examples: usability, performance, availability, security, modifiability, testability, reliability, etc.
- **Quality Attribute Scenarios:**
	- Describe specific requirements for quality attribute.
	- Examples:
		- **Performance**: 1,000 transactions per minute processed with an average latency of 2 seconds.
		- **Availability**: system recovers within a specified time after detecting a fault.
		- **Usability**: cancelling an operation takes less than one second.
		- **Modifiability:** when a developer wants to add a new feature, the change should be implemented, tested and deployed within 3 hours with no impact on existing functionality.
- **Architectural Drivers:**
	- Critical requirements and constraints that shape the system's architecture.
- **Functional requirements** describe what the system does, **quality requirements** describe how well the system performs under specific conditions.

### Software Product Lines (SPL)
- SPL enables **systematic reuse** by creating core assets (e.g., architectures, components) for multiple products.
- **Reuse libraries** or **clone and own** strategies.
- Core activities:
    - **Domain Engineering**: Develop reusable artifacts.
    - **Application Engineering**: Customize assets for specific products.
    - **Variability Management**: Postpone decisions to customize systems.
- Benefits include reduced time-to-market, cost savings and improved quality​.
- Reusability, testing and improved quality.