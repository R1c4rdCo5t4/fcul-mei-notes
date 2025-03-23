# Data
### Storage
- **Materialization:** single source of truth
- **Dematerialization**: no single source of truth

### Structure
- **Embedded data:**
	- Structured relationships
	- One right way to organize data
- **Replicated data:**
	- Unstructured relationships
	- No right way to organize data

### Scope
- **Bundled systems:**
	- Shared needs
	- Global context
- **Unbundled systems:**
	- Different needs and uses
	- Local contexts

### Architecture
- Frontend and backend
- Business layer
- Infrastructure

### Management
- **Analytics:**
	- Real-time analytics, business intelligence
	- Discovery, prediction, auditing
- **Content management:**
	- Business transactions
	- Efficiency, interoperability, integration
- **Master data management:**
	- Control, SLAs
	- Reuse
- **Metadata management:**
	- Information governance
	- Business and technology contexts

### Metadata
- Most flexible way to move data around
- It is:
	- Descriptive
	- Structural
	- Text-based
	- No indication about how data should be processed

### Markup
#### SGML
- Introduced the concept of markup
- Data elements delimited by tags
- Tags characterize elements
- A SGML document needs a DTD (Document Type Definition), which describes what tags are allowed and what attributes they may have, explaining the data

```
<title>data element</title>
<section>data element</section>
```

- SGML provides:
	- Interoperability
	- Common understanding
	- Data independence and adaptability
- However, DTD makes SGML overly complicated:
	- Markup declarations that define the basic building blocks of data declarations
	- A language for specifying another language
	- Requires a schema for each data field
	- Any type of DTD can be created
	- Difficult to write proper DTDs
	- Heavy processing required
	- Difficult to develop parsers

#### HTML
- Barebones approach
- Predefined DTD, markup, rules and structure

#### XML
- Compromise between SGML and HTML
- Allows creating new markup but does not require new DTD
- Tags can be freely specified
- Structural properties can be extracted from XML (closer to semantic meaning)
- Easier to develop enterprise apps
- Self-describing data

#### JSON
- JavaScript Object Notation
- To replace XML
- Objects as a collection of key-value pairs
- Simple and human readable
- Tags explain the data
- Handle storage, memory and data exchange the same way
- **Use cases:**
	- Data exchange between front-end and back-end
	- Microservices

### SQL vs. NoSQL
- **SQL:**
	- Structured, relational (schema), normalization
	- Forced consistency (transaction oriented)
	- Big-data problems (does not scale, difficult to query, high-traffic problems)
	- Big queries as batch jobs
- **JSON:**
	- Schema-less, semi-structured
	- Object-oriented
	- Distributed
	- Data intensive
	- Immediate responses
	- Frequent changes (no normalization)
	- Eventual consistency

### Eventual Consistency
- **Traditional consistency**
	- Transactions
	- Two-phase commit protocol
- **Eventual consistency**
	- Convergence, conflict resolution (read repair, write repair)
	- Logs, versions, timestamps