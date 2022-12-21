`timescale 1ns / 1ps

module mac(
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif


    input [7:0] in,
    input clk,clken,rst,ld,ld1,ld2,ld3,ld4,
    output[15:0] out);
    reg[7:0] i1,i2,i3,i4;
    wire [7:0] mac1_in1,mac1_in2,mac2_in1,mac2_in2;
    wire [15:0] mid;
    wire [16:0]x1,x2;
    reg [7:0] x3,x4;
    wire [7:0] x5;
    p_reg I1 (ld1,rst,in,mac1_in1,clk);
    p_reg I2 (ld2,rst,in,mac1_in2,clk);
    p_reg I3 (ld3,rst,in,mac2_in1,clk);
    p_reg I4 (ld4,rst,in,mac2_in2,clk);
    example_mac m1(mac1_in1,mac1_in2,clk,rst,clken,x1);
    example_mac m2(mac2_in1,mac2_in2,clk,rst,clken,x2);
    assign mid={x3,x4};
    always@(posedge clk)
    begin
    x3<=x1[16:9];
    x4<=x2[16:9];
    end
    PISO P1(mid,ld,clk,rst,x5);
    AF A1(x5,out,rst);
endmodule


//MAC
module example_mac(
    input [7:0] c,d,
    input clk,aclr,clken,
    output reg [16:0] out
    );
    reg[7:0]a,b;
    reg[15:0]multa_reg;
    wire[15:0]multa;
    wire[16:0]adder_out;
   
    assign multa=a * b;
    assign adder_out=multa_reg + out;
   
    always@(posedge clk or posedge aclr)
    begin
    if(aclr)
    begin
    a<= 8'b0;
    b<= 8'b0;
    multa_reg<= 16'b0;
    out<=17'b0;
    end
    else if(clken)
    begin
    a<=c;
    b<=d;
    multa_reg<=multa;
    out<=adder_out;
    end  
    end
endmodule

//piso

module PISO(in,ld,clk,rst,q);
  input ld,clk,rst;
  input [15:0] in;
  output wire [7:0] q;
  reg [15:0]qq;
  assign q=qq[7:0];
  always @ (posedge clk, posedge rst)
    begin
      if(rst)
         qq<=0;
      else if(ld)
          qq <=in;
      else
        qq <= {8'b0,qq[15:8]};
    end
endmodule

//p_REG
module p_reg(ld,rst,in,out,clk);
  input ld,rst,clk;
  input [7:0] in;
  output wire [7:0] out;
  reg [7:0]qq;
  assign out=qq[7:0];
  always @ (posedge ld or posedge rst)
    begin
      if(rst)
         qq<=0;
      else if(ld)
          qq <=in;
      else
          qq<=qq;
    end
endmodule


//ACTIVATION FUNCTION

module AF(x,out,rst);

    input rst;
    input signed [7:0] x;
    output reg signed [15:0] out;
     
   
   reg signed [7:0] y,z,sum;
   reg signed [15:0] sq,sh;
   
   always@(*)
   begin
   if(x[7]==1'b1)
       y=-x;
   else
       y=x;
   z=y>>>2 ;
     
   sum= z+8'b1111_0000;
     
   sq=sum*sum;

   sh=sq>>>1;

   if(x[7]==1'b1)
       out=sh;
   else if(rst)
       out=16'b0000000000000000;
   else
       out=16'b00000001_00000000-sh;
   end
   
endmodule
