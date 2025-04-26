module tb;
    reg clk;
    reg rst_n;

    // Declare wires to monitor the output signals from the top module
    wire [31:0] awaddr, wdata, PADDR, PWDATA;
    wire awvalid, awready, wvalid, wready, bvalid, bready;
    wire PSEL, PENABLE, PWRITE;
    wire [31:0] PRDATA;

    // Instantiate the top-level module
    top uut (
        .clk(clk),
        .rst_n(rst_n),
        .awaddr(awaddr),
        .wdata(wdata),
        .PADDR(PADDR),
        .PWDATA(PWDATA),
        .awvalid(awvalid),
        .awready(awready),
        .wvalid(wvalid),
        .wready(wready),
        .bvalid(bvalid),
        .bready(bready),
        .PSEL(PSEL),
        .PENABLE(PENABLE),
        .PWRITE(PWRITE),
        .PRDATA(PRDATA)
    );

    // Generate clock signal
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Initialize the simulation and apply reset
    initial begin
        // Set up waveform dumping
        $dumpfile("waveform.vcd");
        $dumpvars(0, uut);  // Dump all signals inside the top module (uut)

        // Apply reset
        rst_n = 0;
        #15 rst_n = 1;  // Release reset after 15 time units

        // Finish the simulation after some time
        #120 $finish;
    end
endmodule
