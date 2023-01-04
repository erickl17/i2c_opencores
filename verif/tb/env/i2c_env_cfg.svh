class i2c_env_cfg extends uvm_object;

  `uvm_object_utils(i2c_env_cfg)

  // TODO: Check which ones I need
  bit has_functional_coverage = 0;
  bit has_i2c_functional_coverage = 1;
  bit has_reg_scoreboard = 0;
  bit has_i2c_scoreboard = 1;

  wishbone_agent_cfg m_wb_agent_cfg;

  function new (string name = "i2c_env_cfg");
    super.new(name);
  endfunction : new

endclass : i2c_env_cfg