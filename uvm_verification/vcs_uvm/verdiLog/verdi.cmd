simSetSimulator "-vcssv" -exec "/home/grads/c/caspium/lab-1-Caspium/vcs_uvm/simv" \
           -args "-ucli +UVM_TESTNAME=dut_test1"
debImport "-dbdir" "/home/grads/c/caspium/lab-1-Caspium/vcs_uvm/simv.daidir"
debLoadSimResult /home/grads/c/caspium/lab-1-Caspium/vcs_uvm/myfsdb.fsdb
wvCreateWindow
srcHBSelect "top.dut_inst" -win $_nTrace1
srcHBSelect "top.dut_inst.u_parity" -win $_nTrace1
srcHBSelect "top.dut_inst.u_fifo" -win $_nTrace1
srcSetScope -win $_nTrace1 "top.dut_inst.u_fifo" -delim "."
srcHBSelect "top.dut_inst.u_fifo" -win $_nTrace1
srcHBSelect "top.dut_inst.u_fifo.u0_clkg" -win $_nTrace1
srcSetScope -win $_nTrace1 "top.dut_inst.u_fifo.u0_clkg" -delim "."
srcHBSelect "top.dut_inst.u_fifo.u0_clkg" -win $_nTrace1
srcHBSelect "top.dut_inst.u_fifo" -win $_nTrace1
srcSetScope -win $_nTrace1 "top.dut_inst.u_fifo" -delim "."
srcHBSelect "top.dut_inst.u_fifo" -win $_nTrace1
wvGetSignalOpen -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/_vcs_msglog"
wvGetSignalSetScope -win $_nWave2 "/top/dut_inst/u_fifo"
wvGetSignalSetScope -win $_nWave2 "/top"
wvGetSignalSetScope -win $_nWave2 "/dut_re_pkg"
wvGetSignalSetScope -win $_nWave2 "/dut_we_pkg"
wvGetSignalSetScope -win $_nWave2 "/tb"
wvGetSignalSetScope -win $_nWave2 "/top"
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/top/datain\[8:0\]} \
{/top/dataout\[8:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G2" \
}
wvSelectSignal -win $_nWave2 {( "G1" 1 2 )} 
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/top/datain\[8:0\]} \
{/top/dataout\[8:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G2" \
}
wvSelectSignal -win $_nWave2 {( "G1" 1 2 )} 
wvSetPosition -win $_nWave2 {("G1" 2)}
wvGetSignalClose -win $_nWave2
wvGetSignalOpen -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/_vcs_msglog"
wvGetSignalSetScope -win $_nWave2 "/top"
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/top/datain\[8:0\]} \
{/top/dataout\[8:0\]} \
{/top/clk0} \
{/top/clk1} \
}
wvAddSignal -win $_nWave2 -group {"G2" \
}
wvSelectSignal -win $_nWave2 {( "G1" 3 4 )} 
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/top/datain\[8:0\]} \
{/top/dataout\[8:0\]} \
{/top/clk0} \
{/top/clk1} \
}
wvAddSignal -win $_nWave2 -group {"G2" \
}
wvSelectSignal -win $_nWave2 {( "G1" 3 4 )} 
wvSetPosition -win $_nWave2 {("G1" 4)}
wvGetSignalClose -win $_nWave2
wvGetSignalOpen -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/_vcs_msglog"
wvGetSignalSetScope -win $_nWave2 "/top"
wvGetSignalSetScope -win $_nWave2 "/top/dut_inst"
wvGetSignalSetScope -win $_nWave2 "/top/dut_inst/u_fifo"
wvGetSignalSetScope -win $_nWave2 "/top"
wvGetSignalSetScope -win $_nWave2 "/top/dut_inst/u_check"
wvGetSignalSetScope -win $_nWave2 "/top/dut_inst"
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/top/datain\[8:0\]} \
{/top/dataout\[8:0\]} \
{/top/clk0} \
{/top/clk1} \
}
wvAddSignal -win $_nWave2 -group {"G2" \
}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvGetSignalClose -win $_nWave2
wvSaveSignal -win $_nWave2 \
           "/home/grads/c/caspium/lab-1-Caspium/vcs_uvm/signal.rc"
debExit
