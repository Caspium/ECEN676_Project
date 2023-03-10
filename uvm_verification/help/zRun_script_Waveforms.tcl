# © 2015-2019 Synopsys, Inc.
# This Synopsys ZeBu Lab source code and all associated documentation are proprietary and
# confidential to Synopsys, Inc. and may only be used pursuant to the terms and conditions
# of a written license agreement with Synopsys, Inc. All other use, reproduction,
# modification, or distribution of the Synopsys ZeBu Lab source code or the associated
# documentation is strictly prohibited.

##################################################################
#     Procedure to compute read & write frequency in testbench
#
proc proba2hex {p} {
  set p100 [expr $p * 1023 / 100]
  set pstr [format %03X $p100]
  return $pstr
}
##################################################################


###############################
#     Main

#----------------------------------------
# Section for Basic Run & all features
#----------------------------------------
# Initializing memory - Load data memory
ZEBU_Memory_loadFromFile top.u_stb.u_rom.mem ../memories/rom.hex


#----------------------------------------
# Section for SVAs only - activation
#----------------------------------------
# Start SVA processing
#if {[ZEBU_Sva_isDefined] == 1} {
#  ZEBU_Sva_init
#  ZEBU_Sva_setSeverityReport info
#  ZEBU_Sva_start live top.u_stb.clk0
#  ZEBU_Sva_activate ZSVA..* 0
#}
#------------END OF SECTION for SVA ---------------

#----------------------------------------
# Section for DPI only - activation
#----------------------------------------
# Enable DPI 
# Load DPI dynamic library 
#ZEBU_CCall_loadDynamicLibrary ../libDPI/libDPI.so
# Set the sampling clock
#ZEBU_CCall_selectSamplingClocks top.u_stb.clk0
# Start the DPI
#ZEBU_CCall_start
#------------END OF SECTION for DPI ---------------


#-------------------------------------------------------------
# Section for Waveforms with Dynamic-Probes only - activation
#-------------------------------------------------------------
# Start dump - Dynamic Probes
ZEBU_Dump_file "runtime_output/dump.ztdb" top.u_stb.clk0
ZEBU_Dump_on
# Section for Waveforms with Dynamic-Probes only - activation
#------------END OF SECTION for Dynamic-Probes ---------------


#-------------------------------------------------------------
# Section for Waveforms with FWC only - activation
#-------------------------------------------------------------
# Start FWC dump
  if {[ZEBU_Fwc_isDefined]} {
    if {[ZEBU_Fwc_init]} {
      ZEBU_Fwc_setSamplingClock "top.u_stb.clk0"
      ZEBU_Fwc_addValueSet fwc_essential_signals 
      ZEBU_Fwc_addValueSet fwc_fifo_ports
      ZEBU_Fwc_setOutputDir "runtime_output/fwc_dump.ztdb"
      ZEBU_Fwc_dumpOnOff "on"
    }
  }
#------------END OF SECTION for FWC ---------------

#----------------------------------------
# Section for Basic Run & all features
#----------------------------------------
# Forcing signals to set parameters - Program probability for write and read
puts "#############################################"
puts "# Forcing signals: ( wr : 30 % , rd : 30 % )"
ZEBU_Signal_force top.u_stb.proba_rd\[9:0\] [proba2hex 30]
ZEBU_Signal_force top.u_stb.proba_wr\[9:0\] [proba2hex 30]

# Write rstn signal to enable reset
puts "# Resetting design during 10 clock cycles" 
ZEBU_Signal_force top.u_stb.rstn 0 %h

# Running 10 cycles
ZEBU_Clock_enable top.u_stb.clk0  10
while { [ZEBU_Clock_getStatus top.u_stb.clk0]=="running" } { after 100 }

# Disabling reset
ZEBU_Signal_force top.u_stb.rstn 1 %h

# Flush the SW cache
ZEBU_Monitor_flush

# Running 1000 cycles
puts "# Running 1000 cycles"
ZEBU_Clock_enable top.u_stb.clk0  1000
while { [ZEBU_Clock_getStatus top.u_stb.clk0]=="running" } { after 100 }

# Displaying signals value in decimal format
puts "# Number of data transferred: [ZEBU_Signal_read top.u_stb.addr_rd %d] (requested: 1000)"
puts "# Number of errors detected:"
puts "#    on input : [ZEBU_Signal_read top.u_stb.cnt_error_in %d]"
puts "#    on output: [ZEBU_Signal_read top.u_stb.cnt_error_out %d]"

# Dumping result memory content to an hexadecimal text file
puts "# Storing ram memory content to mem_dump.hex file"
ZEBU_Memory_storeToFile top.u_stb.u_ram.mem memdump.hex

puts "#############################################"
  
#-------------------------------------------------------------
# Section for Waveforms with Dynamic-Probes only - closing
#-------------------------------------------------------------
# Stop dump - Dynamic Probes
ZEBU_Dump_flush
ZEBU_Dump_close
#------------END OF SECTION for Dynamic-Probes -------------------

#-------------------------------------------------------------
# Section for Waveforms with FWC only - closing
#-------------------------------------------------------------
# Stop FWC dump
ZEBU_Fwc_flush
ZEBU_Fwc_close
#------------END OF SECTION for FWC ---------------------------

