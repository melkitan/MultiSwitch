/* metatest.p4 is a data plane hypervisor prototype that implemented 
   with idea # 1 (Using Description Header to build explicit header format).
*/

#include <core.p4>
#include <v1model.p4>

#define EXTEND_ACTION_MODIFY_STADARD_METADATA 37
#define BIT_MASK_MOD_STD_META (1<<EXTEND_ACTION_MODIFY_STADARD_METADATA)
#define CONST_NUM_OF_STAGE 0x1f
header description_hdr_t {
    bit<8> flag;
    bit<8> len;
    bit<16> vdp_id;
}
//tcp(160)+ipv4(160)+ethernet(112)
header original_hdr1_t {
    bit<432> hdr1;
}
//ipv4(160)+ethernet(112)
header original_hdr2_t {
    bit<272> hdr2;
}
//ethernet
header hdr1_t {
    bit<112> buf;
}
//ipv4
header hdr2_t {
    bit<160> buf;
}





struct vdp_metadata_t {
    bit<8> inst_id;
    bit<8> stage_id;
    bit<3> match_chain_bitmap;
    bit<48> match_chain_result;
    bit<48> action_chain_bitmap;
    bit<48> action_chain_id;
    bit<3>  table_chain;
}

struct metadata {
    bit<112> load_header1;
    bit<160> load_header2;
    vdp_metadata_t vdp_metadata;
}

struct headers {
    description_hdr_t  desc_hdr;
    original_hdr1_t    ori_hdr1;
    original_hdr2_t    ori_hdr2;
    hdr1_t hdr1;
    hdr2_t hdr2;
    	
}

parser MyParser(packet_in packet,
                out headers hdr,
                inout metadata meta,
                inout standard_metadata_t standard_metadata) {

    state start {
        transition parse_ori1;
    }

  /*  state parse_deschdr {
        packet.extract(hdr.desc_hdr);
        transition select(hdr.desc_hdr.flag) {
            1: parse_ori1;
            2: parse_ori2;
            default: accept;
        }
    }*/

    state parse_ori1 {
        packet.extract(hdr.hdr1);

        transition parse_ori2;
    }

    state parse_ori2 {
        packet.extract(hdr.hdr2);

        transition accept;
    }
}

control MyVerifyChecksum(inout headers hdr, inout metadata meta) {   
    apply {  }
}

control MyIngress(inout headers hdr,
                  inout metadata meta,
                  inout standard_metadata_t standard_metadata) {


    action set_initial_config(bit<8> progid, bit<8> stageid, bit<3> match_bitmap, bit<3> table_chain) {
        meta.vdp_metadata.inst_id = progid; //2
        meta.vdp_metadata.stage_id = stageid;
        meta.vdp_metadata.match_chain_bitmap = match_bitmap;
        meta.vdp_metadata.table_chain = table_chain;        
    }

    table table_config_at_initial {
        key = {
            hdr.desc_hdr.vdp_id: exact;
            meta.vdp_metadata.inst_id: exact;
            meta.vdp_metadata.stage_id: exact;
        }
        actions = {
            set_initial_config;
        }
    }

// match-action 

    action set_stage_and_bitmap(bit<48> action_bitmap, bit<3> match_bitmap, bit<8> next_stage, bit<8> next_prog) {
        meta.vdp_metadata.action_chain_bitmap = action_bitmap;
        meta.vdp_metadata.match_chain_bitmap = match_bitmap;
        meta.vdp_metadata.stage_id = next_stage;
        meta.vdp_metadata.inst_id = next_prog;
        meta.vdp_metadata.action_chain_id = meta.vdp_metadata.match_chain_result;
        meta.vdp_metadata.match_chain_result = 0;
    }
    
    action set_match_result(bit<48> match_result) {
        meta.vdp_metadata.match_chain_result = match_result|meta.vdp_metadata.match_chain_result;
    }
    
    action set_action_id(bit<48> match_result, bit<48> action_bitmap, bit<3> match_bitmap, bit<8> next_stage, bit<8> next_prog) {
        set_match_result(match_result);
        set_stage_and_bitmap(action_bitmap, match_bitmap, next_stage, next_prog);
    }

    action end(bit<8> next_prog) {
        set_action_id(0,0,0,0,next_prog);
    }
    
    table table_header_match_stage1_1 {
        key = {
            meta.vdp_metadata.inst_id: exact;
            meta.vdp_metadata.stage_id: exact;
            hdr.hdr1.buf: ternary; 
        }
        actions = {
            set_action_id;
            end;
        }
    }
     
    table table_header_match_stage1_2 {
        key = {
            meta.vdp_metadata.inst_id: exact;
            meta.vdp_metadata.stage_id: exact;
            hdr.hdr2.buf: ternary; 
        }
        actions = {
            set_action_id;
            end;
        }
    }
    
    table table_std_meta_match_stage1 {
        key = {
            meta.vdp_metadata.inst_id: exact;
            meta.vdp_metadata.stage_id: exact;
            standard_metadata.ingress_port: ternary;
            standard_metadata.egress_spec: ternary;
            standard_metadata.instance_type: ternary;       
        }
        actions = {
            set_action_id;
        }
    }
    
    table table_header_match_stage2 {
        key = {
            meta.vdp_metadata.inst_id: exact;
            meta.vdp_metadata.stage_id: exact;
            hdr.hdr1.buf: ternary; 
        }
        actions = {
            set_action_id;
            end;
        }
    }
    
    table table_std_meta_match_stage2 {
        key = {
            meta.vdp_metadata.inst_id: exact;
            meta.vdp_metadata.stage_id: exact;
            standard_metadata.ingress_port: ternary;
            standard_metadata.egress_spec: ternary;
            standard_metadata.instance_type: ternary;       
        }
        actions = {
            set_action_id;
        }
    }

    table table_header_match_stage3 {
        key = {
            meta.vdp_metadata.inst_id: exact;
            meta.vdp_metadata.stage_id: exact;
            hdr.hdr1.buf: ternary; 
        }
        actions = {
            set_action_id;
            end;
        }
    }
    
    table table_std_meta_match_stage3 {
        key = {
            meta.vdp_metadata.inst_id: exact;
            meta.vdp_metadata.stage_id: exact;
            standard_metadata.ingress_port: ternary;
            standard_metadata.egress_spec: ternary;
            standard_metadata.instance_type: ternary;       
        }
        actions = {
            set_action_id;
        }
    }

    table table_header_match_stage4 {
        key = {
            meta.vdp_metadata.inst_id: exact;
            meta.vdp_metadata.stage_id: exact;
            hdr.hdr1.buf: ternary; 
        }
        actions = {
            set_action_id;
            end;
        }
    }
    
    table table_std_meta_match_stage4 {
        key = {
            meta.vdp_metadata.inst_id: exact;
            meta.vdp_metadata.stage_id: exact;
            standard_metadata.ingress_port: ternary;
            standard_metadata.egress_spec: ternary;
            standard_metadata.instance_type: ternary;       
        }
        actions = {
            set_action_id;
        }
    }
    


    action do_forward(bit<9> port) {
        standard_metadata.egress_spec = port;
    }

    action do_drop() {
        mark_to_drop();
    }

    table table_mod_std_meta_stage1 {
        key = {
            meta.vdp_metadata.action_chain_id: exact;
        }
        actions = {
            do_forward;
            do_drop;
        }
    }
            
    table table_mod_std_meta_stage2 {
        key = {
            meta.vdp_metadata.action_chain_id: exact;
        }
        actions = {
            do_forward;
            do_drop;
        }
    }

    table table_mod_std_meta_stage3 {
        key = {
            meta.vdp_metadata.action_chain_id: exact;
        }
        actions = {
            do_forward;
            do_drop;
        }
    }

    table table_mod_std_meta_stage4 {
        key = {
            meta.vdp_metadata.action_chain_id: exact;
        }
        actions = {
            do_forward;
            do_drop;
        }
    }

    apply {
        table_config_at_initial.apply();
        if ((meta.vdp_metadata.stage_id & CONST_NUM_OF_STAGE) == 1) {
            if (meta.vdp_metadata.match_chain_bitmap&4 != 0) {
		        if(meta.vdp_metadata.table_chain&1 != 0)
                    table_header_match_stage1_1.apply();
 		        else if(meta.vdp_metadata.table_chain&2 != 0)
		            table_header_match_stage1_2.apply();
            }
            if (meta.vdp_metadata.match_chain_bitmap&1 != 0) {
                table_std_meta_match_stage1.apply();
            }
            if (meta.vdp_metadata.action_chain_bitmap != 0) {
                if ((meta.vdp_metadata.action_chain_bitmap & BIT_MASK_MOD_STD_META) != 0) {
                    table_mod_std_meta_stage1.apply();
                }
            }
        }

        if ((meta.vdp_metadata.stage_id & CONST_NUM_OF_STAGE) == 2) {
            if (meta.vdp_metadata.match_chain_bitmap&4 != 0) {
                table_header_match_stage2.apply();
            }
            if (meta.vdp_metadata.match_chain_bitmap&1 != 0) {
                table_std_meta_match_stage2.apply();
            }
            if (meta.vdp_metadata.action_chain_bitmap != 0) {
                if ((meta.vdp_metadata.action_chain_bitmap & BIT_MASK_MOD_STD_META) != 0) {
                    table_mod_std_meta_stage2.apply();
                }
            }
        }

        if ((meta.vdp_metadata.stage_id & CONST_NUM_OF_STAGE) == 3) {
            if (meta.vdp_metadata.match_chain_bitmap&4 != 0) {
                table_header_match_stage3.apply();
            }
            if (meta.vdp_metadata.match_chain_bitmap&1 != 0) {
                table_std_meta_match_stage3.apply();
            }
            if (meta.vdp_metadata.action_chain_bitmap != 0) {
                if ((meta.vdp_metadata.action_chain_bitmap & BIT_MASK_MOD_STD_META) != 0) {
                    table_mod_std_meta_stage3.apply();
                }
            }
        }

        if ((meta.vdp_metadata.stage_id & CONST_NUM_OF_STAGE) == 4) {
            if (meta.vdp_metadata.match_chain_bitmap&4 != 0) {
                table_header_match_stage4.apply();
            }
            if (meta.vdp_metadata.match_chain_bitmap&1 != 0) {
                table_std_meta_match_stage4.apply();
            }
            if (meta.vdp_metadata.action_chain_bitmap != 0) {
                if ((meta.vdp_metadata.action_chain_bitmap & BIT_MASK_MOD_STD_META) != 0) {
                    table_mod_std_meta_stage4.apply();
                }
            }
        }
    }
}


control MyEgress(inout headers hdr,
                 inout metadata meta,
                 inout standard_metadata_t standard_metadata) {
    apply { 
        
    }
}

control MyComputeChecksum(inout headers  hdr, inout metadata meta) {
     apply {
    }
}

control MyDeparser(packet_out packet, in headers hdr) {
    apply {
        packet.emit(hdr.desc_hdr);
        packet.emit(hdr.ori_hdr1);
        packet.emit(hdr.ori_hdr2);
    }
}

V1Switch(
MyParser(),
MyVerifyChecksum(),
MyIngress(),
MyEgress(),
MyComputeChecksum(),
MyDeparser()
) main;
