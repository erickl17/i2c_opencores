class wishbone_monitor extends uvm_monitor;

  `uvm_component_utils(wishbone_monitor)

  local virtual wishbone_if m_vif; // TODO: Does this need to be local?

  wishbone_agent_cfg m_cfg;

  uvm_analysis_port #(wishbone_seq_item) ap;

  function new(string name = "wishbone_monitor", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    if (m_cfg == null) begin
      // TODO: Fix me!
      if (!uvm_config_db #(wishbone_agent_cfg)::get(this, "", "wishbone_agent_cfg", m_cfg)) begin
        `uvm_fatal("CONFIG_LOAD", $sformatf("Cannot get() configuration %s from uvm_config_db. Have you set() it?", "wishbone_agent_cfg"))
      end
    end

    m_vif = m_cfg.vif;

    ap = new("ap", this);
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    wishbone_seq_item item;
    forever begin
      @(posedge m_vif.wb_clk);
      item.address = m_vif.wb_addr;
      if (m_vif.wb_cyc && m_vif.wb_stb && m_vif.wb_ack) begin // TODO: Can I look at only ack?
        if (m_vif.wb_we) begin
          item.access_type = WB_SINGLE_WR;
          item.data_o = m_vif.wb_dat_o;
        end else begin
          item.access_type = WB_SINGLE_RD;
          item.data_i = m_vif.wb_dat_i;
        end
      end
    end
  endtask : run_phase

  function void report_phase(uvm_phase phase);
    // TODO: Might be a good place to do some reporting on no of analysis transactions sent etc
  endfunction : report_phase
endclass : wishbone_monitor