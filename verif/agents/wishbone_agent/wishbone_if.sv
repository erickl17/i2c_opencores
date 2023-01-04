interface wishbone_if;

  logic       wb_clk;
  logic       wb_rst;
  logic [2:0] wb_addr;
  logic [7:0] wb_dat_o;
  logic [7:0] wb_dat_i;
  logic       wb_we;
  logic       wb_stb;
  logic       wb_cyc;
  logic       wb_ack;
  logic       wb_inta;

endinterface : wishbone_if