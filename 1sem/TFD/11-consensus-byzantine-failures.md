# Implementing Consensus in Enriched Byzantine Asynchronous Systems
- **Byzantine Failures (BAMP Model):** faulty processes can do anything.
- Byzantine consensus requires a slightly different properties:
	- **BC-validity:** if all correct processes propose the same value v, only v can be decided.
	- **BC-agreement:** no two correct processes decide different values.
	- **BC-termination:** each correct process decides a value.
	- **RBC-termination:** with probability of 1, every correct process decides.
- It is also possible to solve consensus assuming eventual synchrony (◇SYNC).

### The Binary Value (BV) Broadcast Abstraction
- The **BV-broadcast is an all-to-all broadcast abstraction**, which provides the processes with a single operation denoted BV *broadcast()*.
	- **All-to-all:** all the correct processes invoke the operation BV broadcast().
- In a BV-broadcast instance, each correct process *pi* bv-broadcasts a binary value and has access to a read-only set *bin_values_i* of binary values.
- BV-broadcast is defined by the following properties:
	- **BV-validity**: if *pi* is correct and *v ∈ bin_values_i*, *v* has bv-broadcast by a correct process.
	- **BV-uniformity**: if a value *v* is added to the set *bin_values_i* of a correct process *pi*, eventually *v ∈ bin_values_j* at any correct process *pj*.
	- **BV-termination**: eventually the set *bin_values_i* of each correct process *pi* is non-empty.

##### BV-Broadcast in BAMP(n,t)\[t < n/3]
```vhdl
operation BV broadcast MSG(vi) is
(1) broadcast B_VAL(vi)

when B_VAL(v) is received
(2) if (B_VAL(v) received from (t + 1) different processes and B_VAL(v) not yet broadcast)
(3)     then broadcast B_VAL(v) % a process echoes a value only once %
(4) end if;
(5) if (B_VAL(v) received from (2t + 1) different processes)
(6)     then bin valuesi ← bin valuesi ∪ {v} % local delivery of a value %
(7) end if
```
- This protocol **does not explicitly terminate**.
- Eventually the sets *bin_valuesi* of the correct processes *pi* become non-empty and equal. Moreover, they do not contain a value bv-broadcast only by byzantine processes.

### Randomized Byzantine Binary Consensus
- Using BV broadcast and a Common Coin (CC) abstraction, it is possible to implement an **optimal byzantine binary consensus**.
	- Optimal resilience: **t < n/3**;
	- Optimal message complexity: **O(n²)**;
	- Optimal number of rounds: expected constant.
- The implementation of the common coin is not as trivial as in the crash model:
	- Byzantine processes should not be able to see coin values from future rounds.
	- This requires the use of a distributed cryptographic protocol to reveal the random bit of a round only when correct processes reach this round.
	- A potential instantiation is to have a-priori secret-shared random numbers.

##### Byzantine Binary Consensus in BAMP(n,t)\[t < n/3, CC]
```vhdl
operation propose(vi) is
esti ← vi; ri ← 0;
repeat forever
(1) ri ← ri + 1;
(2) BV broadcast EST[ri](esti);
(3) wait (bin valuesi[ri] ̸= ∅);
% bin valuesi[ri] has not necessarily obtained its final value when wait terminates %
(4) broadcast AUX[ri](w) where w ∈ bin valuesi[ri];
(5) wait (∃ a set valuesi and a set of (n − t) messages AUX[ri]() such that
        valuesi is the set union of the values x carried by these (n − t) messages
        ∧ valuesi ⊆ bin valuesi[ri]);
(6) si ← random();
(7) if (valuesi = {v}) % i.e.,|valuesi| = 1 %
(8)     then if (v = si) then decide(v) if not yet done end if;
(9)         esti ← v
(10)    else esti ← si
(11) end if
end repeat
```
- Waits at least **n-t messages** (line 5);
- *values* contains only proposals from correct processes (line 5);
- If *values = {v}*, then *v* is in the values set of each correct process (line 5).
- A **random bit is generated on each round** - only decides if values has a single value and this value is equal the random bit (line 6);

### Byzantine Multi-Valued Consensus
- In order to build state machine replication, we need total order broadcast, which requires multi-valued consensus.
- We want a transformation from byzantine binary consensus (BBC) to byzantine multi-valued consensus, satisfying the same validity condition we presented before:
	- **BC-validity**: if all correct processes propose the same value *v*, only *v* can be decided.
- The protocol requires n byzantine reliable broadcasts and n binary consensus instances.

##### Byzantine Multi-valued Consensus in BAMP(n,t)\[t < n/3, BBC]
```vhdl
operation propose(vi) is
(1) BRB broadcast PROP(vi);
(2) wait (|{x such that bin deci[x]=1}| ≥ n − t);
(3) for each j such that pi did not invoked BIN CONS[j].bin propose()
(4)     do invoke BIN CONS[j].bin propose(0)
(5) end for;
(6) wait (#1≤x≤n bin deci[x] ̸= ⊥);
(7) wait (#1≤x≤n(bin deci[x] = 1) ⇒ (proposalsi[x] ̸= ⊥));
(8) let mseti = multiset of values proposalsi[x] such that bin deci[x]=1; % mset is equal in all correct processes %
(9) if (∃v appearing at least (t + 1) times in the multiset mseti)
(10)    then return(v)
(11)    else ℓ ← min({x such that bin deci[x] = 1);
(12)       return(proposali[ℓ])
(13) end if

(14) when PROP (v) is brb-delivered from pj do
(15)    proposalsi[j] ← v;
(16)    if BIN CONS[j].bin propose() not invoked
(17)       then BIN CONS[j].bin propose(1)
(18)    end if

(19) when BIN CONS[j].bin propose() returns b do bin deci[x] ← b.
```
