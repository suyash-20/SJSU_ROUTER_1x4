class r_virtual_seq extends uvm_sequence #(uvm_sequence_item);

    `uvm_object_utils(r_virtual_seq)

    //write and read sequence handles (Testcase wise pairs)
    wr_norm_case_seq wr_seq1;
    no_timeout_seq rd_seq1[];



    //virtual sequencer handles
    r_virtual_seqr v_seqr;

    //write and read sequencer handles
    wr_sequencer wr_seqr;
    rd_sequencer rd_seqr[];

    r_env_config m_cfg;

    extern function new(string name="r_virtual_seq");
    extern task body();

endclass


function r_virtual_seq::new(string name="r_virtual_seq");
    super.new(name);

endfunction

task r_virtual_seq::body();

    if(!uvm_config_db#(r_env_config)::get(null, get_full_name(), "r_env_config", m_cfg))
        `uvm_fatal("Virtual Sequence", "Cannot get the env config, check if it is set")


    rd_seqr = new[m_cfg.no_of_read_agents];

    assert($cast(v_seqr, m_sequencer))
    else begin
        `uvm_fatal("Virtual Sequence", "Sequencer casting failed")
    end

    wr_seqr = v_seqr.wr_seqr;


    foreach(rd_seqr[i])
        rd_seqr[i] = v_seqr.rd_seqr[i];

endtask



//========================= Extended Virtual sequences

//======= 1

class r_normal_vseq extends r_virtual_seq;

    `uvm_object_utils(r_normal_vseq)

    extern function new(string name="r_normal_vseq");
    extern task body();



endclass


function r_normal_vseq::new(string name="r_normal_vseq");
    super.new(name);

endfunction

task r_normal_vseq::body();
    super.body();

    wr_seq1 = wr_norm_case_seq::type_id::create("wr_seq1");

    rd_seq1 = new[m_cfg.no_of_read_agents];

    foreach(rd_seq1[i])
        rd_seq1[i] = no_timeout_seq::type_id::create($sformatf("rd_seq1[%0d]", i));

    fork

        if(m_cfg.has_wagent)
            wr_seq1.start(wr_seqr);

        begin
            if(m_cfg.has_ragent)  begin
                fork
                    rd_seq1[0].start(rd_seqr[0]);
                    rd_seq1[1].start(rd_seqr[1]);
                    rd_seq1[2].start(rd_seqr[2]);
                    rd_seq1[3].start(rd_seqr[3]);

                join_any
            end
        end
    join

endtask







