# Compilers
- A **compiler** is a software program that translates high-level source code from one language to another, composed by multiple stages to ensure correctness and optimization

### Compilation Process
1. **Lexical Analysis (Lexer):** the lexer, also called scanner, reads the source code and converts it into a stream of tokens
2. **Syntactic Analysis (Parser):** the parser takes the token stream and builds an Abstract Syntax Tree (AST) based on the grammatical structure of the language
3. **Semantic Analysis & Validation:** the validator checks for semantic correctness (type checking, scope resolution, etc.) and ensures the program follows the language rules
4. **Optimization:** the optimizer improves the code automatically by reducing computations, eliminating dead code and improving efficiency when possible
5. **Code Generation:** the optimized code is finally transformed into the target language for execution

### Concepts
- **Compilers vs. Interpreters:** while compilers translate source code before execution, interpreters translate and run the code line by line during the program execution
- **Transpilers:** special compilers that convert code form one high-level language to another (e.g., TypeScript to JavaScript)
- **Just-In-Time (JIT) Compilation:** compiles code at runtime for better performance (used in Python, Java, etc.)