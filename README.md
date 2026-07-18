# Digital Lock Finite State Machine (FSM) Design and Implementation
State Diagram  
<img width="625" height="283" alt="Screenshot 2026-07-18 at 3 25 05 PM" src="https://github.com/user-attachments/assets/70188784-8465-4559-b9e9-67d4e9932064" />  

Digital Lock: Finite State Machine  
<img width="347" height="257" alt="Screenshot 2026-07-18 at 3 25 23 PM" src="https://github.com/user-attachments/assets/1d4366b3-c067-4e16-a6d7-0bb83b10ae15" />  
<img width="515" height="286" alt="Screenshot 2026-07-18 at 3 25 36 PM" src="https://github.com/user-attachments/assets/6448f423-c42b-440d-a6f9-0f99379b6303" />





In this lab, a digital lock was modeled using a Mealy State Machine. The design specifications of our digital lock included having 10 inputs (SW[9:0]) and one output (unlock). The lock also needed at least one cycle of all inputs low between elements, a reset algorithm after an invalid input is given, the output high as soon as the final digit is received, and keeping it high until another input has caused it to go low. The passcode to the digital lock was ‘3843’. The FSM for the FPGA was created using 9 states.

The first state (S0) would be waiting for the first input ‘3’ and remain at S0 otherwise. The second state (S1) would stay in S1 as long as the input ‘3’ is high, and would go to S2 when all inputs go low. The third state (S2) would stay in S2 as long as all the inputs are low, and would go to S3 when the input ‘8’ is detected. The fourth state (S3) would stay in S3 as long as the input ‘8’ is high, and would go to S4 when all inputs go low. The fifth state (S4) would stay in S4 as long as all the inputs are low, and would go to S5 when the input ‘4’ is detected. The sixth state (S5) would stay in S5 as long as the input ‘4’ is high, and would go to S6 when all inputs go low. The seventh state (S6) would stay in S6 as long as all the inputs are low, and would go to S7 when the input ‘3’ is detected. When the digital lock detects the final integer of the passcode sequence ‘3’, the output (unlock) becomes high. In the eighth state (S7), the output would remain high as long as the input ‘3’ is high, and would go to S8 when all inputs go low. In the ninth state, the output is high as long as all inputs are low; any invalid input would set the digital lock to S0 and cause the input to go low. In all these states, if any invalid input is detected, it would go to S0.

The states were then modeled in Verilog using combinational and sequential logic. Since the design used 9 states, the Verilog modeling used 4 bits to represent the current and next state. To represent the numbers 0-9, the inputs were tied to SW[9:0], and the output was tied to LEDR[0]. The sequential logic updated the state on every positive edge of the clock, and the reset was tied to the negative edge of the KEY[0] since it is active low. Because the FSM is only changed depending on the state and inputs, the combinational logic is only tied to the switches and current state. To get rid of the debouncing of the switches, a Periodic Sampler was used to prevent glitches. To represent all inputs going low, the logic ((SW[9:0] == 10’b0000000000)) was used.

To test this circuit, a testbench was provided. In the test bench, we tested the correct unlock sequence in test 1. Then, in test 2, it was checked that the design would function correctly if there was never a cycle of all inputs low between elements. In test three, the wrong sequence of ‘3823’ was tested. In sequence four, the correct sequence of ‘3843’ was tested using a time delay of 20ps. In the end, all outputs were expected.

















Resource Utilization Report  
<img width="457" height="272" alt="Screenshot 2026-07-18 at 3 25 54 PM" src="https://github.com/user-attachments/assets/dd2dee2e-d343-40c6-8c78-7c5e01689a46" />  

In this design, 59 Total logic elements and 39 flip-flops were used.




Challenges/Conclusion  

In this lab, the hardest part was writing Verilog code from the state diagram. This lab successfully demonstrated the design and implementation of a Mealy FSM digital lock that recognizes a four-digit sequence and sets the unlock output immediately upon detecting the final valid digit. Simulation verification using a testbench confirmed correct handling of both valid and invalid input sequences. The completed design meets all specifications, with resource utilization documented and a demonstration confirming the operation of the digital lock system.



