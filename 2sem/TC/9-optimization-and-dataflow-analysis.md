# Optimization & Dataflow Analysis
### Optimization
- Phase in the compiler aimed at enhancing the performance and efficiency of the executable code

#### Types of Optimizations
- **Compile Time Evaluation:** evaluates expressions at compile time instead of at runtime
- **Variable Propagation:** replaces variables with their known values
- **Constant Propagation:** replaces variables with constant values with those constants directly
- **Constant Folding:** calculates constant expressions at compile time to instead of at runtime
- **Dead Code Elimination:** removes code that doesn't affect the program (e.g. unused variables)
- **Unreachable Code:** removes parts of the code that can never be executed (e.g. code after a return statement)

### Dataflow Analysis
- Technique in compiler design to analyze how data flows through a program, involving tracking the values of variables and expressions as they are computed and used throughout the program with the goal of identifying opportunities for optimization and identifying potential errors
- The basic idea behind it is to model the program as a graph, where the nodes represent program statements and the edges represent dataflow dependencies between the statements - the dataflow information is then propagated through the graph using a set of rules and equations to compute the values of variables and expressions at each point in the program

### Types of Dataflow Analysis
- **Reaching Definition Analysis:** tracks the definition of a variable and determines the points in the program where the definition "reaches" a particular use of the variable
	- Used to identify variables that can be safely removed or optimized
- **Liveness Analysis:** determines the points in the program where a variable is "live", meaning that its value is still needed for some future computation
	- Used to identify variables that can be safely removed or optimized
- **Available Expressions Analysis:** determines the points in the program where a particular expression is "available", meaning that its value has already been computed and can be reused
	- Used to identify opportunities for common subexpression elimination
- **Constant Propagation Analysis:** tracks the values of constants and determines the points in the program where a particular constant value is used
	- Used to identify opportunities for constant folding