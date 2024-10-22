# Types and Programming Languages

> *"A type system is a **syntactic method** for enforcing **levels of abstraction** in programs. The study of type systems - and of programming languages from a type-theoretic perspective - has important applications in software engineering, language design, high-performance compilers, and security."* - Benjamin C. Pierce

### Types in Computer Science
- Types are used to classify program phrases based on the values they compute
- Type systems are methods for proving the absence of certain program behaviors, by classifying phrases according to their types

##### Benefits of type systems:
- Early detection of errors
- Enforcing disciplined programming
- Improving code readability
- Enhancing language safety
- Improving efficiency
##### Challenges of type systems:
- Tradeoff between conservativeness and expressiveness
- Complexity of type annotations
- Difficulty of retrofitting type systems onto existing languages

##### Typical Verifications 
- Arguments, arithmetic expressions
- Target object has the method to call
- Modularity (visibility of parts - public, private, ...)
- Division by zero - *not decidable*
- Array accesses - *not decidable*

### Historical Overview
- Early type systems focused on distinguishing between integer and floating-point numbers
- Later developments introduced structured data, higher-order functions, polymorphism, abstract data types, module systems and subtyping
- The connection between programming language type systems and mathematical logic has been influential

> Based on Chapter 1 of Types and Programming Languages, Benjamin C. Pierce, The MIT Press