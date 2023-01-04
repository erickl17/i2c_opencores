class scratch_test extends base_test;

  `uvm_component_utils(scratch_test)

  function new(string name = "scratch_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    wishbone_rand_seq wb_rand_seq;
    phase.raise_objection(this, "scratch_test");
    `uvm_info({get_name(), "::run_phase"}, "Test is working!!", UVM_HIGH)
    wb_rand_seq = wishbone_rand_seq::type_id::create("wb_rand_seq");
    wb_rand_seq.start(m_env.m_wb_agent.m_sequencer);
    #100ns;
    phase.drop_objection(this, "scratch_test");
  endtask : run_phase
endclass : scratch_test