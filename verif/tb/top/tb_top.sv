module tb_top;

  import uvm_pkg::*;
  import test_lib_pkg::*;

  wishbone_if wb_if();

  i2c_master_top dut (
    .wb_clk_i(),
    .wb_rst_i(),
    .arst_i(),
    .wb_adr_i(),
    .wb_dat_i(),
    .wb_dat_o(),
    .wb_we_i(),
    .wb_stb_i(),
    .wb_cyc_i(),
    .wb_ack_o(),
    .wb_inta_o(),
    .scl_pad_i(),
    .scl_pad_o(),
    .scl_padoen_o(),
    .sda_pad_i(),
    .sda_pad_o(),
    .sda_padoen_o()
  );

  initial begin
    uvm_config_db #(virtual wishbone_if)::set(null, "uvm_test_top", "wb_vif", wb_if);
  end

  initial begin
    run_test();
  end
endmodule : tb_top