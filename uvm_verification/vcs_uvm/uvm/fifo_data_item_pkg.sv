`ifndef fifo_data_item_pkg_sv
`define fifo_data_item_pkg_sv

package fifo_data_item_pkg;
   import uvm_pkg::*;
   class fifo_data_item extends uvm_sequence_item;
        rand bit[8:0] data;
        rand bit[7:0] data7_0;
        rand bit par;
        constraint par_con { par == ^data7_0; data == {par,data7_0};}
        
        `uvm_object_utils_begin(fifo_data_item)
        `uvm_field_int(data,UVM_ALL_ON)
        `uvm_object_utils_end
   
        function new(string name="fifo_data_item");
            super.new(name); 
        endfunction

        function string psprint();
            string str;
            str=$psprintf("fifo data is %0x",data);
            return str;
        endfunction
        
        function void copy(output fifo_data_item copy_to);
            copy_to.data=this.data;
        endfunction

   endclass
endpackage
`endif
