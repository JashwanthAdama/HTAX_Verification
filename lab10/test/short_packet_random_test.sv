///////////////////////////////////////////////////////////////////////////
// Texas A&M University
// CSCE 616 Hardware Design Verification
// Created by  : Prof. Quinn and Saumil Gogri
///////////////////////////////////////////////////////////////////////////


class short_packet_random_test extends base_test;

	`uvm_component_utils(short_packet_random_test)

	function new (string name, uvm_component parent);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		uvm_config_wrapper::set(this,"tb.vsequencer.run_phase", "default_sequence", short_packet_random_vsequence::type_id::get());
		super.build_phase(phase);
	endfunction : build_phase

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info(get_type_name(),"Starting short packet random test",UVM_NONE)
	endtask : run_phase

endclass : short_packet_random_test



///////////////////////////// VIRTUAL SEQUENCE ///////////////////////////


class short_packet_random_vsequence extends htax_base_vseq;

  `uvm_object_utils(short_packet_random_vsequence)
	
  htax_packet_c packet0, packet1, packet2, packet3;


  rand int length;

  function new (string name = "short_packet_random_vsequence");
    super.new(name);
    packet0 = new();
    packet1 = new();
    packet2 = new();
    packet3 = new();

  endfunction : new

  task body();
		// Exectuing 10 TXNs on ports {0,1,2,3} randomly 
    repeat(100) begin
	fork
    //  `uvm_do_on(req, p_sequencer.htax_seqr[port])

			//USE `uvm_do_on_with to add constraints on req
	 `uvm_do_on_with(packet0, p_sequencer.htax_seqr[0], {packet0.length inside {[3:10]} ;packet0.delay > 5; }) ;
	 `uvm_do_on_with(packet1, p_sequencer.htax_seqr[1], {packet1.length inside {[3:10]} ;packet1.delay > 5; }) ;
	 `uvm_do_on_with(packet2, p_sequencer.htax_seqr[2], {packet2.length inside {[3:10]} ;packet2.delay > 5; }) ;
	 `uvm_do_on_with(packet3, p_sequencer.htax_seqr[3], {packet3.length inside {[3:10]} ;packet3.delay > 5; }) ;
	join
    end
  endtask : body

endclass : short_packet_random_vsequence
