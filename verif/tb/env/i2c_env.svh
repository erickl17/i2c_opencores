class i2c_env extends uvm_env;

  `uvm_component_utils(i2c_env)

  wishbone_agent m_wb_agent;
  i2c_env_cfg m_cfg;

  function new (string name = "i2c_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    if (!uvm_config_db #(i2c_env_cfg)::get(this, "", "i2c_env_cfg", m_cfg)) begin
      `uvm_fatal("CONFIG_LOAD", "Cannot get() configuration i2c_env_cfg from uvm_config_db. Have you set() it?")
    end
    m_wb_agent = wishbone_agent::type_id::create("m_wb_agent", this);
    m_wb_agent.m_cfg = m_cfg.m_wb_agent_cfg;
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);

  endfunction : connect_phase
endclass : i2c_env