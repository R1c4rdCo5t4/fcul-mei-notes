# Web Application Vulnerabilities
- Web suffers heavily from all the 3 causes of trouble: **complexity, extensibility, connectivity**
- Various technologies and frameworks
- Many vulnerabilities reported and exploited: OWASP Top Vulnerabilities

### Broken Access Control
- Due to bugs on **authorization** enforcement, users can access functionality/data they were not supposed to.
- Most common issues:
	- Violation of the **principle of least privilege**
	- **Direct object reference** by replaying or tampering with unique identifiers** to access other accounts or elevate privileges - often as cookie, hidden field or JWT
	- **Forced browsing** when bypassing access control checks by modifying the URL or the HTML page
	- **Missing access controls** for calls with POST, PUT, DELETE
	- **CORS misconfiguration** allows unauthorized access to content in domains different from the one where the page was loaded

#### Direct Object Reference
- The site exposes a reference to an internal object and there is **no proper access control**
- The attacker can manipulate these references to access other objects without authorization
- Direct reference to key in database
- **Solution:** never expose references (use session info) and do proper access control

#### Forced Browsing
- Guessing links and brute force to find unprotected pages
- Assuming that pages/functions are protected simply by being inaccessible from the "normal" web tree - **security by obscurity** (not good)
- **Solution:** no hidden pages as a form of protection, employ proper access control

#### CORS Misconfiguration
- CORS (Cross-Origin Resource Sharing) is a browser mechanism that enables controlled access to resources located outside of a given domain
- It extends and adds flexibility to the same-origin policy (SOP)
- Uses a suite of HTTP headers that define trusted web origins and associated properties
- Some applications need to provide access to other domains and the bugs appear in various forms of misconfigurations
- Due to the misconfiguration of the application, the malicious website can contact the vulnerable website and request sensitive victim data using its credentials
- **Solution:** proper configuration of cross-origin requests; only allow access to public APIs

#### Protection
- Except for public resources, **deny by default**
- Implement access control mechanisms **once** and **reuse them** throughout the application
- Access controls should **enforce record ownership** rather than accept that any user can access or modify any record
- **Disable web server directory listing** and ensure file metadata and backup files are not present within web roots
- **Log access control failures**, alert admins when appropriate
- Stateful session identifiers should be **invalidated** on the server after logout
- **Rate limit** API and controller access to minimize the harm from automated attacks

### Cryptographic Failures
- Failures related to cryptography (or lack thereof), which often leads to sensitive data exposure.
- Most common problems:
	- Sensitive traffic **not encrypted**, either on the internet with TLS/HTTPS or when transmitted internally in the organization
	- Sensitive data **stored in the clear**, either in databases or backups
	- **Hardcoding keys** and storing them in unprotected stores
	- **Weak key generation** or **no key rotation**
	- **Weak** algorithms (MD5, RC3, ...)
	- Initialization vectors ignored, reused or **not sufficiently random**

#### Protection
- **Discard unnecessary sensitive data** as soon as possible
- **Encrypt all sensitive data** while stored or in transit
- Use **strong cryptographic algorithms**
- Ensure passwords are stored with a strong adaptative algorithm appropriate for **password protection**
- Hash passwords with salt
- **Disable caching** for responses that contain sensitive data
- Verify independently the effectiveness of settings

### Injection
- The web server accepts input that is poorly understood by an interpreter, allowing:
	- Unintended **command to be executed**
	- The **access to sensitive data** for which there was no authorization
- Examples of interpreters: SQL, XML, OS, ...
- It is often possible to find these vulnerabilities with automated tools, such as **static analysis** and **fuzzers**

#### SQL/XML Injection
- Explores a problem with a validation of the delimiters of the input, allowing attackers to inject malicious code
- **SQL Injection**: can manipulate SQL queries to extract, modify or delete data (e.g., `' OR '1'='1' --` bypasses authentication)
- **XML Injection**: can manipulate XML documents or queries, potentially altering data, injecting malicious nodes or triggering denial of service

#### OS Command Injection
- Exploits improper validation or sanitization of input that is incorporated into system-level commands, allowing attackers to inject and execute arbitrary commands on the operating system
- **Example**: an input like `; rm -rf /` added to a vulnerable shell command (`system("ls " + userInput)`) would delete the entire filesystem of the server

#### Cross Site Scripting (XSS)
- The attacker is able to inject a **script** in the victim's browser
- **Example:** `https://website.com?query=<script>alert('hello')</script>`
- Types of XSS:
	- **Reflected XSS** (or non-persistent)
		- A page reflects user-supplied data directed to a user's browser
		- The server is directly involved in reflecting the payload back to the user
	- **Stored XSS** (or persistent)
		- Hostile data (scripts) is stored in a file, database or something else that is later sent to a user's browser
		- Dangerous in systems like blogs, forums and social networks
	- **DOM-based XSS**
		- Manipulates DOM attributes instead of HTML, adding or changing JavaScript code processed by the browser
		- The injection and execution happens entirely on the client side
		- The problem is that the site with HTML page with JavaScript script does client-side logic with an attribute (e.g., `document.URL`)

#### CRLF Injection
- CRLF (Carriage Return and Line Feed) injection or HTTP response splitting
- Shares a few similarities with reflected XSS but with injection in the **header of the HTTP response**
- **Procedure:**
	1. Performed like a reflected XSS - attacker sends the victim a URL of a vulnerable website
	2. The typical victim is a page that does a redirection - 301, 302, 303, 307 status codes
	3. The attacker **inserts a carriage return and a line feed** - **creating a new field in the header**, or worse, **another response(s)**
	4. Browser **thinks the second response comes from the redirection**

#### Protection
- **Prevention:**
	- Ensure that user supplied data cannot be incorrectly used in commands or queries
	- Avoid the interpreter or employ secure APIs that parameterize user data added to commands
	- Whitelist the acceptable inputs that can be used
	- Metacharacters should be escaped using the specific language of the interpreter
- **Detection:**
	- Look for places in the code where the interpreters use the potentially malicious data supplied from the user
	- **Validate**, **filter** or **sanitize** the user-controlled data to be used in a command or query

### Insecure Design
- Broad category related to **flaws in the design and architecture** of the application, which could be addressed with **secure by design** principles
- Insecure Design ≠ Insecure Implementation
- Employ some for of **Secure Development Lifecycle**
- **Examples:**
	- Credential recovery using "questions & answers"
	- Group booking without payment - attackers could book many hundred seats and all cinemas at once in a few requests, causing a massive loss of income

#### Protection
- Use a **secure development lifecycle** with **security experts** to help evaluate and design security and privacy-related controls
- Use a library of **secure design patterns** or well tested components
- **Threat modeling** for critical authentication, access control, business logic and key flows
- Unit and integration testing to **validate** all critical flows
- **Limit** resource consumption by user or service

### Security Misconfiguration
- A **configuration flaw** allows an attacker to access several things to gain **unauthorized access** or **knowledge** of the system.
	- Default accounts, unused pages, unpatched vulnerabilities, unprotected files and directories, ....
- Can appear in any component: OS, web server, client application, framework, ...

#### XML External Entity (XEE)
- XML processors may incorrectly evaluate entity references within XML documents, **allowing the disclosure of data or execute remote request**
- Occurs when XML input contains a **reference to an external entity** that isi processed by a badly configured XML parser
- The XML processor then **replaces** occurrences of the named external entity **with the contents dereferenced** by the SYSTEM identifier
- **Example XXE attack:**
	- The attacker provides malicious XML file to site, which attempts to extract data from the server
	
```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE foo [
<!ELEMENT foo ANY >
<!ENTITY xxe SYSTEM "file:///etc/passwd" >]> <!-- malicious URI -->
<foo>&xxe;</foo> <!-- file content placed here -->
```

#### Protection
- Applying **hardening guidelines** to the system
- **Scanners** to automate the process of detecting missing patches, misconfigurations, use of default accounts, unnecessary services
- Deploy minimal platform without any unnecessary features, components, documents and samples
- Employ a segmented architecture, which provides effective and secure separation between components or tenants

### Vulnerable and Outdated Components
- Developers or system administrators do not use the latest version of a component or patch the vulnerabilities
- **Protection:**
	- Remove unnecessary features and components
	- Monitor the security of all components and keep them up to date
	- Add security wrappers to the components to prevent use of insecure functionality

### Identification and Authentication Failures
- Weaknesses in the implementation of authentication and session management allow the **compromise of passwords, keys or session tokens**, or to exploit other implementation flaws to **assume the identities of other users**
- Attackers have access to hundreds of millions of valid username and password combinations, default administrative accounts, which can be leveraged to automate attacks
- Examples:
	- Allow brute force or other automated attacks
	- Allow to have weak or well known passwords
	- Uses insecure credential recovery
	- Saves passwords in a format that enables rapid recovery with brute force attack tools
	- Missing or ineffective multi-factor authentication
	- Manages insecurely session ids

#### Credential Stuffing
- Breached username/password pairs are automatically injected to get access to user accounts
- Special case of brute force attacks
- Once user credentials become public, they are automatically entered in websites to determine if they match one of the existing accounts, which is then hijacked by the attacker
- **Credential Spraying:** variant where a single weak password is automatically tested against a large number of different accounts

#### State Tracking Mechanisms - ID
- Server sends to the browser an ID to be included in every request after the user logs in and keeps info associated with that ID
- IDs must be:
	- **Univocal:** unambiguous, designating a single user, to avoid mixing sessions
	- **Unpredictable:** to avoid attackers from guessing it
	- **With a short expiration time:** to limit the damage if it is guessed
- **Session Hijacking Attack:** attacker discovers an open session ID and sends commands to that session
- Example ways to include ID in the request:
	- **Hidden field in a form**
	- **Cookies:** in the HTTP header
		- Expiration
		- Path and domain
		- Secure attribute - only sent through HTTPS
		- HttpOnly - cannot be accessed through a client-side script
- **Session Fixation Attack:** attacker is able to hijack a valid user session
	- Special case of a session hijacking attack
	- When authenticating a user keeps an existing session ID, instead of creating its own new ID

#### Protection
- **Multi-factor authentication** to prevent automated guessing attacks
- **Do not set up default credentials**, especially for admin accounts
- Follow **best practices for managing passwords**
- Use **HTTPS (or TLS)** to protect interaction with the server and prevent sniffing of credentials
- If you **need to develop an authentication and session management library**:
	- Check user-selected passwords for minimum security levels
	- Increase the delay for failed authentication attempts and alert admins of attacks
	- Ensure password change mechanisms are robust
	- Session IDs:
		- Should be **unique**, **long**, **random** and have **short expiration**
		- Should be invalidated after **logout**
		- Should change every time there is **re-authentication**
		- Should **not be placed in the URL**

### Software and Data Integrity Failures
- Code and infrastructure that does not protect against integrity violations, such as when:
	- An application relies upon plugins, libraries or modules from **untrusted sources**, repositories and content delivery networks (CDNs)
	- Updates are downloaded **without** sufficient integrity verification and applied to the previously trusted application
	- Objects or data are encoded or serialized into a structure that an attacker can see and modify to cause **malicious deserialization**

#### Protection
- Use **digital signatures** or similar mechanisms to verify the software or data
- Ensure updates are coming from **trusted repositories**
- Verify and **test arriving components** for security, namely using different tools
- Ensure that there is a **review process** for code and configuration changes in the applications being developed
- Implement **integrity checks or encryption of the serialized objects** to prevent hostile object creation or data tampering

### Security Logging and Monitoring
- There is **insufficient capability** in the system monitor activities and deficient integration with incident response, allowing **attacks to remain undiscovered** and extended to other parts of the system
- Fundamental for accountability, visibility, incident alerting and forensics
- **Protection:**
	- Log all relevant **error conditions**
	- High value operations need to have an audit trail that **cannot be erased** and with **integrity controls**
	- Adopt an **incident response and recovery plan**

### Server-Side Request Forgery (SSRF)
- Can happen when a web application fetches a remote resource **without validating the user supplied URL**
- Allows an attacker to coerce the application to send a crafted request to an unexpected destination
- **Protection:**
	- Segment remote resource access functionality in **separate networks**
	- Enforce **deny by default** firewall policies or network access control rules
	- **Sanitize and validate** all client supplied data
	- **Disable** HTTP redirections