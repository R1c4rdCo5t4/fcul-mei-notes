# Race Conditions
- **Violation of an assumption of atomicity**
	- Can occur during a **window of vulnerability**
	- More than one entity access concurrently the same object
- This is due to a problem of concurrency and lack of proper synchronization
	- Between a target and malicious processes
	- Or between several processes/threads of the target
- To exploit this, the attacker **races to break the assumption** during this window
- **Solutions:** locks, semaphores, or other synchronization mechanisms
- Sources of races:
	- **Shared data:** files and memory
	- **Preemptive routines** (signal or exception handlers)
	- **Multi-threaded programs**

### Time of Check - Time of Use (TOCTOU)
- Also called **symbolic link attack**
- Typical case:
	- A program running **setuid root** is asked to write to a file owned by the user running the program
	- Root can write to any file, so the program must check if the actual user has the required rights to change the file
	- However, this creates a **window of vulnerability** when using `access()`:

C program:
```c
// access checks if the real uid has write access to the file
// returns 0 if the user has write privilege
if(!access(file, W_OK)) { // window
	f = fopen(file, "w+"); // of vulnerability
	write_to_file(f);
}
else {
	fprintf(stderr, "Permission denied\n");
}
```

In a shell, executed at the same time until success:
```sh
$ touch dummy
$ ln -s dummy link
$ program link &
$ rmlink; ln -s /etc/passwdlink
```

- This attack works because there is a race condition between the **time-of-check** (when `access()` verifies permissions) and the **time-of-use** (when `fopen()` opens the file), allowing an attacker to replace the file (dummy) with a symbolic link to a sensitive file (e.g., `/etc/passwd`) during this window of vulnerability

#### access()
- `int access(const char *pathname, int mode);`
	- Checks whether the calling process can access the file `pathname` according with `mode`
	- Designed for `setuid` programs, does privilege check using the process' **real UID** instead of the **effective UID**
- Usually vulnerable vulnerable to race conditions
- **Should never be used**

#### lstat()
- Also does not fix the issue, still vulnerable to TOCTOU
- Attacker creates link, then deletes it after the `open()` and before the `lstat()`

### Preventing File Race Conditions
- Avoid **sequential resolutions** and use filenames only when strictly necessary inside the program
- We should instead use **file descriptors**

```c
fd = open("/tmp/bob", O_RDWR);
fstat(fd, &sb);
```

- If someone unlinks and re-links `/tmp/bob` between the two calls, `fd` will still point to the same **inode**
- **Unsafe:** `access`, `stat`, `lstat`, `chmod`, `chown`
- **Safe:** `fstat`, `fchmod`, `fchown`

### Permission Races

```c
FILE *fp; //stream
int fd;
if (!(fp = fopen("myfile.txt", "w+"))) die("fopen");
fd = fileno(fp); // returns fd associated to the stream
if (fchmod(fd, 0600)<0) // reduce file access permissions
	die("fchmod");
```

- If the file does not exist:
	- `fopen()` creates it by calling `open()` with default permissions, e.g. 0666
	- The umask is inherited by the program
	- The program changes it to 0600 but it is too late, a race is possible
	- The attacker does not have to write in the file during the window, only open it, having access to the file until it is closed
	- **Solution:** set *umask()* before accessing files

### Memory Races
- Can occur when one or more entities use the same shared memory, leading to unexpected behavior
- Can lead to other vulnerabilities, such as buffer overflows

### Temporary Files
- Caused by the creation of files in a **shared directory**, which if not created property may **allow the attacker to control the file**
- Typical attack:
	1. Privileged program checks that there is no file `X` in `/tmp`
	2. Attacker races to create a link called `X` to some file, e.g., `etc/passwd`
	3. Privileged program attempts to create `X` but ends up opening the attacker's file, and does something undesirable that its privileges allow
- Why the attack is possible
	- The **filename can be predicted** by the attacker
	- The **race condition** between the **check** and the **file creation**
- **Non-solutions**:
	- **Random file names:** often the attacker can try the race many times, and the name generated can be potentially predicted
	- **Locks:** many implementations are enforced by convention, not mandatory
- **Acceptable solutions:**
	- Use a **long random number** (e.g., 128 bits), **set umask** (e.g., 0066) and **open the file**
	- Use the **safe calls**:
		- `int mkstemp(char *template)` - much safer than `mktemp()` since it checks for uniqueness, creates and opens with rw privileges only for the owner (0600)
		- `FILE *tmpfile(void)` - similar but not as good
		- `char *mkdtemp(char *template)` - similar but creates a directory with permissions 7000

# Concurrency and Reentrant Functions
### Concurrency
- Operations **must be executed atomically** over shared objects - without interruption
- Mutual exclusion is a solution for **some** of the problems - mutex, semaphores, etc.
- Problems with mutual exclusion:
	- **Starvation:** a thread is never scheduled for execution
	- **Deadlock:** threads inter-block themselves

### Reentrancy
- A function is **reentrant** if several instances of the function can be executed in parallel in the same address space - for example, it works correctly even if a thread is interrupted by another thread that calls the same function
- Addressing reentrancy in two main sources of problems:
	- **Thread-safety:** reentrancy in relation to several threads
	- **Async-signal-safety:** reentrancy with signals (or exceptions)
- **Thread-safety:**
	- Requirements for a function be reentrant:
		- Does not use static variables, global variables, or other shared resources like libraries
		- Only calls reentrant functions

### Async-Signal-Safety
- Signals are mechanisms to indicate asynchronous events to a process
- Can be treated by a **signal handler** (a function)
- Signal handlers must be **asynchronous-safe**
- Otherwise they may have bugs or introduce vulnerabilities