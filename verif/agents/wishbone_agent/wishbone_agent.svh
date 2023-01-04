class wishbone_agent extends uvm_agent;

  `uvm_component_utils(wishbone_agent)

  wishbone_agent_cfg m_cfg;

  uvm_analysis_port #(wishbone_seq_item) ap;
  wishbone_monitor m_monitor;
  wishbone_driver  m_driver;
  wishbone_sequencer m_sequencer;

  function new(string name = "wishbone_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    if (m_cfg == null) begin
      // TODO: Fix me!
      if (!uvm_config_db #(wishbone_agent_cfg)::get(this, "", "wishbone_agent_cfg", m_cfg)) begin
        `uvm_fatal("CONFIG_LOAD", $sformatf("Cannot get() configuration %s from uvm_config_db. Have you set() it?", "wishbone_agent_cfg"))
      end
    end

    m_monitor = wishbone_monitor::type_id::create("m_monitor", this);
    m_monitor.m_cfg = m_cfg;

    if (m_cfg.active == UVM_ACTIVE) begin
      m_driver = wishbone_driver::type_id::create("m_driver", this);
      m_driver.m_cfg = m_cfg;
      m_sequencer = wishbone_sequencer::type_id::create("m_sequencer", this);
    end
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    ap = m_monitor.ap;

    if (m_cfg.active == UVM_ACTIVE) begin
      m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
    end
  endfunction : connect_phase

endclass : wishbone_agent