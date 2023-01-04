class wishbone_seq_item extends uvm_sequence_item;

  `uvm_object_utils(wishbone_seq_item)

  // TODO: Add data members
  rand wb_access_type_t access_type;
  rand logic [2:0] address;
  rand logic data_o;

  logic data_i;

  function new(string name = "wishbone_seq_item");
    super.new(name);
  endfunction : new

  function void do_copy(uvm_object rhs);
    wishbone_seq_item rhs_;

    if (!$cast(rhs_, rhs)) begin
      `uvm_fatal("do_copy", "cast of rhs object failed")  // TODO: Put better message
    end

    super.do_copy(rhs);
    access_type = rhs_.access_type;
    address     = rhs_.address;
    data_o      = rhs_.data_o;
    data_i      = rhs_.data_i;
  endfunction : do_copy

  function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    wishbone_seq_item rhs_;

    if (!$cast(rhs_, rhs)) begin
      `uvm_error("do_copy", "cast of rhs object failed")
      return 0;
    end
    return (super.do_compare(rhs, comparer)   &&
            (access_type == rhs_.access_type) &&
            (address     == rhs_.address)     &&
            (data_o      == rhs_.data_o)      &&
            (data_i      == rhs_.data_i));
  endfunction : do_compare

  // TODO: check if this prints nicely
  function string convert2string();
    string s;
    s = super.convert2string();
    s = {s, $sformatf("\n")};
    s = {s, $sformatf("--------------------------------------------------\n")};
    s = {s, $sformatf("Wishbone Sequence Item\n")};
    s = {s, $sformatf("--------------------------------------------------\n")};
    s = {s, $sformatf("%s\n", get_name())};
    s = {s, $sformatf("  access_type:\t %s \n", access_type.name())};
    s = {s, $sformatf("  address:\t 0x%0h \n", address)};
    if (access_type == WB_SINGLE_WR) begin
      s = {s, $sformatf("  data_o:\t 0x%0h \n", data_o)};
    end else if (access_type == WB_SINGLE_RD) begin
      s = {s, $sformatf("  data_i:\t 0x%0h \n", data_i)};
    end
    s = {s, $sformatf("--------------------------------------------------\n")};
    return s;
  endfunction : convert2string

  // Avoid using print() and sprint() for full optimization. Call convert2string instead.
  // TODO: Look at various features of the various uvm_printer policy classes for formatting the data
  function void do_print(uvm_printer printer);
    printer.m_string = convert2string();
  endfunction : do_print

  // TODO: look at how this works in uvm cookbook
  function void do_record(uvm_recorder recorder);
    super.do_record(recorder);

    // TODO: Fix me and do I need this?
    // $add_attribute(recorder.get_handle(), VALUE, NAME);
  endfunction : do_record
endclass : wishbone_seq_item