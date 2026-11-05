
module fifo_testbench;

    parameter FIFO_WIDTH = 8;
    parameter FIFO_CAPACITY = 8;

    logic clk;

    fifo_if #(FIFO_WIDTH) fifoif();

    FIFO #(
        .FIFO_WIDTH(FIFO_WIDTH),
        .FIFO_CAPACITY(FIFO_CAPACITY)
    ) dut (fifoif);

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        fifoif.rst_n = 0;
        fifoif.wr_en = 0;
        fifoif.rd_en = 0;
        fifoif.data_in = 0;

        #20;
        fifoif.rst_n = 1;

        #20;
        $finish;

    end

    initial begin
        $dumpfile("fifo_waveform.vcd");
        $dumpvars(0, fifo_testbench);
    end

initial begin

    fifoif.rst_n = 0;
    fifoif.wr_en = 0;
    fifoif.rd_en = 0;
    fifoif.data_in = 0;

    #20;
    fifoif.rst_n = 1;

    // Write operation
    #10;
    fifoif.wr_en = 1;
    fifoif.data_in = 8'hA5;

    #10;
    fifoif.wr_en = 0;

    #20;
    $finish;

end

endmodule


