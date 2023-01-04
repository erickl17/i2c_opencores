class wishbone_write_seq extends uvm_sequence #(wishbone_seq_item);

  `uvm_object_utils(wishbone_write_seq)

  rand logic [2:0] address;
  rand logic data_o;

  function new(string name = "wishbone_write_seq");
    super.new(name);
  endfunction : new

  task body();
    wishbone_seq_item req = wishbone_seq_item::type_id::create("req");

    start_item(req);
    if (!req.randomize() with {access_type == WB_SINGLE_WR; address == local::address; data_o == local::data_o;}) begin
      `uvm_error("body", "req randomization failure")
    end
    finish_item(req);
  endtask : body
endclass : wishbone_write_seq

class wishbone_read_seq extends uvm_sequence #(wishbone_seq_item);

  `uvm_object_utils(wishbone_read_seq)

  rand logic [2:0] address;

  function new(string name = "wishbone_read_seq");
    super.new(name);
  endfunction : new

  task body();
    wishbone_seq_item req = wishbone_seq_item::type_id::create("req");

    start_item(req);
    if (!req.randomize() with {access_type == WB_SINGLE_RD; address == local::address;}) begin
      `uvm_error("body", "req randomization failure")
    end
    finish_item(req);
  endtask : body
endclass : wishbone_read_seq

class wishbone_rand_seq extends uvm_sequence #(wishbone_seq_item);

  `uvm_object_utils(wishbone_rand_seq)

  function new(string name = "wishbone_rand_seq");
    super.new(name);
  endfunction : new

  task body();
    wishbone_seq_item req = wishbone_seq_item::type_id::create("req");

    start_item(req);
    if (!req.randomize()) begin
      `uvm_error("body", "req randomization failure")
    end
    finish_item(req);
  endtask : body
endclass : wishbone_rand_seq
