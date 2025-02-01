### Questions
1. What is the difference between a crash failure and a Byzantine failure?
2. What is the key idea behind the algorithm for Uniform Reliable Broadcast (URB) in CAMP?
3. Explain the concept of a fair channel in a distributed system. How does it differ from a reliable channel?
4. Discuss the role of failure detectors in circumventing the impossibility of building atomic read/write registers in asynchronous systems.
5. Compare and contrast the properties of regular, sequentially consistent, and atomic registers.
6. Describe the main differences between synchronous and asynchronous distributed systems. Explain how these differences impact the design of distributed algorithms.
7. What is the purpose of the "Causal Order" (CO) property in reliable broadcasts? How do vector clocks help to achieve this property?
8. What is the significance of the "no-duplicity" property in the context of Byzantine Reliable Broadcast (BRB)? How does the algorithm for ND broadcast ensure this property?
9. What are the advantages and disadvantages of using a failure detector of class P compared to a failure detector of class Diamond P in the context of quiescent URB?
10. Explain why sequentially consistent registers are not composable.

### Solutions
**Solution 1:** A crash failure occurs when a process stops executing permanently. A Byzantine failure is a more general type of failure where a process may exhibit arbitrary behavior, including sending incorrect or malicious messages.

**Solution 2:** The key idea behind the algorithm for URB in CAMP is to use a two-phase approach where the sender first broadcasts the message to all processes and then waits for acknowledgments from a majority of them. Once a majority of processes have acknowledged the message, the sender can be sure that all correct processes will eventually deliver it.

**Solution 3:** A fair channel can lose messages, but it guarantees that if a sender repeatedly sends a message, at least one copy will eventually be delivered to the receiver. A reliable channel guarantees that all messages sent will be delivered.

**Solution 4:** Failure detectors provide information about process failures and can be used to overcome the limitations of asynchronous systems. By providing information about suspected failures, failure detectors enable the construction of algorithms that would otherwise be impossible in purely asynchronous environments.

**Solution 5:**
- Regular registers offer the weakest consistency guarantee. A read operation on a regular register may return any value that was previously written to the register.
- Sequentially consistent registers provide a stronger guarantee, ensuring that all operations on the register appear to occur in a single total order that is consistent with the order in which they were invoked.
- Atomic registers offer the strongest consistency guarantee. They guarantee that all operations appear to take place instantaneously at a single point in time, known as the linearization point.
- Composability refers to the ability to combine multiple registers without violating the consistency guarantees of individual registers. Sequentially consistent registers are not composable, while atomic registers are.

**Solution 6:**

- Synchronous Systems: These systems operate under the assumption of bounded message delays and processing times. In synchronous systems, algorithms can rely on timeouts to detect failures and make progress.
- Asynchronous Systems: Asynchronous systems do not make any assumptions about message delays or processing times. This makes it more challenging to design algorithms, as failures cannot be reliably detected using timeouts.

The differences between synchronous and asynchronous systems have a significant impact on the design of distributed algorithms. Algorithms for synchronous systems can be simpler and more efficient, but they are not as robust as algorithms for asynchronous systems.

**Solution 7:**

The Causal Order (CO) property ensures that messages are delivered in an order that respects their causal dependencies. In other words, if a message m1 causally precedes message m2, then no process will deliver m2 before m1.3

Vector clocks assign a logical timestamp to each message, capturing the causal history of the message. By comparing the vector timestamps of messages, processes can determine their causal dependencies and ensure that they are delivered in the correct order.

**Solution 8:**

The "no-duplicity" property in the context of BRB is crucial to guarantee that correct processes agree on the messages broadcast by a particular process, even if that process is Byzantine. It ensures that no two correct processes deliver different messages from the same sender.

The ND broadcast algorithm achieves this property by requiring a process to collect ECHO messages from a majority of processes before delivering a message. This ensures that if a Byzantine process sends different messages to different processes, at least one correct process will detect the discrepancy and prevent the delivery of conflicting messages.

**Solution 9:**

|          | Advantages                                                       | Disadvantages                                                                                                        |
| -------- | ---------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| Class P  | * Guarantees both quiescence and termination.                    | * May be more difficult to implement than a failure detector of class Diamond P.                                     |
| Class DP | * May be easier to implement than a failure detector of class P. | * Only guarantees quiescence. Processes may still need to send messages even after all messages have been delivered. |

**Solution 10:**

Sequentially consistent registers are not composable because the total order of operations across multiple registers is not guaranteed to be consistent with the order in which operations were invoked.

Example: Consider two sequentially consistent registers, R1 and R2. Process p1 writes to R1, and then reads from R2. Concurrently, process p2 writes to R2 and then reads from R1. It is possible for p1 to read the value written by p2 to R2 before p2 reads the value written by p1 to R1. This violates the guarantee of a total order of operations across the two registers.

Composability is important because it allows us to build more complex objects from simpler ones without worrying about unexpected interactions. Atomic registers, on the other hand, are composable. This makes them a more desirable choice for building complex systems.