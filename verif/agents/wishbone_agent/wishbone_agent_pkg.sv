package wishbone_agent_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  typedef enum {WB_SINGLE_WR, WB_SINGLE_RD} wb_access_type_t;

  `include "wishbone_seq_item.svh"
  `include "wishbone_agent_cfg.svh"
  `include "wishbone_monitor.svh"
  `include "wishbone_driver.svh"
  typedef uvm_sequencer #(wishbone_seq_item) wishbone_sequencer;
  `include "wishbone_agent.svh"

  // Reg Adapter for UVM Register Model


  // Utility Sequences
  `include "wishbone_seq_lib.svh"

endpackage : wishbone_agent_pkg