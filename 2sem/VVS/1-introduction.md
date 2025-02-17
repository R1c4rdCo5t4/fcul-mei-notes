# Software Testing
### Terminology
- **Types of Bugs:**
	- **Fault:** a defect in the source code - the location of the bug
	- **Error:** erroneous program state caused by the execution of the fault
	- **Failure:** propagation of an erroneous state to the program output
- **Testing:** evaluating software by observing its execution
- **Test Failure:** a test execution that results in a failure
- **Debugging:** the process of finding a fault given a failure

### Test Failure - RIP Model
- If the following conditions are met, test failures can occur:
	- **R**eachability - the fault is reached
	- **I**nfection - execution of the fault leads to an error
	- **P**ropagation - the error is propagated to the program output (failure)

### Faults
- Some faults might be very hard to find:
	- **Fault Sensitivity:**
		- The ability of code to hide faults from a test suite
		- Executing buggy code does not always expose the bug
	- **Coincidental Correctness:**
		- Faulty code can appear to work correctly by luck

### Test Case
- A test case is composed by the test case values, expected results, prefix values and postfix values necessary for a complete execution and evaluation of the software under test (SUT)
- **Test Case Execution:**
	1. Execute prefix actions (setup)
	2. Setup values (inputs)
	3. Execute SUT
	4. Compare test outputs with expected values (assert)
	5. Execute postfix actions (cleanup)

#  Coverage

### Terminology
- **Test Set** (T): a set of test cases
- **Test Requirement** (TR): a requirement that should be satisfied by the test set
- **Coverage Criterion** (C): rule or collection of rules that define a set of test requirements TR(C)
- **Coverage Level:** the percentage of test requirements that are satisfied by a test set - we say T satisfies C if the coverage level of TR(C) by T is 100%
- **Infeasible Requirement:** requirement that cannot be satisfied by any test case - if there are infeasible test requirements the coverage level will never be 100%

### Criteria
- **Line Coverage** (LC): percentage of lines covered in the SUT
- **Instruction Coverage** (LC): percentage of instructions covered in the SUT
- **Branch Coverage** (BC): percentage of instructions covered in the SUT including all cases at choice points (ifs, switch cases, etc.)

<div align="center">
Branch Coverage (BC) ⊇ Instruction Coverage (IC) ⊇ Line Coverage (LC)
</div>

### Verification & Validation
- Verification and validation are both about assessing the quality of a system
	- **Verification:** "have we built the software **right**?” - is the SUT in accordance with the specifications?
		- Unit testing
		- Module testing
		- Integration testing
		- System testing
	- **Validation:** "have we built the **right** product" - does the SUT satisfy the client?
		- Acceptance testing

### Benefits of Testing
- **Cost:** testing any project helps salving money in the long term - if bugs are caught early, it will cost less to fix it
- **Security:** the most vulnerable and sensitive benefit of software testing - it helps removing risks and problems earlier
- **Product Quality:** an essential requirement of any software product - testing ensures the product is delivered to customers with quality
- **Customer Satisfaction:** the main aim of any product is to give satisfaction to its customers
- However, developing tests is a time consuming task subject to incompleteness and further errors - it’s not possible to perform exhaustive testing

### Unit Testing
- Used to **test a single feature or behavior of the software in isolation**, purposefully ignoring its other units
- Defining a unit is dependent on the context - a unit can be just one method or can consist of multiple classes
- **Advantages:**
	- **Execution Speed.** Fast tests that make it possible to test huge portions of the system in a small amount of time allowing constant feedback
	- **Easy to Control.** A unit test tests the software by giving certain parameters to a method and then comparing the return value to the expected result
	- **Easy to Write.** Do not require a complicated setup. A single unit is often cohesive and small, making the job of the tester easier
- **Disadvantages:**
	- **Isolation.**
		- The large number of classes in a system and their interaction cause the system to behave differently in its real application than in unit tests. Therefore, unit tests do not perfectly represent the real execution of a software system
		- Some types of bugs cannot be caught at unit test level. They only happen in the integration of the different components

### Integration Testing
- Test level used to test something more integrated (less isolated) than a unit test but without the need of exercising the entire system
- Tests multiple components of a system together, focusing on the interactions between them instead of testing the system as a whole
- **Advantages:**
	- **Easier than System Testing**. While not fully isolated, devising tests just for a specific integration is easier than devising tests for all the components together. Therefore, the effort of writing such tests is a little more than the effort required for unit tests but less than the effort for testing the entire system
- **Disadvantages:**
	- **Difficulty**. The more integrated the tests are, the harder they are to implement
	- **Complexity.** Require more complex setups and teardown stages

### System Testing
- Provides a more realistic view of the software, with all its databases, frontend apps and any other components it has
- The system is tested as a whole instead of testing small parts of the system in isolation
- **Advantages:**
	- **Realism.** Gives a much better chance that the system works when released
	- **Perspective**. Captures users' perspectives much better than other types of tests
- **Disadvantages:**
	- **Speed**. Very slow compared to other types of tests due to all the components and dependencies involved
	- **Difficulty**. Harder to write with much more complex setups and teardown stages
	- **Flakiness**. System tests tend to become flaky. A flaky test is one that presents an erratic behavior: if you run it, it might pass or it might fail for the same configuration or unexpected state.

### Static Testing
- Checks faults in a software application without running its source code
	- Early detection of faults prior to test execution
	- Early warning about suspicious aspects of the code or design
	- Improved maintability of code and design
	- Prevention of faults, if lessons are learned in development
- Two categories:
	- **Reviews:** manual examinations of source code
		- To find causes of failures - faults in the program, rather than the failures themselves
		- Easier and cheaper than later debugging
	- **Automated tools:** use of software applications that perform a static analysis of the source code (e.g., SpotBugs)
		- To find faults in software source code and software models
		- Check for violations of standards
		- Check for things which may be faulty
		- Can find unreachable code, undeclared variables, parameter type mismatches, uncalled functions, etc.
		- Types of tools:
			- **Lexical:** words, strings, regexes
			- **Syntactic:** tree of program structure
			- **Control flow graph:** checks for unreachable execution paths
			- **Data flow graph**: checks uses of program's variables