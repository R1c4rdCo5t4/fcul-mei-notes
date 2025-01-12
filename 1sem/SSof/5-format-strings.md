# Format Strings
### Trust and Trustworthiness
- A component can be trusted without being trustworthy, meaning trust is not proof of reliability or correctness.
- **Trust**: dependence on a component/system based on its properties, but it is not absolute. Trust reflects what is expected rather than guaranteed.
- **Trustworthiness**: the extent to which a component/system actually meets the expected properties.
- **Never trust input!**

### Format Strings
- Appear in C functions of the families: `printf`, `err`, `syslog`, `sprint`.
- Syntax: `printf("format string", parameters)`
- The parameters are put on the registers, and then, when there is no more space, in the stack before the return address placed by the call to `printf`.
- If the format string is controlled by an attacker:
	- Crash - denial of service
	- Print contents of arbitrary memory addresses - information leak
	- Write arbitrary values in arbitrary memory addresses - code execution or control flow hijacking
- **Solution:** always write the format string: `printf("%s", s)`

#### Printing Contents of Memory
- In the following C program:

```c
main(int argc, char **argv) {
	printf(argv[1]);
}
```

- With `argv[1] = "%016lx"`
	- `0` - 0 padding
	- `16` - 16 hexadecimal digits
	- `l` - long
	- `x` - hexadecimal
	- It prints 8 bytes (16 hex digits) from register `rsi` because `printf()` expects the long number to be printed with `%016lx` to be in the first register (after `rdi`, which is used for the format string itself).
- With `argv[1] = “%016lx%016lx%016lx %016lx%016lx_%016lx”`
	- It prints prints 5 times 8 bytes (16 hex digits) from the registers `rsi`, `rdx`, `rcx`, `r8d` and `r9d`, followed by 8 bytes (16 hex digits) from the stack because `printf()` expects the remaining arguments to be stored in the stack when there are no leftover registers.
- With `argv[1] = "%s"`
	- Takes and dereferences from register `rsi` an address of the place where the string is supposed to be
	- If the address is invalid, the program crashes with segfault
	- Otherwise, it will print that area of memory until a `'\0'` is found
- With `argv[1] = "%x%x%x%x%x%lx%lx%lx%lx%lx %lx_%s_\x84\x48\x55\x55\x55\x55\x00\x00`
	- Prints registers + bytes from stack + content of address 0x0000555555554884

--- 

- To provide an address in the command line:
	- We cannot write something like "\x84\x48\x55\x55\x55\x55\x00\x00" because each character is stored in a separate byte
	- We have to use something like `printf "\x84\x48\x55\x55\x55\x55"` where the shell executes a `printf` command and concatenates the output to the arguments of the program that we want to execute

#### Writing Contents in Memory
- **%n**: Allows writing to memory by storing the number of bytes printed so far into a specified memory location.
    - Example: `printf("AAAAA%n", &i)` writes `5` (bytes printed) into variable `i`.
    - Attackers can craft input to insert addresses and write specific values into memory.
- **Address Insertion**: Attackers can embed multiple memory addresses (e.g., `s = "AAAA\x04\xF0\xFD\x7F%08x...%08x%n"`) to write to specific memory locations.
- **%07u Specifier**: Controls the number of bytes printed (e.g., `07` sets a minimum of 7 bytes) to manipulate the value written into memory - this can be adjusted to write desired values.

### Summary
- printf(format_string, parameters…)
- the stack contains:
	- %08x → the number to print → read
	- %s → the address of the string to print → read
	- %n → the address where the value is stored → write

# Input Validation
### Different Forms of Input
- **Command Line Arguments**
	- An attacker can pass malformed program arguments to any program parameter, including the program name (large name → BO)
	- Even if the shell imposes limits, the attacker does not need to call the program from a shell
- **Passed by Parent Process**
	- Don’t trust things left by the parent process:
		- **open file descriptors** (close them)
		- **umask** (since it is used to set default permissions of created files - should be reset)
		- **signal handlers** (reset them)
- **Environment Variables**
	- May contain malicious or unexpected values
	- Should be sanitized or reset
- **Libraries**
	- Can be malicious and do operations with the privileges of the application
	- Possible solutions:
		- Directory does not give execute permission (does not let programs of DLLs there be executed)
		- Runtime validations to ensure that the DLL is the one intended
		- Provide full path for the DLL

### Attacks
- **Path Traversal Attack:** manipulate file paths and access unauthorized files or directories outside the intended directory by using sequences like `../` to traverse the file system.
- **Command Injection:** execute arbitrary system commands by injecting malicious input into applications that execute shell commands

#### Metadata and Metacharacters
- **Metadata:** information about data (meta-information)
	- **In-band:** strings in C (special characters indicates the termination)
	- **Out-of-band:** strings in Java (number of characters is stored separately from the characters)
- In-band metadata for textual data is called **metacharacters**
	- Source of many vulnerabilities
	- Ex: `\0`, `\`, `/`, `.`, `@`, `:`, `\n`, `\t`, ...
- Vulnerabilities arise because:
	1. The program trusts input to contain **only** normal characters
	2. But the attack introduces input **with** metacharacters
- **Solution:**
	- Sanitize input from metacharacters
	- Using **whitelisting** and if not possible, **blacklisting**
- Typical attacks:
	- Embedded delimiters
	- NULL character injection
	- Separator injection

