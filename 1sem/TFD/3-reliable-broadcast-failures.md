# Reliable Broadcast in the Presence of Process Crashes and Unreliable Channels
### Reliable Channel Abstraction
A reliable channel is a communication abstraction that neither creates, nor duplicates, nor loses messages. This is similar to the reliable broadcast specification, and it's not a one-shot problem.
- ***RC-validity***: if *pj* receives a message *m* from *pi*, then *m* was previously sent by *pi* to *pj*.
- ***RC-integrity***: process *pj* receives a message *m* at most once.
- ***RC-termination***: if *pi* completes the sending of *k* messages to *pj*, then, if *pj* is non-faulty and executes *k* times *"receive() from pi"*, *pj* receives *k* messages from *pi*.
---
- The termination property considers that *pj* is non-faulty. This is because, if *pj* crashes, due to process and message asynchrony, it is not possible to state a property on which messages must be received by *pj*.
- It is not possible to conclude from the previous specification that a reliable channel ensures that the messages are received in their sending order (FIFO reception order). This is because, once messages have been given to the “underlying network”, nothing prevents the network from reordering messages sent by *pi*.

### A System Model with Unreliable Channels
- Having *reliable channels* is a strong assumption
- If the channel can lose all messages, no distributed problem can be solved (Two Generals Problem)
- Losses need to be admitted but in some restricted way
- Useful definitions:
	- All messages transmitted are called protocol messages (not application messages)
	- Each protocol message has a type (e.g., MSG, DECIDE, ACK)
	- Let a µ-message be a protocol message of type µ
	- Consider a channel in which *pi* sends protocol messages to *pj*

### Fair Channel (FC)
- ***FC-validity***: if *pj* receives a message *msg* from *pi*, then *msg* has been previously sent by *pi* to *pj*.
- ***FC-integrity***: for any message *msg*, if *pj* receives *msg* from *pi* an infinite number of times, then *pi* has sent *msg* to *pj* an infinite number of times.
- ***FC-termination***: for any message *msg*, if *pi* sends *msg* an infinite number of times to *pj*, and *pj* executes *“receive() from pi”* infinitely often, it receives *msg* from *pi* an infinite number of times.

Each protocol message defines a specific message of type µ and the channel is fair to all types of messages. If a message is sent an arbitrary but finite number of times, there is no guarantee on its reception.

### Fair Lossy Channel (FLC)
- ***FLC-validity***: if *pj* receives a message from *pi*, this message has been previously sent by *pi* to *pj*.
- ***FLC-integrity***: if *pj* receives an infinite number of messages from *pi*, then *pi* has sent an infinite number of messages to *pj*.
- ***FLC-termination***: if *pi* sends an infinite number of messages to *pj* and *pj* is non-faulty and executes *“receive() from pi”* infinitely often, it receives an infinite number of messages from *pi*.

FLC-termination states the channel transmits messages but gives no information about which messages are received.

### Fair vs Fair Lossy Channels (FC vs. FLC)
- FC and FLC are different, but neither is stronger than the other.
- **Example 1:**
	- *pj* sends infinitely-many messages 1, 2, 3, 4, 5, ...
	- What can *pj* receive with **FC** in the worst case? **Nothing** - because no integer is sent an infinite number of times
	- What can *pj* receive with **FLC** in the worst case? **An infinite set of integers** - infinitely many of them being dropped, but infinitely of them being received
- **Example 2:**
	- *pi* sends infinitely-many messages 1, 2, 1, 2, 1, ...
	- What can *pj* receive with **FC** in the worst case? **1 and 2 (infinitely many times)** - because both integers are sent an infinite number of times
	- What can *pj* receive with **FLC** in the worst case? **Just 1 or just 2** - the receiver might only get all instances of either 1 or 2, but not both.

### Uniform Reliable Broadcast (URB) with Fair Channels (FC)
- Using fair channels instead of reliable channels weakens the system model from `CAMP(n,t)` to `CAMP(n,t)[-FC]`
- The URB solution requires also that `t < n/2`, weakening the system even more, resulting in `CAMP(n,t)[-FC, t < n/2
- This relies on two simple techniques:
	1. Use the re-transmissions to build a reliable channel on top of a fair channel.
	2. Locally urb-deliver an application message *m* only when this message has been received by **at least one non-faulty process**. As there are at least *n - t* non-faulty processes and *n - t > t* (model assumption), this means that, without risking remaining blocked forever, a process *pi* may urb-deliver *m* as soon as it knows that at least *t + 1* processes have received a copy of m.
- As a message that is urb-delivered by a process is in the hands of **at least one correct process**, that correct process can transmit it safely to the other processes (by repeated sendings) thanks to the fair channels that connect it to the other processes.

##### URB in *CAMP(n,t)\[-FC, t < n / 2]*
```vhdl
operation URB broadcast (m) is send MSG (m) to pi.

when MSG (m) is received from pk do
(1) if (first reception of m)
(2)     then allocate rec byi[m]; rec byi[m] ← {i, k}
(3)         activate task Diffusei(m)
(4)     else rec byi[m] ← rec byi[m] ∪ {k}
(5) end if

when (|rec byi[m]| ≥ t + 1) ∧ (pi has not yet urb-delivered m) do
(6) URB deliver (m)

task Diffusei(m) is
(7) repeat forever
(8)     for each j ∈ {1,...,n} do send MSG (m) to pj end for
(9) end repeat
```
- The task *Diffusei(m)* forever sends protocol messages (and consequently never terminates).
- There is no algorithm implementing URB-broadcast in *CAMP(n,t)\[-FC, t ≥ n/2]*, due to the **uniformity** URB.

### Failure Detectors (FDs)
- A failure detector (FD) is an approach to circumvent impossibilities.
- Different problems may require different types/classes of FDs to be solved.
- A failure detector is a distributed oracle, with each process associated with a FD module.
- Advantages:
	- **In software engineering**: modularity, portability, etc.
	- **In computability**: allows us to state the minimal assumptions on failures the processes have to be provided with in order for the problem to be solved.

![](./resources/failure-detector.png)

- Let *t* be the value of external real-time clock
- *Failure pattern* *F(t)* is the set of processes failed at a given instant *t*
- *Faulty(F)* is the set of processes that fail during an execution
- *Correct(F) = PI - Faulty(F)*
- An environment captures everything that is not under the control of the algorithm (failures, speed of processes, message transit times, etc).
- The FD output does not depend on the computation executed by the algorithm; it depends only on the actual failure pattern, a feature of the environment.

##### URB in *CAMP(n,t)\[-FC]* with Failure Detector
- **Definition of failure detector of class Θ:** returns a set of trusted processes that always contains at least one correct (**accuracy**) and eventually will contain only correct processes (**liveness**)

The class Θ can be implemented on *CAMP(n,t)\[-FC, t < n/2]*, making URB solvable in a more general *CAMP(n,t)\[-FC, Θ]* system model.

```vhdl
initialization: trustedi ← any set of ⌈ (n+1) / 2 ⌉ processes
background task: repeat forever broadcast ALIVE() end repeat

when ALIVE () is received from pk do
(1) suppress pk from queuei; add pk at the head of queuei
(2) trustedi ← the ⌈ (n+1) / 2 ⌉ processes at the head of queuei
```

### Quiescent Uniform Reliable Broadcast
- **Quiescence**: An algorithm that implements a communication abstraction is ***quiescent*** if each application message it must transfer to its destination processes results in a finite number of protocol messages.
- These properties are from the algorithm, not the problem.
##### Quiescence vs Termination
- **Quiescence**: the transmission of each application message leads to a finite number of protocol messages being sent.
- **Termination**: is a stronger property that states that the algorithm will eventually stop executing
- Quiescence is like everyone stopping for a moment, while termination is like everyone finishing the job.

### Quiescent URB with a Perfect Failure Detector
- **Definition of failure detector class P:** it returns a set of suspected processes that *eventually* contains all faulty processes (**completeness**) and never contains processes not yet crashed (**strong accuracy**).
- P is a failure detector class strictly stronger than Θ, since Θ can be implemented with P, by defining *trustedi = P\\suspectedi*.
- Since Θ can be built in *CAMP(n,t)\[P]* we use the model notation *CAMP(n,t)\[Θ, P]* which provides us with Θ for free.

##### Quiescent URB in *CAMP(n,t)\[-FC, Θ, P]*

> This algorithm is **quiescent** and **terminating**.
```vhdl
operation URB broadcast (m) is send MSG (m) to pi
when MSG (m) is received from pk do
(1) if (first reception of m)
(2)     then allocate rec byi[m]; rec byi[m] ← {i, k}
(3)         activate task Diffusei(m)
(4)     else rec byi[m] ← rec byi[m] ∪ {k}
(5) end if
(6) send ACK (m) to pk

when ACK (m) is received from pk do
(7) rec byi[m] ← rec byi[m] ∪ {k}

when (trustedi ⊆ rec byi[m]) ∧ (pi has not yet urb-delivered m) do
(8) URB deliver (m)

task Diffusei(m) is
(9)  repeat
(10)     for each j ∈ {1,...,n} \ rec byi[m] do
(11)         if (j /∈ suspectedi) then send MSG (m) to pj end if
(12)     end for
(13) until (rec byi[m] ∪ suspectedi) = {1,...,n} end repeat
```
- Each time a process *pi* receives a protocol message *MSG(m)*, it systematically sends back to its sender an *ACK(m)* (6). Moreover, when a process *pi* receives *ACK(m)* from a process *pk*, it knows that *pk* has a copy of the application message *m* and consequently adds *k* to *rec_byi\[m]* (7). This would be sufficient to obtain a quiescent URB construction if no process ever crashed.
- In order to prevent a process *pi* from forever sending protocol messages to a crashed process *pj*, the task *Diffusei(m)* is appropriately modified. A process *pi* repeatedly sends the protocol message *MSG(m)* to a process *pj* only if j ∉ (*rec_byi\[m]* ∪ *suspectedi*) (10-11). Due to the completeness property of the failure detector class P, *pj* will eventually appear in *suspectedi* if it crashes. Moreover, due to the strong accuracy property of the failure detector class P, *pj* will not appear in *suspectedi* before *pj* crashes (if it ever crashes).

### The ◇P Failure Detector
- A variant of P that can output arbitrary values for some time.
- ◇P returns a set of suspected processes that *eventually* contains all faulty processes (**completeness**) and *eventually* never contains processes not yet crashed (**eventual strong accuracy**).
- ◇P is weaker than P, and incomparable to Θ.

##### Quiescent URB in CAMP(n,t)\[-FC, Θ, ◇P]

> **Quiescent** and but **not terminating**
```vhdl
operation URB broadcast (m) is send MSG (m) to pi
when MSG (m) is received from pk do
(1) if (first reception of m)
(2)     then allocate rec byi[m]; rec byi[m] ← {i, k}
(3)         activate task Diffusei(m)
(4)     else rec byi[m] ← rec byi[m] ∪ {k}
(5) end if
(6) send ACK (m) to pk

when ACK (m) is received from pk do
(7) rec byi[m] ← rec byi[m] ∪ {k}

when (trustedi ⊆ rec byi[m]) ∧ (pi has not yet urb-delivered m) do
(8) URB deliver (m)

task Diffusei(m) is
(9)  repeat
(10)     for each j ∈ {1,...,n} \ rec byi[m] do 
(11)         if (j /∈ suspectedi) then send MSG (m) to pj end if
(12)     end for
(13) until (rec byi[m]) = {1,...,n} end repeat % can never be satisfied (not terminating) %
```
- A quiescent URB construction is obtained by replacing the predicate that controls the termination of the task *Diffusei(m)* (line 13 of the P algorithm), by the weaker predicate *rec_byi\[m] = {1,...,n}*. This modification is due to the fact that a set *suspectedi* no longer permanently guarantees that all the processes it contains have crashed. 
- We know that, after some finite time, *suspectedi* will contain only crashed processes and will eventually contain all the crashed processes. It follows from the previous observation that this algorithm is quiescent but not necessarily terminating (according to the failure pattern, it is possible that the termination predicate is never satisfied).

### The Heartbeat (HB) Failure Detector
- This is the weakest class of failure detectors for quiescent communication.
- Both P and ◇P require synchrony to be implemented, but quiescence can be provided in *CAMP(n,t)\[-FC]* with the HB failure detector.
- *HBi\[j]* counts heartbeats from process *pj* at process *pi* such that if *pj* is faulty, *HBi\[j]* will be bounded (**completeness**) and, if *pj* is correct, *HBi\[j]* keeps increasing (**liveness**).
- Contrary to previous FD classes, the output of HB is unbounded (the values output by the failure detector can grow indefinitely).

##### Quiescent URB in *CAMP(n,t)\[-FC, Θ, HB]*

> **Quiescent** but **not terminating**
```vhdl
operation URB broadcast (m) is send MSG (m) to pi
when MSG (m) is received from pk do
(1) if (first reception of m)
(2)     then allocate rec byi[m], prev hbi[m], cur hbi[m]
(3)         rec byi[m] ← {i, k}
(4)         activate task Diffuse(m)
(5)     else rec byi[m] ← rec byi[m] ∪ {k}
(6) end if
(7) send ACK (m) to pk

when ACK (m) is received from pk do
(8) rec byi[m] ← rec byi[m] ∪ {k}

when (trustedi ⊆ rec byi[m]) ∧ (pi has not yet urb-delivered m) do
(9) URB deliver (m)

task Diffusei(m) is
(10) prev hbi[m] ← [−1,..., −1]
(11) repeat
(12)     cur hbi[m] ← HBi
(13)     for each j ∈ {1,...,n} \ rec byi[m] do
(14)         if (prev hbi[m][j] < cur hbi[m][j]) then send MSG (m) to pj end if
(15)     end for
(16)     prev hbi[m] ← cur hbi[m]
(17) until rec byi[m] = {1,...,n} end repeat
```
- This algorithm contains a previous and a current heartbeat array (line 2). Basically, a process *pi* sends the protocol message *MSG(m)* to a process *pj* only if *j ∉ rec_byᵢ\[m]* (from *pi*’s point of view, *pj* has not yet received the application message m), and *HBi\[j]* has increased since the last test (from *pi*’s point of view, *pj* is alive, predicate of line 14). The local variables *prev_hbi\[m]\[j]* and *cur_hbi\[m]\[j]* are used to keep the two last values read from *HBi\[j]*.
- In essence, the lack of direct confirmation, combined with the possibility of indefinite message loss, creates a situation where the algorithm can become quiescent (stops sending new messages) but still remains stuck in an internal loop, waiting for a confirmation that will never arrive.

### Final Remarks
- Fair channel is the most common non-reliable channel model used.
- It is impossible to implement URB in *CAMP(n,t)\[-FC, t ≥ n/2]*.
- Failure detectors are used obtain information about the environment, namely what processes are faulty and which are non-faulty.
- Several FDs for URB:
	- **Class Θ** (theta): guarantees the existence of at least one trusted process at any time, and eventually, it only includes correct processes.
		- Provides each process *pi* with a set *trustedi*.
		- **Accuracy**: the set *trustedi* always contains at least one non-faulty process.
		- **Liveness**: eventually, the set *trustedi* of any non-faulty process *pi* contains only non-faulty processes.
		- Weakest FD for implementing URB.
	- **Class P** (perfect): accurately identifies crashed processes without false suspicions.
		- Provides each process *pi* with a set *suspectedi*.
		- **Completeness**: if a process crashes, it eventually appears **permanently** in the *suspectedi* set of all correct processes.
		- **Strong accuracy**: no process appears in the *suspectedi* set before it crashes.
		- FD for implementing quiescent and terminating URB.
		- Cannot be implemented in purely asynchronous environments, because of its uncertainty associated with message delays in them. 
	- **Class ◇P** (eventually perfect): can initially have false suspicions, but eventually, it behaves like a perfect failure detector, accurately identifying crashed processes.
		- Provides each process *pi* with a set *suspectedi*.
		- **Completeness**: if a process crashes, it will eventually appear in the *suspectedi* set of all correct processes.
		- **Eventual strong accuracy**: there is a time after which no correct process appears in the *suspectedi* set (weaker property than P).
		- Weakest bounded FD for implementing quiescent URB.
		- Weaker than P.
		- Can be implemented in purely asynchronous environments but requires additional assumptions or mechanisms to address the inherent uncertainty of message delays.
	- **Class HB** (heartbeat): tracks the liveness of processes based on heartbeat messages.
		- Provides each process *pi* with an array *HBi\[1...n]* containing integers.
		- **Completeness**: for each correct process *pi* and each crashed process *pj*, there exists a maximum value that *HBI\[j]* will reach.
		- **Liveness**: the values in *HBi* are non-decreasing, and for any two correct processes *pi* and *pj*, *HBi\[j]* will increase indefinitely.
		- Weakest (unbounded) FD for implementing quiescent URB - contrary to P and ◇P, HB can be implemented in asynchronous systems.