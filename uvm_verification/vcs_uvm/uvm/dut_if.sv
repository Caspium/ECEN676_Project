interface dut_if(
   input logic clk0,
   input logic clk1,
   input rstn
);
   logic[8:0] datain;
   logic we;
   logic re;
   
   logic readyin;
   logic[8:0] dataout;
   logic readyout;
   logic error;
   clocking we_drv_cb @(posedge clk0);
      output datain;
      output we;
      input readyin;
   endclocking 
   clocking we_mon_cb @(posedge clk0);
      input datain;
      input we;
      input readyin;
   endclocking 
   clocking re_drv_cb @(posedge clk1);
      input dataout;
      output re;
      input readyout;
   endclocking 
   clocking re_mon_cb @(posedge clk1);
      input dataout;
      input re;
      input readyout;
   endclocking 
   modport we_drv_mp(
     input clk0,
     input rstn,
     clocking we_drv_cb
   );
   modport re_drv_mp(
     input clk1,
     input rstn,
     clocking re_drv_cb
   );
   modport we_mon_mp(
     input clk0,
     input rstn,
     clocking we_mon_cb
   );
   modport re_mon_mp(
     input clk1,
     input rstn,
     clocking re_mon_cb
   );

endinterface
