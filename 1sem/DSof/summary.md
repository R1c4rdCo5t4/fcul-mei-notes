### Software Design
- **Conceptual Design** focuses on the system's behavior, user perception, and impact on the environment, with emphasis on requirements analysis and specification
- **Representation Design** handles the structural realization, including software architecture, module design and implementation
- **Architectural Design** organizes software into components and defines their interactions​​
- **Detailed Design** specifies the desired behavior of individual components

### Design Process
- The **design process** involves decision-making to produce a detailed and executable plan. It evaluates trade-offs and uses methods like **abstraction** to manage complexity.
- Unique aspects of software include its intangibility, complexity, and evolution. Challenges like **entropy** and **technical debt** impact long-term maintainability​.
- Development processes include:
    - **Waterfall Model**: Sequential stages with feedback loops.
    - **Incremental Development**: Prototypes evolve based on changing requirements.
    - **Spiral Model**: Iterative approach emphasizing risk management​.

### Software Quality
- Key attributes include **reliability, performance efficiency, maintainability, usability, availability, and security**.
- **Quality dimensions** span technical, business, process, and human factors.
- **Design principles** like modularity, separation of concerns, and SOLID principles (e.g., Single Responsibility, Open/Closed) help achieve quality goals.
- Use metrics like **cyclomatic complexity** and **Halstead volume** to evaluate maintainability and complexity​.

### Scenarios and Tactics
- Quality attributes (e.g., usability, performance) are achieved through **architectural tactics**:
    - **Modifiability**: Increase cohesion, reduce coupling.
    - **Performance**: Prioritize resource allocation, use concurrency.
    - **Security**: Implement encryption, intrusion detection.
    - **Usability**: Provide user feedback, mitigate errors​.

### Architectural Views
- **Module Views**: Describe code structure and relationships like decomposition, uses, and layering.
- **C&C Views**: Focus on runtime behavior using components (services, processes) and connectors (protocols, data flows).
- **Allocation Views**: Map software elements to hardware, file systems, or organizational units​​.

### Architectural Styles
1. **Module-Centered Styles**:
    - **Layered**: Promotes modifiability and testability; used in hierarchical systems.
2. **C&C Styles**:
    - **Pipe-and-Filter**: Sequential, independent data processing.
    - **Client-Server**: Centralized servers serving distributed clients.
    - **Publish-Subscribe**: Loosely coupled components communicating via events.
    - **Repository**: Central data store accessed by clients.
3. **Distributed Styles**:
    - **Broker**: Decouples clients and servers using a mediator.
    - **Service-Oriented Architecture (SOA)**: Independent services communicate using standards like SOAP or REST.
    - **Microservices**: Independent, small-scale services focusing on modularity and scalability​​.

### Software Product Lines (SPL)

- SPL enables **systematic reuse** by creating core assets (e.g., architectures, components) for multiple products.
- Core activities:
    - **Domain Engineering**: Develop reusable artifacts.
    - **Application Engineering**: Customize assets for specific products.
    - **Variability Management**: Postpone decisions to customize systems.
- Benefits include reduced time-to-market, cost savings, and improved quality​.