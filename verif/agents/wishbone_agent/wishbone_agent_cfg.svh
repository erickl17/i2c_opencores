class wishbone_agent_cfg extends uvm_object;

  `uvm_object_utils(wishbone_agent_cfg)

  virtual wishbone_if vif;

  uvm_active_passive_enum active = UVM_ACTIVE;
  bit has_functional_coverage = 0;

  function new(string name = "wishbone_agent_cfg");
    super.new(name);
  endfunction : new

  // TODO: Do I need this?
  function wishbone_agent_cfg get_cfg(uvm_component c);
    wishbone_agent_cfg t;

    if (!uvm_config_db #(wishbone_agent_cfg)::get(c, "", "wishbone_agent_cfg", t)) begin
      `uvm_fatal("CONFIG_LOAD", $sformatf("Cannot get() configuration %s from uvm_config_db. Have you set() it?", "wishbone_agent_cfg"))
    end
  endfunction : get_cfg
endclass : wishbone_agent_cfg