package test_lib_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import i2c_env_pkg::*;
  import wishbone_agent_pkg::*;

  // Tests
  `include "base_test.svh"
  `include "scratch_test.svh"
endpackage : test_lib_pkg