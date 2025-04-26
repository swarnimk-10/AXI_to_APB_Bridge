module axi_master (
    input wire clk,
    input wire rst_n,
    output reg [31:0] awaddr,
    output reg awvalid,
    input wire awready,
    output reg [31:0] wdata,
    output reg wvalid,
    input wire wready,
    input wire bvalid,
    output reg bready
);

    reg [3:0] state;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= 0;
            awaddr <= 0;
            awvalid <= 0;
            wdata <= 0;
            wvalid <= 0;
            bready <= 0;
        end else begin
            case (state)
                0: begin
                    awaddr <= 32'hDEADBEEF;
                    awvalid <= 1;
                    if (awready) begin
                        awvalid <= 0;
                        state <= 1;
                    end
                end
                1: begin
                    wdata <= 32'h12345678;
                    wvalid <= 1;
                    if (wready) begin
                        wvalid <= 0;
                        state <= 2;
                    end
                end
                2: begin
                    bready <= 1;
                    if (bvalid) begin
                        bready <= 0;
                        state <= 3;
                    end
                end
            endcase
        end
    end
endmodule
