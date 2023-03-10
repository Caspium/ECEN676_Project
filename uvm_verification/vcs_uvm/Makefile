comp:
	vcs -full64 -sverilog -ntb_opts uvm-1.2 -kdb -debug_access+all -f filelist.f |& tee comp.log
run:
	./simv -ucli -i mydump_fsdb.tcl +UVM_TESTNAME=dut_test1 |& tee run.log
clean:
	rm -Rf csrc simv* tr_db.log uclk.key verdi_config_file vc_hdrs.h novas_dump.log ucli.key comp.log run.log
