
interface fifo_if #(parameter FIFO_WIDTH = 8);

    logic clk;
    logic rst_n;

    logic wr_en;
    logic rd_en;

    logic [FIFO_WIDTH-1:0] data_in;
    logic [FIFO_WIDTH-1:0] data_out;

    logic wr_ack;
    logic overflow;
    logic underflow;

    logic full;
    logic empty;
    logic almostfull;
    logic almostempty;

    modport DUT (
        input clk, rst_n, wr_en, rd_en, data_in,
        output data_out, wr_ack, overflow, underflow,
        full, empty, almostfull, almostempty
    );

    modport TB (
        output clk, rst_n, wr_en, rd_en, data_in,
        input data_out, wr_ack, overflow, underflow,
        full, empty, almostfull, almostempty
    );

    modport MON (
        input clk, rst_n, wr_en, rd_en, data_in,
        data_out, wr_ack, overflow, underflow,
        full, empty, almostfull, almostempty
    );

endinterface
