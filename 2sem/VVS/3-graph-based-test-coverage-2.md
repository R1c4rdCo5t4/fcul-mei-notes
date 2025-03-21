# Graph-Based Test Coverage (Part 2)
### Data Flow Coverage Criteria for Graphs
- **Assumption:** to test a program adequately we must focus on the flows of data values to ensure that created values are used correctly
- Given a program and a variable *v* of that program:
	- A **definition** of *v* is a program location that assigns (writes to) *v*
	- A **use** of *v* is a program location that accesses (reads from) *v*
- Given a graph `G = (N, N0, Nf, E)` and `n`∈`N`, `e`∈`E`
	- `def(n)` and `def(e)`: set of variables defined by `n` or `e`
	- `use(n)` and `use(e)`: set of variables used by `n` or `e`
- **Data flow coverage criteria:** based on definitions and uses of data

### Def-clear Paths
- For simplicity we only consider graphs where edges have no definitions (all definitions occur in nodes) - this is the case with CFGs but not with FSMs
- A def of a variable may or may not reach a particular use:
	- There is no path from the def to the use
	- The value of the variable is changed by another def before it reaches the use
- A path from location (node or edge) *l* to location *l'* is **def-clear** with respect to variable *v* if *v* is not in **def(n)** or **def(e)**, for all nodes *n* or edges *e* in the path (except in *l* and *l'*)

### du-path and def-path set
- A **du-path** with respect to a variable *v* is a simple (no inner loops), def-clear path, from a node *n* to a node *n'* such that **v ∈ def(n)** and **v ∈ use(n’)**
- Note:
	- du-path are always associated with a variable
	- there may be intervening uses on the path
- Test criteria for data flow are defined as sets of du-paths
- We first categorize du-paths in different groups
- The first grouping is according to definitions
- A **def-path set du(n, v)** is the set of du-paths with respect to variable *v* that originate in node *n*

### def-pair set
- The second grouping is according to pairs of **def** and **uses**
- Consider all du-paths with respect to a given variable that are defined in one node and used in another (possibly identical) node
- A **def-pair set du(n, n', v)** is the set of du-paths with respect to variable *v* that originate in node *n* and end in node *n'*
- Collects all simple ways to get from a given definition to a given use - **du(n, v) = ∪n’ du(n, n’v)**

### Data Flow Coverage Criteria
- **All-Defs Coverage (ADC)**
	- Each def reaches **at least one node**
	- For each def-path set `S = du(n, v)`, TR contains *at least one* path in **S**
- **All-Uses Coverage (AUC)**
	- Each def reaches **all possible use**
	- For each def-pair set `S = du(n, n’, v)`, TR contains *at least one* path in **S**
	- AUC subsumes ADC
- **All-Du-Paths Coverage (ADUPC)**
	- Each def reaches **all possible du-paths**
	- For each def-pair set **S**, TR contains *every* path in **S**
	- ADUPC subsumes AUC

### Data Flow Coverage for Call Sites
- Control connections between method calls are simple and straightforward - not very effective at finding faults
- Data flow connections are usually complex and difficult to analyze - rich source for finding software faults
- A **caller** is a unit that invokes another unit, the **callee**
- **The instruction that makes the call is the *call site***
- We need to ensure that variables defined in the caller are appropriately used in the callee
- We need to focus on:
	- **last def** of variables just before calls to (and returns from) the callee
	- **first use** of variables just after calls to (and returns from) the callee

### Data Flow Couplings
- Consider couplings between caller and callee units:
	- **Parameter coupling:** when parameters are passed in caller → callee
	- **Return value coupling:** when a return value is passed in callee → caller
	- **Shared data coupling:** when there are shared variables by the caller and callee
	- **External device coupling:** when two units access the same external media (e.g., a file or a socket)
- For variable *x* expressing a coupling between caller and callee:
	- **last-def:** the set of nodes that define *x* from which there is a def-clear path to the call (callee) or the return site (caller)
	- **first-use:** the set of nodes that use *x* for which there is a def-clear and use-clear path from the entry point (callee) or call site (caller) to the nodes
- Parameter & return value coupling: **last-defs** and **first-uses** define coupling du-pairs

### Coupling du-paths and Coverage Criteria
- A **coupling du-path** *x* is a path from last-def of *x* to a first-use of *x*
- Data flow coverage criteria can be applied to coupling du-paths:
	- **All-Coupling-Def Coverage:** cover at least one coupling du-path for every last-def of *x*
	- **All-Coupling-Use Coverage:** cover at least one coupling du-path from every last-def to first-use of *x*
	- **All-Coupling-Du-Paths:** cover every coupling du-path from every last-def to first-use of *x*