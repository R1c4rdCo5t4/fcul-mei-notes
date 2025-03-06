# Microservices
### Team and Project Goals
- There is a **team of developers** working on the application
- New team members must **quickly become productive**
- The application must be **easy to understand and modify**
- You want to practice **continuous deployment** of the application
- You must run **multiple instances of the application on multiple machines** in order to satisfy scalability and availability requirements
- You want to take advantage of **emerging technologies** (frameworks, programming languages, etc.)

### Project Requirements
- Develop a **server-side enterprise application**, supporting a variety of different clients
- **Expose an API** for third parties to consume
- Integrate with other applications via either **web services** or a **message broker**
- Handle requests by executing business logic, accessing a database, exchanging messages with other systems and returning an HTML/JSON/XML response
- Logical components correspond to different functional areas of the application

## Architecture
### Monolithic
- Unified model for the design of the system, composed all in one piece
- **Advantages:**
	- Simple to develop
	- Simple to deploy
	- Simple to scale
- **Disadvantages:**
	- More difficult to understand, modify and scale
	- Continuous development is also difficult
	- Requires a long-term commitment to a technology stack

#### Scale Cube
- In this model, an application can be scaled in three different axis:
	- **X-axis:** running multiple instances of an app behind a load balancer
	- **Y-axis:** splitting the application into multiple, different services
	- **Z-axis:** each server running an identical copy of the code but each one responsible for only a subset of the data

### Microservices
- A **service** is an independent deployable component
- The **software architecture** of a computing system is the set of structures needed to reason about the system, which comprise software elements, relations among them and properties of both
- In this architectural style, the application is structured as a set of loosely coupled services organized around business capabilities

#### Decomposing the Application into Services
- Decompose by **business capability**
- Decompose by **domain-driven design subdomain**
- Decompose by **verb or use case**
- Decompose by **nouns or resources**

### 12-Factor App Methodology
- Standardized set of guidelines that allow an application to be more mature which can be applied to apps written in any programming language, and which use any combination of backing services (database, queue, memory cache, etc.)
- The twelve factors:
	1. **Codebase:** one codebase tracked in revision control, many develop
	2. **Dependencies:** explicitly declare and isolate dependencies
	3. **Config:** store config in the environment
	4. **Backing services:** treat backing services as attached resources
	5. **Build, release, run:** strictly separate build and run stages
	6. **Processes:** execute the app as one or more stateless processes
	7. **Port binding:** export services via port binding
	8. **Concurrency:** scale out via the process model
	9. **Disposability:** maximize robustness with fast startup and graceful shutdown
	10. **Dev/prod parity:** keep development, staging and production as similar as possible
	11. **Logs:** treat logs as event streams
	12. **Admin processes:** run admin/management tasks as one-off processes