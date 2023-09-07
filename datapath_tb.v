`timescale 1ns/100ps
`include "datapath.v"

module datapath_tb;
    reg clk;
    reg [7:0]Data_in;
    reg loadN,loadP,loadS,clear,incQ,stop;
    wire [7:0]Res,Rem;
    wire PgtN;

    div_datapath uut(clk,Data_in,loadN,loadP,loadS,clear,incQ,stop,PgtN,Res,Rem);
    always begin
        clk = ~clk;#5;
    end
    initial begin
        clk = 1'b0;
    end
    initial begin
        $dumpfile("datapath.vcd");
        $dumpvars(0,datapath_tb);
        clear = 1'b1; #10;
        clear=1'b0;
        loadN = 1'b1;Data_in = 8'd16;#10;
        loadN = 1'b0;
        loadP = 1'b1;Data_in = 8'd3;#10;
        loadP = 1'b0;
        loadS = 1'b1;#10;
        loadS = 1'b0;
        incQ = 1'b1;#40;
        incQ = 1'b0; stop = 1'b1; #10;
        stop = 1'b0; #10;
        $finish;
    end

endmodule