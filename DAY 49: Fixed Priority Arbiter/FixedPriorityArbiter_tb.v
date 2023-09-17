module tb_priority_arbiter_4bit;

  // Define signals for inputs and outputs
  reg [3:0] requests;
  reg clk;
  wire [3:0] out;

  // Instantiate the priority_arbiter_4bit module
  priority_arbiter_4bit uut (
    .clk(clk),
    .requests(requests),
    .out(out)
  );

  // Stimulus generation
  always begin
    #5 clk = ~clk;
  end

  // Reset ve başlatma sinyallerini ayarla
  initial begin
    clk = 0;
    #10
    requests = 4'b0000;

    // Apply test cases
    $display("Input: requests=%b", requests);
    $display("Output: out=%b", out);
     #10
    // Test case 1: Request 0 has the highest priority
    requests = 4'b0001;
    $display("Input: requests=%b", requests);
    $display("Output: out=%b", out);
     #10
    // Test case 2: Request 2 has the highest priority
    requests = 4'b0100;
    $display("Input: requests=%b", requests);
    $display("Output: out=%b", out);
     #10
    // Add more test cases as needed

    // End simulation
    $finish;
  end

endmodule