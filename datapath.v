module div_datapath(clk,Data_in,loadN,loadP,loadS,clear,incQ,stop,PgtN,Res,Rem);
    input clk;
    input [7:0]Data_in;
    input loadN,loadP,loadS,clear,incQ,stop;
    output [7:0]Res,Rem;
    output PgtN;
    // loadN --> load N in dividend loadP --> load P in divisor
    // load S --> (dividend - divisor) stored in dividend 
    // reg counter;
    reg [7:0] temp;
    reg [7:0]dividend;
    reg [7:0]divisor;
    reg [7:0]Q;
    reg [7:0]res,rem;

    assign PgtN = (dividend >= divisor)?1:0;

    always @(posedge clk) begin
        if (clear) begin
            dividend = 8'b0;
            divisor = 8'b0;
            temp = 8'b0;
            Q = 8'b0;
        end
    end
    always @(posedge clk) begin
        if (loadN) begin
            dividend = Data_in;
        end
        if (loadP) begin
            divisor = Data_in;            
        end
        if (loadS) begin
            temp = dividend;
            dividend = dividend - divisor;
            Q = Q + 1;
        end
        if (incQ) begin
            temp = dividend;
            dividend = dividend - divisor;
            Q = Q + 1;
        end
        if (stop) begin
            res = Q;
            rem = dividend;
        end
    end

assign Res = res;
assign Rem = rem;

endmodule