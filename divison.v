`include "datapath.v"
`include "control.v"

module divison(clk,start,Clear,data_input,Quotient,Remainder);
input clk, start, Clear;
input [7:0]data_input;
output [7:0]Quotient,Remainder;

wire loadN,loadP,loadS,clear,incQ,stop,PgtN;

div_ctrlpath u_div_ctrlpath(.clk(clk),
                            .start(start),
                            .PgtN(PgtN),
                            .clear(clear),
                            .loadN(loadN),
                            .loadP(loadP),
                            .loadS(loadS),
                            .incQ(incQ),
                            .stop(stop),
                            .clear_out(clear));
div_datapath u_div_datapath(.clk(clk),
                            .Data_in(data_input),
                            .loadN(loadN),
                            .loadP(loadP),
                            .loadS(loadS),
                            .clear(clear_out),
                            .incQ(incQ),
                            .stop(stop),
                            .PgtN(PgtN),
                            .Res(Quotient),
                            .Rem(Remainder));

endmodule