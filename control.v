module div_ctrlpath(clk,start,PgtN,clear,loadN,loadP,loadS,incQ,stop,clear_out);
input clk, start, PgtN;
output loadN,loadP,loadS,incQ,stop,clear_out;
input clear;

reg loadN_R,loadP_R,loadS_R,incQ_R,stop_R;
reg clr;

parameter s0 = 3'b000;
parameter s1 = 3'b001;
parameter s2 = 3'b010;
parameter s3 = 3'b011;
parameter s4 = 3'b100;

reg [2:0]state;
always @(posedge clk) begin
    if (clear) begin
        state = s0;
        loadN_R = 1'b0;
        loadP_R = 1'b0;
        loadS_R = 1'b0;
        incQ_R = 1'b0;
        stop_R = 1'b0;
        clr = 1'b1;
    end
    else begin
        case (state)
            s0 : begin
              if (start) begin // for start = 1 state goes to s1 and stores the dividend
                  loadN_R = 1'b1;
                  loadP_R = 1'b0;
                  loadS_R = 1'b0;
                  incQ_R = 1'b0;
                  clr = 1'b0;
                  state = s1;
              end
              else begin
                  state = s0;
              end
            end 
            s1 : begin // dividend and divisor is loaded
              loadN_R = 1'b0;
              loadP_R = 1'b1;
              loadS_R = 1'b0;
              incQ_R = 1'b0;
              state = s2;
            end
            s2 : begin
              if (!PgtN) begin // check the coparartor output
                 state = s4; 
              end
              else begin // if 1 then dividend register is replaced with subtractor and count incrs by 1
                  loadS_R = 1'b1;
                  loadN_R = 1'b0;
                  loadP_R = 1'b1;
                  incQ_R = 1'b0;
                  state = s3;
              end
              end
            s3 : begin
              if (PgtN) begin // divison carrys on
                 loadS_R = 1'b0;
                 loadN_R = 1'b0;
                 loadP_R = 1'b0;
                 incQ_R = 1'b1;
                 state = s3; 
              end
              else begin
                  loadS_R = 1'b0;
                  loadN_R = 1'b0;
                  loadP_R = 1'b0;
                  incQ_R = 1'b0;
                  stop_R = 1'b1;
                  state = s4;
              end
              end
            s4 : stop_R = 1'b1; // divison stops
        default: state = s0; 
    endcase
    end
end

assign loadN = loadN_R;
assign loadP = loadP_R;
assign loadS = loadS_R;
assign incQ = incQ_R;
assign stop = stop_R;
assign clear_out = clr;

endmodule