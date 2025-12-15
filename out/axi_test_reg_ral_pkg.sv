package axi_test_reg_ral_pkg;
  import uvm_pkg::*;
  import rggen_ral_pkg::*;
  `include "uvm_macros.svh"
  `include "rggen_ral_macros.svh"
  class register_0_reg_model extends rggen_ral_reg;
    rand rggen_ral_field bit_field_0;
    rand rggen_ral_field bit_field_1;
    rand rggen_ral_field bit_field_2;
    rand rggen_ral_field bit_field_3;
    rand rggen_ral_field bit_field_4;
    rand rggen_ral_field bit_field_5;
    rand rggen_ral_rowo_field bit_field_6;
    function new(string name);
      super.new(name, 32, 0);
    endfunction
    function void build();
      `rggen_ral_create_field(bit_field_0, 0, 4, "RW", 0, 4'h0, '{}, 1, 0, 0, "")
      `rggen_ral_create_field(bit_field_1, 4, 4, "RW", 0, 4'h0, '{}, 1, 0, 0, "")
      `rggen_ral_create_field(bit_field_2, 8, 1, "RW", 0, 1'h0, '{}, 1, 0, 0, "")
      `rggen_ral_create_field(bit_field_3, 9, 2, "W1", 0, 2'h0, '{}, 1, 0, 0, "")
      `rggen_ral_create_field(bit_field_4, 11, 2, "WRC", 0, 2'h0, '{}, 1, 0, 0, "")
      `rggen_ral_create_field(bit_field_5, 13, 2, "WRS", 0, 2'h0, '{}, 1, 0, 0, "")
      `rggen_ral_create_field(bit_field_6, 15, 2, "ROWO", 1, 2'h0, '{}, 1, 0, 0, "")
    endfunction
  endclass
  class register_1_reg_model extends rggen_ral_reg;
    rand rggen_ral_field register_1;
    function new(string name);
      super.new(name, 32, 0);
    endfunction
    function void build();
      `rggen_ral_create_field(register_1, 0, 1, "RW", 0, 1'h0, '{}, 1, 0, 0, "")
    endfunction
  endclass
  class register_2_reg_model extends rggen_ral_reg;
    rand rggen_ral_field bit_field_0;
    rand rggen_ral_field bit_field_1;
    rand rggen_ral_field bit_field_2;
    function new(string name);
      super.new(name, 32, 0);
    endfunction
    function void build();
      `rggen_ral_create_field(bit_field_0, 0, 4, "RO", 1, 4'h0, '{}, 0, 0, 0, "")
      `rggen_ral_create_field(bit_field_1, 8, 8, "RO", 0, 8'hab, '{}, 1, 0, 0, "")
      `rggen_ral_create_field(bit_field_2, 16, 4, "RO", 1, 4'h0, '{}, 1, 0, 0, "")
    endfunction
  endclass
  class axi_test_reg_block_model extends rggen_ral_block;
    rand register_0_reg_model register_0;
    rand register_1_reg_model register_1;
    rand register_2_reg_model register_2;
    function new(string name);
      super.new(name, 4, 0);
    endfunction
    function void build();
      `rggen_ral_create_reg(register_0, '{}, '{}, 8'h00, "RW", "g_register_0.u_register")
      `rggen_ral_create_reg(register_1, '{}, '{}, 8'h04, "RW", "g_register_1.u_register")
      `rggen_ral_create_reg(register_2, '{}, '{}, 8'h08, "RO", "g_register_2.u_register")
    endfunction
  endclass
endpackage
