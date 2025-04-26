module axi_to_apb_bridge(
    input wire clk,
    input wire rst_n,
    input wire [31:0] awaddr,
    input wire awvalid,
    output reg awready,
    input wire [31:0] wdata,
    input wire wvalid,
    output reg wready,
    output reg bvalid,
    input wire bready,
    output reg PSEL,
    output reg PENABLE,
    output reg PWRITE,
    output reg [31:0] PADDR,
    output reg [31:0] PWDATA
);

    reg [1:0] state;
    localparam IDLE = 0, SETUP = 1, ACCESS = 2, DONE = 3;

    reg [31:0] awaddr_reg, wdata_reg;
    reg aw_seen, w_seen;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            awready <= 0;
            wready <= 0;
            bvalid <= 0;
            PSEL <= 0;
            PENABLE <= 0;
            PWRITE <= 0;
            PADDR <= 0;
            PWDATA <= 0;
            aw_seen <= 0;
            w_seen <= 0;
        end else begin
            case (state)
                IDLE: begin
                    awready <= 0;
                    wready <= 0;
                    bvalid <= 0;
                    PSEL <= 0;
                    PENABLE <= 0;

                    // Capture AWADDR when AWVALID is high
                    if (awvalid && !aw_seen) begin
                        awaddr_reg <= awaddr;
                        awready <= 1;
                        aw_seen <= 1;
                    end

                    // Capture WDATA when WVALID is high
                    if (wvalid && !w_seen) begin
                        wdata_reg <= wdata;
                        wready <= 1;
                        w_seen <= 1;
                    end

                    if (aw_seen && w_seen) begin
                        awready <= 0;
                        wready <= 0;
                        PADDR <= awaddr_reg;
                        PWDATA <= wdata_reg;
                        PWRITE <= 1;
                        PSEL <= 1;
                        state <= SETUP;
                    end
                end

                SETUP: begin
                    PENABLE <= 1;
                    state <= ACCESS;
                end

                ACCESS: begin
                    PSEL <= 0;
                    PENABLE <= 0;
                    bvalid <= 1;
                    state <= DONE;
                end

                DONE: begin
                    if (bready) begin
                        bvalid <= 0;
                        aw_seen <= 0;
                        w_seen <= 0;
                        state <= IDLE;
                    end
                end

                default: state <= IDLE;
            endcase
        end
    end

endmodule
