module apb_slave(
    input wire PCLK,
    input wire PRESETn,
    input wire PSEL,
    input wire PENABLE,
    input wire PWRITE,
    input wire [31:0] PADDR,
    input wire [31:0] PWDATA,
    output reg [31:0] PRDATA
);
    reg [31:0] mem [0:15];

    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn) begin
            PRDATA <= 0;
        end else if (PSEL && PENABLE && PWRITE) begin
            mem[PADDR[5:2]] <= PWDATA;
        end else if (PSEL && PENABLE && !PWRITE) begin
            PRDATA <= mem[PADDR[5:2]];
        end
    end

endmodule