# Scenarios and Tactics
### Architecture vs Functionality and Quality
Besides the functionality of a system, it's also important to:
- Identify the **desired qualities**;
- Ensure that the **system is built to have those qualities**.

> While the functionality of a software system is **largely independent** of how the system is **structured**, the architectural design plays a key role in achieving many of the quality attributes of the system, and functional and quality requirements must be considered in all of the design process.
### Key Concepts
##### Quality Attributes
- Measurable or testable properties that **indicate how well a system satisfies the stakeholder needs**.
- Examples: usability, performance, availability, security, modifiability, testability, reliability, etc.

##### Quality Attribute Scenarios
- Scenarios describe specific requirements for quality attributes.
- Help in verification, testing and aligning architecture to requirements.
- If the architecture is not designed to achieve specific quality requirements, it is difficult to accomplish this simply through decisions made at the detailed design level - **architecturally sensitive quality attributes**.
- **The architecture design alone does not guarantee any quality**. During detailed design, implementation, and system installation, quality requirements must continue to be considered.

##### Architectural Drivers
- Critical requirements and constraints that shape the system's architecture.

##### Functional vs. Quality Requirements
- Functional requirements describe what the system does.
- Quality requirements define how well the system performs under specific conditions.

### Tactics for Achieving Quality
- **Modifiability** 
	- Reduce module size and coupling; increase cohesion. 
	- Defer binding decisions to increase flexibility.
- **Performance**
	- Manage resource demands by prioritizing events and improving algorithm efficiency. 
	- Control resource usage through concurrency, caching and load balancing.
- **Availability** 
	- Prevent faults from becoming failures using techniques like redundancy, fault detection and crash recovery.
	- Fault recovery tactics include checkpoint/rollback and active redundancy/replication.
- **Security** 
	- Ensure nonrepudiation, confidentiality, integrity and availability.
	- Tactics include limiting access, encrypting data and intrusion detection. 
- **Testability** 
	- Enable observation and control of system state for effective testing. 
	- Use techniques like record/playback and sandboxing.
- **Usability**
	- Ensure ease of learning, operation and adaptability for users. 
	- Support user tasks with feedback mechanisms and error mitigation tactics.

### Analysis Techniques
- Evaluate architecture alignment with quality attributes using:
  - **Queuing Network Theory**: for throughput and latency analysis.
  - **Reliability Block Diagrams**: for reliability estimation.
  - **Fault Trees**: for failure analysis.

### Examples of Scenarios
- **Performance**: 1,000 transactions per minute processed with an average latency of 2 seconds.
- **Availability**: system recovers within a specified time after detecting a fault.
- **Usability**: cancelling an operation takes less than one second.

### Summary
- Scenarios and tactics provide a **structured approach to achieving quality in software systems**.
- Analyzing architecture with scenarios **ensures the system meets functional and quality goals**.