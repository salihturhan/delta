module testbench;
    reg clk;
    reg rst_n;
    reg [3:0] REQ;
    wire [3:0] GNT;
    roundrobin_arbiter uut (
        .clk(clk),
        .rst_n(rst_n),
        .REQ(REQ),
        .GNT(GNT)
    );
    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Stimulus generation
    initial begin
        clk = 0;
        rst_n = 0;
        REQ = 4'b0000;

        // Reset
        #10 rst_n = 1;

        // Test case 1
        #10 REQ = 4'b0001;
        #10 REQ = 4'b0010;
        #10 REQ = 4'b0100;
        #10 REQ = 4'b1000;

        // Test case 2
        #10 REQ = 4'b1000;
        #10 REQ = 4'b0100;
        #10 REQ = 4'b0010;
        #10 REQ = 4'b0001;

        // Test case 3
        #10 REQ = 4'b1010;
        #10 REQ = 4'b0101;
        #10 REQ = 4'b1100;
        #10 REQ = 4'b0011;

        // End simulation
        $finish;
    end

    // Instantiate the arbiter module
    

 
endmodule
