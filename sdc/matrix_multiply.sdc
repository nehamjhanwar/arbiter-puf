###############################################################################
# Created by write_sdc
# Mon Dec 19 11:28:44 2022
###############################################################################
current_design matrix_multiply
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk -period 14.0000 [get_ports {clk}]
set_clock_transition 0.1500 [get_clocks {clk}]
set_clock_uncertainty 0.2500 clk
set_propagated_clock [get_clocks {clk}]
set_input_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {execute}]
set_input_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {input_val[0]}]
set_input_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {input_val[1]}]
set_input_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {input_val[2]}]
set_input_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {input_val[3]}]
set_input_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {input_val[4]}]
set_input_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {input_val[5]}]
set_input_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {input_val[6]}]
set_input_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {input_val[7]}]
set_input_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {reset}]
set_input_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {sel_in[0]}]
set_input_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {sel_in[1]}]
set_input_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {sel_in[2]}]
set_input_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {sel_out[0]}]
set_input_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {sel_out[1]}]
set_output_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {result[0]}]
set_output_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {result[10]}]
set_output_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {result[11]}]
set_output_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {result[12]}]
set_output_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {result[13]}]
set_output_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {result[14]}]
set_output_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {result[15]}]
set_output_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {result[16]}]
set_output_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {result[1]}]
set_output_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {result[2]}]
set_output_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {result[3]}]
set_output_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {result[4]}]
set_output_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {result[5]}]
set_output_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {result[6]}]
set_output_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {result[7]}]
set_output_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {result[8]}]
set_output_delay 2.8000 -clock [get_clocks {clk}] -add_delay [get_ports {result[9]}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0334 [get_ports {result[16]}]
set_load -pin_load 0.0334 [get_ports {result[15]}]
set_load -pin_load 0.0334 [get_ports {result[14]}]
set_load -pin_load 0.0334 [get_ports {result[13]}]
set_load -pin_load 0.0334 [get_ports {result[12]}]
set_load -pin_load 0.0334 [get_ports {result[11]}]
set_load -pin_load 0.0334 [get_ports {result[10]}]
set_load -pin_load 0.0334 [get_ports {result[9]}]
set_load -pin_load 0.0334 [get_ports {result[8]}]
set_load -pin_load 0.0334 [get_ports {result[7]}]
set_load -pin_load 0.0334 [get_ports {result[6]}]
set_load -pin_load 0.0334 [get_ports {result[5]}]
set_load -pin_load 0.0334 [get_ports {result[4]}]
set_load -pin_load 0.0334 [get_ports {result[3]}]
set_load -pin_load 0.0334 [get_ports {result[2]}]
set_load -pin_load 0.0334 [get_ports {result[1]}]
set_load -pin_load 0.0334 [get_ports {result[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {clk}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {execute}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reset}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {input_val[7]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {input_val[6]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {input_val[5]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {input_val[4]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {input_val[3]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {input_val[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {input_val[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {input_val[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sel_in[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sel_in[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sel_in[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sel_out[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sel_out[0]}]
set_timing_derate -early 0.9500
set_timing_derate -late 1.0500
###############################################################################
# Design Rules
###############################################################################
set_max_fanout 10.0000 [current_design]
