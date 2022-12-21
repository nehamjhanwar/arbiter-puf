`timescale 1ns / 1ps

module arbiterpuf(
`ifdef USE_POWER_PINS
	inout vccd1,	// User area 1 1.8V power
	inout vssd1,	// User area 1 digital ground
`endif
input ipulse,
input[15:0] ichallenge,
output oresponse
    );
    wire odelay_line_oout_1;
    wire odelay_line_oout_2;
    
    delay_line inst_delay_line (
    .ipulse(ipulse),
    .ichallenge(ichallenge),
    .oout_1(odelay_line_oout_1),
    .oout_2(odelay_line_oout_2)
    );
    dff inst_dff1(
    .id(odelay_line_oout_2),
    .iclk(odelay_line_oout_1),
    .oq(oresponse)
    );
    
endmodule
module mux(
    input ia,
    input ib,
    input isel,
    output reg oout
    );
     always@(*)
         oout <= isel ? ia : ib;
endmodule
module dff(
    input id,
    input iclk,
    output reg oq
    );
    
    always @ (posedge iclk)  
    begin 
   oq <= id;
   end
endmodule
module delay_line(
//input ipulse,isel,
//output oout
input ipulse,
input [C_LENGTH - 1 : 0] ichallenge,
output oout_1,
output oout_2
    );
    `ifndef parameters
`define  parameters

 parameter C_LENGTH = 16; //the length of the chain of the multiplexer 
`endif 
    (* dont_touch = "yes" *) wire  [2 * C_LENGTH + 1 : 0] net;
 //   wire [2 * C_LENGTH + 1 : 0] net;
    assign net [0] =ipulse;
    assign net [1] = ipulse;
    generate
    genvar i;
    for (i =1; i <= C_LENGTH; i = i +1)
    begin
    mux inst_mux_1(
    .ia(net[i *2 -2]),
    .ib(net[i *2 -1]),
    .isel(ichallenge[i-1]),
    .oout(net[i *2])
    );
     mux inst_mux_2(
    .ia(net[i *2 - 1]),
    .ib(net[i *2 -2]),
    .isel(ichallenge[i - 1]),
    .oout(net[i * 2 +1])
    );
    end
           
    endgenerate
    
    assign oout_1 = net [C_LENGTH * 2];
    assign oout_2 = net [C_LENGTH * 2 + 1];
    endmodule
