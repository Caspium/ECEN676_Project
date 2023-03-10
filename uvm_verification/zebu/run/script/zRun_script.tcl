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


#----------------------------------------
# Section for SVAs only - activation
#----------------------------------------
# Start SVA processing

#------------END OF SECTION for SVA ---------------

#----------------------------------------
# Section for DPI only - activation
#----------------------------------------
# Enable DPI 
# Load DPI dynamic library 

# Set the sampling clock

# Start the DPI

#------------END OF SECTION for DPI ---------------


#-------------------------------------------------------------
# Section for Waveforms with Dynamic-Probes only - activation
#-------------------------------------------------------------
# Start dump - Dynamic Probes

#------------END OF SECTION for Dynamic-Probes ---------------


#-------------------------------------------------------------
# Section for Waveforms with FWC only - activation
#-------------------------------------------------------------
# Start FWC dump

#------------END OF SECTION for FWC ---------------

#----------------------------------------
# Section for Basic Run & all features
#----------------------------------------
puts "#############################################"
puts "# Forcing signals: ( wr : 30 % , rd : 30 % )"
# Forcing signals to set parameters - Program probability for write and read


puts "# Resetting design during 10 clock cycles" 
# Write rstn signal to enable reset

# Running 10 cycles

# Disabling reset

# Flush the SW cache

puts "# Running 1000 cycles"
# Running 1000 cycles

# Displaying signals value in decimal format
puts "# Number of data transferred: [ZEBU_Signal_read top.u_stb.addr_rd %d] (requested: 1000)"
puts "# Number of errors detected:"
puts "#    on input : [ ]"
puts "#    on output: [ ]"

puts "# Storing ram memory content to mem_dump.hex file"
# Dumping result memory content to an hexadecimal text file

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

