# Operating Systems Protection Mechanisms
- Since modern OS's support multiprogramming, they must provide protection:
	- **among the users**, namely between a legitimate user and an intruder/malware
	- **of the OS itself** from users, intruders, and malware
- Often, the OS's need to **cooperate with the hardware** to implement the protection mechanisms.

## Protection of Mechanisms
- **Role of the OS:** ensure that objects are only accessed by authorized subjects, for example:
	- Processes only have **direct access** to their own memory segments
	- Each file can be accessed only by a **set of users**
- Two main mechanisms to ensure object authorization:
	- **Separation:** prevent arbitrary access to objects by separating objects from subjects
	- **Mediation:** control the access to an object, deciding what kind of access a subject has to the object

### Separation
- Two modes/levels/rings:
	- **Kernel mode:** software can use any system resource (memory, I/O devices, etc...)
	- **User mode:** access to resources is **controlled** by the OS
- These are **enforced by the CPU**
	- Disables set of instructions in user mode that is necessary to access resources - either raises an exception or does not do anything
- Executing operations outside their control is done via
	- **System calls:** OS "function" that allows the OS to execute privileged operations on behalf of a program. These calls ensure that only safe operations are executed.

### Memory Protection
- A process cannot modify another process's memory or the kernel’s memory, preventing security risks like altering loaded code.
- This type of protection is essential to maintain system integrity.

#### Memory Separation Strategies
- Various strategies ensure processes and the kernel remain isolated:
	- **Physical Separation**: uses different devices for processes with distinct security requirements.
	- **Temporal Separation**: processes with varying security requirements are executed at different times.
	- **Logical Separation**: processes operate as if they are the sole users of the system.
	- **Cryptographic Separation**: processes use encryption to make data and computations inaccessible to others.

### Memory Protection Techniques
- **Segmentation:**
	- Divides memory into logical segments (code, data, stack, etc.), where each segment has specific permissions (read/write/execute).
	- Memory is logically addressed by (name, offset).
	- These segments can be mapped to physical addresses as needed, enabling flexibility and access control.
	- **Translation Table**: controls which segments are accessible to each process and defines permissions for reading, writing and execution.
- **Paging:**
	- Memory is divided into fixed-size **pages** (typically 4KB), simplifying memory management and eliminating internal fragmentation.
	- Each process has a **page table** that defines access rights.
	- Physical memory is divided into **page frames** of the same size as a page.
	- Memory is addressed by (page, offset)
	- **Translation Look-aside Buffer (TLB)**: a cache that accelerates the translation of page addresses to physical addresses.
- Systems like Unix combine both segmentation and paging for robust protection and efficient memory management.

### Access Control Models
- To ensure secure access to objects, different access control models are used:
	- **Access Control Lists (ACLs)**: each object has a list defining authorized subjects and their permissions.
	- **Capabilities**: each subject has a list of objects it can access, protected against modifications.
	- **Access Control Matrix**: a matrix where rows represent subjects, columns represent objects, and cells contain permissions.

#### Principle of Least Privilege
- Systems should operate under the **principle of least privilege**, where processes have only the minimum rights necessary for their operation.
- This reduces the attack surface and limits damage in case of compromise.

### Advanced Protection Techniques
- **Data Execution Prevention (DEP):**
	- Marks memory regions as non-executable using the NX (no-execute) bit.
	- This prevents arbitrary code execution from unauthorized regions.
- **Address Space Layout Randomization (ASLR):**
	- Randomizes the addresses of critical memory areas, preventing attackers from predicting and exploiting specific memory addresses.

#### Privilege Escalation
- Some processes can perform privileged operations, such as modifying critical files (`/etc/passwd`).
- This privilege escalation is often a target for attacks.