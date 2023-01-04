class wishbone_driver extends uvm_driver #(wishbone_seq_item, wishbone_seq_item);

  `uvm_component_utils(wishbone_driver)

  local virtual wishbone_if m_vif;

  wishbone_agent_cfg m_cfg;

  function new(string name = "wishbone_driver", uvm_component parent = null);
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
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    wishbone_seq_item req;
    wishbone_seq_item rsp;

    forever begin
      clear_signals();
      seq_item_port.get_next_item(req);
      drive_req(req);
      seq_item_port.item_done();
    end
  endtask : run_phase

  task clear_signals();
    m_vif.wb_addr <= '0;
    m_vif.wb_dat_o <= '0;
    m_vif.wb_we <= '0;
    m_vif.wb_stb <= '0;
    m_vif.wb_cyc <= '0;
  endtask : clear_signals
  
  task drive_req(wishbone_seq_item req);
    m_vif.wb_addr <= req.address;
    m_vif.wb_cyc <= 1'b1;
    m_vif.wb_stb <= 1'b1;
    case (req.access_type)
      WB_SINGLE_WR : begin
        m_vif.wb_we <= 1'b1;
        m_vif.wb_dat_o <= req.data_o;
        while (!m_vif.wb_ack) begin
          @(posedge m_vif.wb_clk);
        end
      end
      WB_SINGLE_RD : begin
        m_vif.wb_we <= 1'b0;
        while (!m_vif.wb_ack) begin
          @(posedge m_vif.wb_clk);
        end
        req.data_i = m_vif.wb_dat_i;
      end
    endcase
  endtask : drive_req
endclass : wishbone_driver