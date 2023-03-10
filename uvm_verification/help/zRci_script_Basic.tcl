# © 2015-2019 Synopsys, Inc.
# This Synopsys ZeBu Lab source code and all associated documentation are proprietary and
# confidential to Synopsys, Inc. and may only be used pursuant to the terms and conditions
# of a written license agreement with Synopsys, Inc. All other use, reproduction,
# modification, or distribution of the Synopsys ZeBu Lab source code or the associated
# documentation is strictly prohibited.

##################################################################
# zRci Script for ZeBu Basic Labs
##################################################################


##################################################################
#     Procedure to compute read & write frequency in testbench
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
# Initializing Emulation
start_zebu runtime_output

# Initializing memory
memory -load top.u_stb.u_rom.mem -file ../memories/rom.hex


#----------------------------------------
# Section for SVAs only - activation
#----------------------------------------
# SVA callback signature
#proc sva_callback {success severity message filename line scope start_time end_time} {
#}
# Start SVA processing

#------------END OF SECTION for SVA ---------------

#----------------------------------------
# Section for DPI only - activation
#----------------------------------------
# Load DPI dynamic library 

# Set the sampling clock

# Enable the DPI

#------------END OF SECTION for DPI ---------------


#-------------------------------------------------------------
# Section for Waveforms with Dynamic-Probes only - activation
#-------------------------------------------------------------
# Start dump - Dynamic Probes

# Section for Waveforms with Dynamic-Probes only - activation
#------------END OF SECTION for Dynamic-Probes ---------------


#-------------------------------------------------------------
# Section for Waveforms with FWC only - activation
#-------------------------------------------------------------
# Start FWC dump

#------------END OF SECTION for FWC ---------------

#----------------------------------------
# Section for Basic Run & all features
#----------------------------------------
# Forcing signals to set parameters - Program probability for write and read
puts "#############################################"
puts "# Forcing signals: ( wr : 30 % , rd : 30 % )"
force top.u_stb.proba_rd\[9:0\] [proba2hex 30] -radix hexa -freeze
force top.u_stb.proba_wr\[9:0\] [proba2hex 30] -radix hexa -freeze

puts "# Resetting design during 10 clock cycles" 
# Write rstn signal to enable reset
force top.u_stb.rstn 0 -freeze

# Running 10 cycles
run 10

# Disabling reset
force top.u_stb.rstn 1 -freeze

puts "# Running 1000 cycles"
# Running 1000 cycles
run 1000

# Displaying signals value in decimal format
puts "# Number of errors detected:"
puts "#   on input : [get top.u_stb.cnt_error_in -radix dec]"
puts "#   on output: [get top.u_stb.cnt_error_out -radix dec]"

puts "# Storing ram memory content to memdump.hex file"
# Dumping result memory content to an hexadecimal text file
memory -store top.u_stb.u_ram.mem -file memdump.hex

puts "#############################################"
  
#-------------------------------------------------------------
# Section for Waveforms with Dynamic-Probes only - closing
#-------------------------------------------------------------
# Stop dump - Dynamic Probes

#------------END OF SECTION for Dynamic-Probes -------------------

#-------------------------------------------------------------
# Section for Waveforms with FWC only - closing
#-------------------------------------------------------------
# Stop FWC dump

#------------END OF SECTION for FWC ---------------------------

#----------------------------------------------------------------
# Closing Emulation - Last command of script, for all scenarios
#----------------------------------------------------------------
exit
