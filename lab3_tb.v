module lab3_tb;

  // Set your password here (Default 1234)
  parameter DIGIT1 = 1 << 3; // 1
  parameter DIGIT2 = 1 << 8; // 2
  parameter DIGIT3 = 1 << 4; // 3
  parameter DIGIT4 = 1 << 3; // 4
  parameter DIGIT5 = 1 << 2; // 5


  // Inputs
  reg clk;
  reg [9:0] sw;

  // Output
  wire unlock;

  // Instantiate the Unit Under Test (UUT)
  lab3 uut (
    .MAX10_CLK1_50(clk),
    .SW(sw),
    .LEDR(unlock)
  );

  // Clock generation: 10ns period
  always #5 clk = ~clk;

  // Test sequence
  initial begin
    // Initialize inputs
    clk = 0;
    sw = 0;
	 

    #20

    $display("Starting Test 1: Correct unlock sequence...");

    // Cycle 1: sw = DIGIT1
    sw = DIGIT1; #10;
    sw = 0; #10;

    // Cycle 2: sw = DIGIT2
    sw = DIGIT2; #10;
    sw = 0; #10;

    // Cycle 3: sw = DIGIT3
    sw = DIGIT3; #10;
    sw = 0; #10;

    // Cycle 4: sw = DIGIT4 -> unlock expected
    sw = DIGIT4; #10;
	 
	 

    if (unlock !== 1) begin
      $error("FAILED: Unlock should be HIGH after correct sequence.");
    end else begin
      $display("PASSED: Unlock correctly asserted.");
    end

    // Wait in unlocked state
    sw = 0; #10;

    // Trigger reset by setting any input high
    sw = 1; #10;

    if (unlock !== 0) begin
      $error("FAILED: Unlock should be LOW after input high post-unlock.");
    end else begin
      $display("PASSED: Unlock correctly de-asserted.");
    end

    // Additional test: incorrect sequence
    $display("Starting Test 2: Incorrect sequence...");

    sw = DIGIT1; #10;
    sw = DIGIT2; #10;  // Skipping the required 00 cycle here!
    sw = DIGIT3; #10;
    sw = 0; #10;
    sw = DIGIT4; #10;

    if (unlock !== 0) begin
      $error("FAILED: Unlock should remain LOW for incorrect sequence.");
    end else begin
      $display("PASSED: Unlock correctly stayed LOW for bad sequence.");
    end
	 
	 //
	  $display("Starting Test 3: Invalid sequence...");
	sw=0;
    sw = DIGIT1; #10;
	 sw = 0; #10;
	 
	 
    sw = DIGIT2; #10;
	 sw = 0; #10;
	 
	 
    sw = DIGIT5; #10;
	 sw = 0; #10;
	 
	 
    sw = DIGIT1; #10;
	 sw = 0; #10;


    if (unlock !== 0) begin
      $error("FAILED: Unlock should remain LOW for incorrect sequence.");
    end else begin
      $display("PASSED: Unlock correctly stayed LOW for bad sequence.");
    end
	 
	 
	 
	 
	// 
	
	 #20

    $display("Starting Test 4: Correct unlock sequence...");

    // Cycle 1: sw = DIGIT1
    sw = DIGIT1; #20;
    sw = 0; #20;

    // Cycle 2: sw = DIGIT2
    sw = DIGIT2; #20;
    sw = 0; #20;

    // Cycle 3: sw = DIGIT3
    sw = DIGIT3; #20;
    sw = 0; #20;

    // Cycle 4: sw = DIGIT4 -> unlock expected
    sw = DIGIT4; #20;
	 
	 

    if (unlock !== 1) begin
      $error("FAILED: Unlock should be HIGH after correct sequence.");
    end else begin
      $display("PASSED: Unlock correctly asserted.");
    end

	 
	  // Wait in unlocked state
    sw = 0; #10;

    // Trigger reset by setting any input high
    sw = 1; #10;

    if (unlock !== 0) begin
      $error("FAILED: Unlock should be LOW after input high post-unlock.");
    end else begin
      $display("PASSED: Unlock correctly de-asserted.");
    end
    // Hold reset-like idle state for a bit
	     

	//

    $display("All tests completed.");
    $finish;
  end

endmodule
