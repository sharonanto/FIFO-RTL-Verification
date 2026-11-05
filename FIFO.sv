
module FIFO #(
    parameter FIFO_WIDTH = 8,
    parameter FIFO_CAPACITY = 8
)
(
    fifo_if.DUT fifoif
);

    localparam ADDRESS_WIDTH =
        (FIFO_CAPACITY <= 1) ? 1 : $clog2(FIFO_CAPACITY);

    localparam COUNT_WIDTH =
        (FIFO_CAPACITY <= 1) ? 1 : $clog2(FIFO_CAPACITY + 1);

    logic [FIFO_WIDTH-1:0] memory_array [0:FIFO_CAPACITY-1];

    logic [ADDRESS_WIDTH-1:0] write_pointer;
    logic [ADDRESS_WIDTH-1:0] read_pointer;

    logic [COUNT_WIDTH-1:0] element_count;

    logic write_accept;
    logic read_accept;

    assign write_accept = fifoif.wr_en && !fifoif.full;
    assign read_accept  = fifoif.rd_en && !fifoif.empty;

    always_ff @(posedge fifoif.clk or negedge fifoif.rst_n) begin
        if (!fifoif.rst_n) begin
            write_pointer <= '0;
            fifoif.wr_ack <= 1'b0;
            fifoif.overflow <= 1'b0;
        end
        else begin
            fifoif.wr_ack <= write_accept;
            fifoif.overflow <= fifoif.wr_en && fifoif.full;

            if (write_accept) begin
                memory_array[write_pointer] <= fifoif.data_in;

                if (write_pointer == FIFO_CAPACITY-1)
                    write_pointer <= '0;
                else
                    write_pointer <= write_pointer + 1'b1;
            end
        end
    end

    always_ff @(posedge fifoif.clk or negedge fifoif.rst_n) begin
        if (!fifoif.rst_n) begin
            read_pointer <= '0;
            fifoif.data_out <= '0;
            fifoif.underflow <= 1'b0;
        end
        else begin
            fifoif.underflow <= fifoif.rd_en && fifoif.empty;

            if (read_accept) begin
                fifoif.data_out <= memory_array[read_pointer];

                if (read_pointer == FIFO_CAPACITY-1)
                    read_pointer <= '0;
                else
                    read_pointer <= read_pointer + 1'b1;
            end
        end
    end

    always_ff @(posedge fifoif.clk or negedge fifoif.rst_n) begin
        if (!fifoif.rst_n) begin
            element_count <= '0;
        end
        else begin
            case ({write_accept, read_accept})
                2'b10: element_count <= element_count + 1'b1;
                2'b01: element_count <= element_count - 1'b1;
                default: element_count <= element_count;
            endcase
        end
    end

    assign fifoif.full = (element_count == FIFO_CAPACITY);
    assign fifoif.empty = (element_count == 0);

    assign fifoif.almostfull =
        (element_count == FIFO_CAPACITY-1);

    assign fifoif.almostempty = (element_count == 1);

endmodule
