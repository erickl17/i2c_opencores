class base_test extends uvm_test;

  `uvm_component_utils(base_test)

  i2c_env m_env;

  i2c_env_cfg m_env_cfg;
  wishbone_agent_cfg m_wb_cfg;

  function new (string name = "base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    m_env_cfg = i2c_env_cfg::type_id::create("m_env_cfg");

    // // Enable all types of coverage available in the register model
    // uvm_reg::include_coverage("*", UVM_CVR_ALL);

    m_wb_cfg = wishbone_agent_cfg::type_id::create("m_wb_cfg");
    configure_wb_agent();
    if (!uvm_config_db #(virtual wishbone_if)::get(this, "", "wb_vif", m_wb_cfg.vif)) begin
      `uvm_fatal("VIF CONFIG", "Cannot get() virtual interface wb_vif from uvm_config_db. Have you set() it?")
    end
    m_env_cfg.m_wb_agent_cfg = m_wb_cfg;

    uvm_config_db #(i2c_env_cfg)::set(this, "*", "i2c_env_cfg", m_env_cfg);
    m_env = i2c_env::type_id::create("m_env", this);
  endfunction : build_phase

  function void configure_wb_agent();
    m_wb_cfg.active = UVM_ACTIVE;
    m_wb_cfg.has_functional_coverage = 0;
  endfunction : configure_wb_agent

endclass : base_test