module top(
    input wire clk,
    input wire rst_n,
    // Output signals to verify in the simulation
    output wire [31:0] awaddr, wdata, PADDR, PWDATA,
    output wire awvalid, awready, wvalid, wready, bvalid, bready,
    output wire PSEL, PENABLE, PWRITE,
    output wire [31:0] PRDATA
);
    // Internal signals to connect different modules
    wire [31:0] awaddr_internal, wdata_internal, PADDR_internal, PWDATA_internal;
    wire awvalid_internal, awready_internal, wvalid_internal, wready_internal, bvalid_internal, bready_internal;
    wire PSEL_internal, PENABLE_internal, PWRITE_internal;
    wire [31:0] PRDATA_internal;

    // Instantiate the AXI Master
    axi_master axi_master_inst (
        .clk(clk), .rst_n(rst_n),
        .awaddr(awaddr_internal), .awvalid(awvalid_internal), .awready(awready_internal),
        .wdata(wdata_internal), .wvalid(wvalid_internal), .wready(wready_internal),
        .bvalid(bvalid_internal), .bready(bready_internal)
    );

    // Instantiate the AXI to APB Bridge
    axi_to_apb_bridge axi_to_apb_bridge_inst (
        .clk(clk), .rst_n(rst_n),
        .awaddr(awaddr_internal), .awvalid(awvalid_internal), .awready(awready_internal),
        .wdata(wdata_internal), .wvalid(wvalid_internal), .wready(wready_internal),
        .bvalid(bvalid_internal), .bready(bready_internal),
        .PSEL(PSEL_internal), .PENABLE(PENABLE_internal), .PWRITE(PWRITE_internal),
        .PADDR(PADDR_internal), .PWDATA(PWDATA_internal)
    );

    // Instantiate the APB Slave
    apb_slave apb_slave_inst (
        .PCLK(clk), .PRESETn(rst_n),
        .PSEL(PSEL_internal), .PENABLE(PENABLE_internal), .PWRITE(PWRITE_internal),
        .PADDR(PADDR_internal), .PWDATA(PWDATA_internal),
        .PRDATA(PRDATA_internal)
    );

    // Connect internal signals to output ports for verification
    assign awaddr = awaddr_internal;
    assign wdata = wdata_internal;
    assign PADDR = PADDR_internal;
    assign PWDATA = PWDATA_internal;
    assign awvalid = awvalid_internal;
    assign awready = awready_internal;
    assign wvalid = wvalid_internal;
    assign wready = wready_internal;
    assign bvalid = bvalid_internal;
    assign bready = bready_internal;
    assign PSEL = PSEL_internal;
    assign PENABLE = PENABLE_internal;
    assign PWRITE = PWRITE_internal;
    assign PRDATA = PRDATA_internal;

endmodule
