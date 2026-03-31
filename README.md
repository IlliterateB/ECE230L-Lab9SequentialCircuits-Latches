# Sequential Circuits: Latches


In this lab, you learned about the basic building block of sequential circuits: the latch.


## Rubric


| Item | Description | Value |
| ---- | ----------- | ----- |
| Summary Answers | Your writings about what you learned in this lab. | 25% |
| Question 1 | Your answers to the question | 25% |
| Question 2 | Your answers to the question | 25% |
| Question 3 | Your answers to the question | 25% |


## Names
Tylor Sorenson, Bryson Leatham
## Summary
In this lab we are introduced to sequential logic, where the circuits can store values and update only on specific events. We implemented a D-latch in verilog that stores input data when enabled and holds it otherwise, then we use it to build a 4-bit memory system to demonstrate how basic memory structures work in a larger system.
## Lab Questions


###  Why can we not just use structural Verilog to implement latches?
It creates timing and synthesis issues and simulation-synthesis mismatches, so it's best to use Behavioral logic to avoid this by explicitly describing memory using always blocks and reg. Structural Verilog can also be harder to read and write when creating complex structures.
### What is the meaning of always @(*) in a sensitivity block?
	The @(*) makes it so all signals from the always block are added to its sensitivity list,  so the block re-executes whenever any input changes. It also means it requires no memory to perform its processes, which avoids unintended latches and keeps the circuit fully responsive to inputs.
### What importance is memory to digital circuits?
	Considering memory is required when designing digital circuits, as it is used to store data, maintain system states, and enable the sequential logic circuits.

