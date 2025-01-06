### Synchronous Consensus
- **Unfair Consensus**
	- First process always decides if it doesn't fail
	- Has t + 1 lower bound
- **Fair Consensus**
	- Uses deterministic rule (min)
- **Interactive Consistency (Vector Consensus)**
	- Processes agree on **input vector** rather than a single proposed value
	- **Stronger than consensus:** IC can implement consensus but not the contrary
- **Early Deciding IC**
	- Has min(f+2, t+1) lower bound
	- Predicate Ri^r-1 = UP^r = Ri^r, meaning **no process crashed, so decision can be made**
- NBAC (Non-Blocking Atomic Commitment)
	- Transaction/job split into multiple processes
	- All of them must agree on the same decision **(all or nothing)**: "commit" (yes) or "abort" (no)
	- Can be implemented with:
		- **Trusted coordinator** that orchestrates multiple processes
		- In case coordinator fails, with a **two-phase commit**, which ensures atomicity with a prepare phase and a decision phase

### Sub-Consensus Problems
- **Consensus:** the canonical form of agreement - cannot be solved in the system model *CAMP(n,t)\[t < n/2]*.
- However, many weaker agreement problems can:
	- **Renaming:** allows processes to decide different values using shared memory with registers.
	- **Approximate agreement:** allows processes to decide numeric values within a bounded difference ε also using shared memory with registers.
	- **Safe agreement:** allows processes processes to decide only when there are no crashes during certain critical steps of the protocol (failure-dependent termination condition in the decide phase) using message passing primitives.
