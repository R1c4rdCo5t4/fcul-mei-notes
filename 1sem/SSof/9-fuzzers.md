# Software Testing
- There is an infinite number of possible ways that an application may fail, and organizations always have limited testing time and resources
- We need to focus on security holes that are a real risk
- Tools do not make software secure, they just help scaling the process and enforcing policy
- **Testing:** evaluate the software by "observing" its execution
	- **Static Testing:** done without executing the software - **symbolic execution**, **static analysis**, **static taint analysis**
	- **Dynamic Testing:** testing while running the software - **fuzzing**, **dynamic taint analysis**
- Types of testing:
	- **Unit testing** - check if units satisfy specifications
	- **Module testing** - check if modules satisfy specifications
	- **Integration testing** - check conformance of interfaces
	- **System testing** - check if satisfies its architectural design
	- **Acceptance testing** - check if satisfies requirements
	- **Regression testing** - check if changes made did not impact correctness
- Challenges:
	- **Observability:** observing the software behavior
	- **Controllability:** providing inputs to the software
	- **Coverage:** test set to find all bugs
- **Functional testing:** check if the software does what it's supposed to
- **Security testing:** check if the software does not do what it's not supposed to

### Security Testing Phases
1. Enumerate the **attack surface**
2. Use **attack modeling** to prioritize the tests to be carried out
3. Defines **tests that will be carried out**
4. **Execute the tests**
5. Given the results, perform a **code review** to find the vulnerabilities in the program

### Tests Definition
- **Black Box Testing**
	- Tests derived from **external description** of the software
	- Simplest form of deriving the tests
	- Often used by security experts in penetration testing
- **White Box Testing**
	- Tests derived from the **source code**
	- Harder but better coverage
	- Used by companies that develop the software
- **Gray Box Testing**
	- Combines both

# Fuzzers
- **Brute force** the application interface with erroneous input to discover it it crashes
- Inputs are often **generated randomly**, but sometimes with support of other mechanisms
- Monitoring is often very simple or inexistent:
	- A test case is effective because the program **crashed** or **hanged**
	- The tester may resort to other mechanisms that detect invariant violations at runtime and force a crash - **sanitizers** 

### Fuzzer Classification
- In terms of **knowledge**
	- **Thin fuzzers** - tools with little knowledge or assumptions about the target
	- **Fat fuzzers** - can generate input that is syntactically valid
- In terms of **specialization**
	- **Specialized** - implemented for a specific type of target
	- **Generic** - can be applied to a large spectrum of targets
- In terms of **visibility**
	- **Black** - **no access**, all tests simply go through the interface
	- **Gray** - ability to compile, eventually adding **instrumentation code**
	- **White** - the execution of the application is **emulated**, looking for conditions in the input that would cause a failure
- Based on the **employed techniques**
	- **Blind fuzzers:** have limited knowledge about the source of the target
		- **Mutational fuzzers** rely on a strong set of initial inputs as a foundation, which are then altered in various ways to generate test cases for the program
		- **Generational fuzzers** receive a formal specification of the input format and then use it to produce tests to the program
	- **Coverage-guide fuzzers:** use a feedback mechanism on how the processing of an input affected the processing of the target, namely with regard to the parts of the code that were executed
		- Inputs are gradually mutated using the feedback information to determine which tests **increase code coverage**
		- Feedback can be obtained by:
			- Instrumenting the program **at compilation time** to generate coverage data at runtime
			- Dynamically instrumenting the binary **at execution time** with an emulator, when source code is not available
			- Resorting to **hardware assisted tracing collection**, exploring available CPU debugging facilities
	- **Hybrid fuzzers:** leverage from several kinds of program analysis techniques to complement the usual operation, with the aim of reaching deeper into the code
		- **Symbolic/concolic execution** to derive inputs that overcome test branches that are only triggered in rare conditions
		- **Taint tracking** to reduce the input search space to mutations that influence interesting parts of the program
		- **Machine learning models** are derived to produce relevant inputs

### Test Case Generation
- Traditional ways of generating inputs
	- **Random fuzzing:** generates random inputs (or at least parts of them)
	- **Recursive fuzzing:** iterating through all combinations of characters from an alphabet
	- **Replacing fuzzing:** substitutes part of the test case with predefined values - iterates through a set of values - **fuzz vectors**
		- Examples of fuzz vectors: `' or 1=1 --`, `or 1=1 /*`, etc.
- A mixture of the above methods is often used, using **mutations** with the fuzz vectors, adding random data, etc.

### Mutation Operators
- **Deterministic Mutation** - systematically mutate:
	- Bits, bytes, arithmetic, relevant values, user defined, auto extra
- **Random Mutation:**
	- Random bytes, delete/insert/overwrite bytes, crossover

### AFL (American Fuzzy Loop)
- Aims to fuzz diverse programs in a fast and robust way, by exploring **instrumentation** and a **genetic algorithm** to automatically discover interesting test cases (inputs):
	- Which trigger new **internal states** in the targeted program
	- Substantially improve the **coverage** of the fuzzed code
	- Eventually **cause the crash** of the program

### Vulnerability Scanners
- Classical search for vulnerabilities in computer systems
	- Experiment various tests that "exploit" certain **already known vulnerabilities** described in a **database**
	- Often provide hints on how to fix the discovered flaws
	- Periodically updated with information about new vulnerabilities
- Web vulnerability scanners
	- **NIST** specified a set of basic requirements:
		- Identify all of the types of vulnerabilities in their list
		- Report an attack that demonstrates the vulnerability
		- Have an acceptably low false positive rate
		- Create report in a format compatible with other tools - XML (optional)
		- Indicate remediation tasks (optional)
		- Use normalized names for vulnerability classes, e.g., CWE (optional)
	- Mandatory support for the detection of 14 classes of vulnerabilities, **but not all vulnerabilities** (impossible), **only all classes**

#### Vulnerability Scanners vs Fuzzers
- Separation not entirely clear
- Vulnerability scanners run database of specific attacks, while fuzzers are more random
- Vulnerability scanners are commercial tools, while fuzzers tend to be free/open

### Proxies
- Act as intermediary servers between a user and the internet, routing requests and responses to mask the user's IP address and location, enhancing privacy and anonymity
- Special proxies can be used to overcome the difficulty of discovering the application protocol
	- No need to obtain a protocol specification
	- Ability to modify the messages in the network
	- Example: **ZAP**