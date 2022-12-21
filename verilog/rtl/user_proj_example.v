// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none
/*
 *-------------------------------------------------------------
 *
 * user_proj_example
 *
 * This is an example of a (trivially simple) user project,
 * showing how the user project can connect to the logic
 * analyzer, the wishbone bus, and the I/O pads.
 *
 * This project generates an integer count, which is output
 * on the user area GPIO pads (digital output only).  The
 * wishbone connection allows the project to be controlled
 * (start and stop) from the management SoC program.
 *
 * See the testbenches in directory "mprj_counter" for the
 * example programs that drive this user project.  The three
 * testbenches are "io_ports", "la_test1", and "la_test2".
 *
 *-------------------------------------------------------------
 */

module user_proj_example #(
    parameter BITS = 32
) (
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [63:0] la_data_in,
    output [63:0] la_data_out,
    input  [63:0] la_oenb,

    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // Independent clock (on independent integer divider)
    input   user_clock2,

    // User maskable interrupt signals
    output [2:0] user_irq

);

    wire clk;
    //wire rst;

    wire [`MPRJ_IO_PADS-1:0] io_in;
    wire [`MPRJ_IO_PADS-1:0] io_out;
    wire [`MPRJ_IO_PADS-1:0] io_oeb;
    
    assign io_in[24] = clk;

    //wire [31:0] rdata; 
    //wire [31:0] wdata;
    //wire [BITS-1:0] count;

    //wire valid;
    //wire [3:0] wstrb;
    //wire [31:0] la_write;
    
    
    wire reset,execute, clk;
    wire [2:0]sel_in;
    wire[7:0]input_val;
    wire [1:0]sel_out;
    wire [16:0]result;

    assign io_out[21:5] = result ;
    assign io_oeb[21:0] = 22'b0; 		//io_oenb is a data output enable bar, output (io_out) is enabled when it is 0 and 
    
    
    assign io_in[35:28] = input_val;
    assign io_in[27:25] = sel_in;
    assign io_in[37:36] = sel_out;
    assign io_in[22] = execute;
    assign io_in[23] = reset;
    assign io_in[24] = clk;
    
    assign io_oeb[37:22] = 16'b1111_111111_111111;		//io_oenb is a data output enable bar, input (io_in) when it is 1.
    
    

matrix_multiply mprj(
`ifdef USE_POWER_PINS
	.vccd1(vccd1),	// User area 1 1.8V power
	.vssd1(vssd1),	// User area 1 digital ground
`endif
	.sel_in(sel_in),
	.input_val(input_val),
	.result(result),
	.sel_out(sel_out),
	.clk(clk),
	.reset(reset),
	.execute(execute),
);

endmodule


module matrix_multiply(
`ifdef USE_POWER_PINS
	inout vccd1,	// User area 1 1.8V power
	inout vssd1,	// User area 1 digital ground
	
`endif

    input reset,execute, clk,
    input [2:0]sel_in,
    input [7:0]input_val,
    input [1:0]sel_out,
    output [16:0]result
    );
    reg [7:0]A[0:1][0:1];
    reg [7:0]B[0:1][0:1];
    reg [16:0]C[0:1][0:1];
    
    integer i,j,k; 
    wire [0:7]D;
    decoder_3x8 select_in (D, sel_in, !execute);
    
    always @(posedge clk, negedge reset)    
    begin
        if(!reset) begin
            {A[0][0],A[0][1],A[1][0],A[1][1]} <= 32'd0;
            {B[0][0],B[0][1],B[1][0],B[1][1]} <= 32'd0;
        end
        else begin
            A[0][0] <= D[0] ? input_val : A[0][0];
            A[0][1] <= D[1] ? input_val : A[0][1];
            A[1][0] <= D[2] ? input_val : A[1][0];
            A[1][1] <= D[3] ? input_val : A[1][1];
            B[0][0] <= D[4] ? input_val : B[0][0];
            B[0][1] <= D[5] ? input_val : B[0][1];
            B[1][0] <= D[6] ? input_val : B[1][0];
            B[1][1] <= D[7] ? input_val : B[1][1];
        end

    end
    always @(*)
        begin
            {C[0][0],C[0][1],C[1][0],C[1][1]} = 68'd0;
            
            for(i=0;i <2;i=i+1)
              for(j=0;j <2;j=j+1)
                for(k=0;k <2;k=k+1)
                C[i][j] = C[i][j] + (A[i][k] * B[k][j]);
               
        end
        
    reg [16:0] result1; 
    always @(*)
    begin case(sel_out)
       2'b00:   result1 <=C[0][0];
       2'b01:   result1 <=C[0][1];
       2'b10:   result1 <=C[1][0];
       2'b11:   result1 <=C[1][1];
       endcase
    end     
    assign result = {17{execute}}&result1;

endmodule

module decoder_3x8(
    output [0:7] D,
    input [2:0] S,
    input en
    );
    
    assign D[0] = !S[2] && !S[1] && !S[0] && en;
    assign D[1] = !S[2] && !S[1] && S[0] && en;
    assign D[2] = !S[2] && S[1] && !S[0] && en;
    assign D[3] = !S[2] && S[1] && S[0] && en;
    assign D[4] = S[2] && !S[1] && !S[0] && en;
    assign D[5] = S[2] && !S[1] && S[0] && en;
    assign D[6] = S[2] && S[1] && !S[0] && en;
    assign D[7] = S[2] && S[1] && S[0] && en;
    
endmodule
`default_nettype wire
