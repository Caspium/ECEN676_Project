`ifndef fifo_sb_sv
`define fifo_sb_sv
`uvm_analysis_imp_decl(_we)
`uvm_analysis_imp_decl(_re)
class fifo_sb extends uvm_scoreboard;
   `uvm_component_utils(fifo_sb)
   uvm_analysis_imp_we#(fifo_data_item, fifo_sb) we_export;
   uvm_analysis_imp_re#(fifo_data_item, fifo_sb) re_export;
   logic[8:0] we_q[$];
   logic[8:0] re_q[$];
   int run_num,we_num,re_num;
   int correct_num;
   int wrong_num;
   
   function new(string name="fifo_sb",uvm_component parent);
       super.new(name,parent);
       we_export=new("we_export",this);
       re_export=new("re_export",this);
       run_num=0;
       correct_num=0;
       wrong_num=0;
       we_num=0;
       re_num=0;
   endfunction
   virtual function void write_we(fifo_data_item item);
      `uvm_info("fifo_sb.write_we",$psprintf("fifo_sb got one data from WE: %s",item.psprint()),UVM_LOW)
      we_q.push_back(item.data);
      we_num++;
   endfunction
   virtual function void write_re(fifo_data_item item);
      `uvm_info("fifo_sb.write_re",$psprintf("fifo_sb got one data from RE: %s",item.psprint()),UVM_LOW)
      re_q.push_back(item.data);
      re_num++;
   endfunction
  
   task run_phase(uvm_phase phase);
      logic[8:0] re_data; 
      logic[8:0] we_data; 
      super.run_phase(phase);
      `uvm_info("fifo_sb","Starting...",UVM_LOW)
      forever begin
         wait(re_q.size!=0);
         re_data=re_q.pop_front();
         `uvm_info("fifo_sb.run_phase",$psprintf("get one data from re_q: %0x",re_data),UVM_LOW)
         run_num++;
         if(we_q.size==0) begin
            `uvm_error("fifo_sb.run_phase","No data in we_q")
            wrong_num++;
         end 
         else begin
            we_data=we_q.pop_front();
            `uvm_info("fifo_sb.run_phase",$psprintf("get one data from we_q: %0x",we_data),UVM_LOW)
            if(we_data!=re_data) begin
               `uvm_error("fifo_sb.run_phase",$psprintf("Mismatch: we_data: %0x, re_data: %0x",we_data,re_data))
               wrong_num++;
            end
            else begin
               `uvm_info("fifo_sb.run_phase",$psprintf("Correct: we_data: %0x, re_data: %0x",we_data,re_data),UVM_LOW)
               correct_num++;
            end
         end
      end
   endtask

   virtual function void report_phase(uvm_phase phase);
      super.report_phase(phase);
      if(run_num!=re_num) begin
          `uvm_error("fifo_sb.report_phase",$psprintf("Mismatch run_num: %0d, re_num: %0d",run_num,re_num))
      end
      else begin
         if(wrong_num!=0) begin
            `uvm_error("fifo_sb.report_phase",$psprintf("Wrong data num: run_num: %0d, wrong_num: %0d, correct_num",run_num,wrong_num,correct_num))
         end
         else begin
            `uvm_info("fifo_sb.report_phase",$psprintf("Success: run_num: %0d",run_num),UVM_LOW)
         end
      end
   endfunction 
endclass

`endif
