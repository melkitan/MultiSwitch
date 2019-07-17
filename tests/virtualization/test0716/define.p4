#ifndef _DEFINE_
#define _DEFINE_


#define CONST_NUM_OF_STAGE 0x1f

#define CONST_STAGE_1				1
#define	CONST_STAGE_2				2
#define	CONST_STAGE_3				3
#define	CONST_STAGE_4				4
#define CONST_STAGE_5				5


#define PRIMITIVE_ACTION_ADD_HEDAER                          0
#define PRIMITIVE_ACTION_COPY_HEADER                         1
#define PRIMITIVE_ACTION_REMOVE_HEDAER                       2
#define PRIMITIVE_ACTION_MODIFY_FIELD                        3
#define PRIMITIVE_ACTION_ADD_TO_FIELD                        4
#define PRIMITIVE_ACTION_ADD                                 5
#define PRIMITIVE_ACTION_SUBTRACT_FROM_FIELD                 6
#define PRIMITIVE_ACTION_SUBTRACT                            7
#define PRIMITIVE_ACTION_MODIFY_FIELD_WITH_HASH_BASED_OFFSET 8
#define PRIMITIVE_ACTION_MODIFY_FIELD_RNG_UNIFORM            9
#define PRIMITIVE_ACTION_BIT_AND                             10
#define PRIMITIVE_ACTION_BIT_OR                              11
#define PRIMITIVE_ACTION_BIT_XOR                             12
#define PRIMITIVE_ACTION_SHIFT_LEFT                          13
#define PRIMITIVE_ACTION_SHIFT_RIGHT                         14
#define PRIMITIVE_ACTION_TRUNCATE                            15
#define PRIMITIVE_ACTION_DROP                                16
#define PRIMITIVE_ACTION_NO_OP                               17
#define PRIMITIVE_ACTION_PUSH                                18
#define PRIMITIVE_ACTION_POP                                 19
#define PRIMITIVE_ACTION_COUNT                               20
#define PRIMITIVE_ACTION_EXECUTE_METER                       21
#define PRIMITIVE_ACTION_REGISTER_READ                       22
#define PRIMITIVE_ACTION_REGISTER_WRITE                      23
#define PRIMITIVE_ACTION_GENERATE_DIGEST                     24
#define PRIMITIVE_ACTION_RESUBMIT                            25
#define PRIMITIVE_ACTION_RECIRCULATE                         26
#define PRIMITIVE_ACTION_CLONE_I2I                           27
#define PRIMITIVE_ACTION_CLONE_E2I                           28
#define PRIMITIVE_ACTION_CLONE_I2E                           29
#define PRIMITIVE_ACTION_CLONE_E2E                           30
#define EXTEND_ACTION_MODIFY_HEADER_WITH_CONST               31
#define EXTEND_ACTION_MODIFY_METADATA_WITH_CONST             32
#define EXTEND_ACTION_MODIFY_HEADER_WITH_METADATA            33
#define EXTEND_ACTION_MODIFY_METADATA_WITH_METADATA          34
#define EXTEND_ACTION_MODIFY_HEADER_WITH_HEADER              35
#define EXTEND_ACTION_MODIFY_METADATA_WITH_HEADER            36
#define EXTEND_ACTION_MODIFY_STANDARD_METADATA               37
#define EXTEND_ACTION_HASH                                   38
#define EXTEND_ACTION_PROFILE                                39

// MASK
#define BIT_MASK_MOD_HEADER_WITH_CONST                       (1<<EXTEND_ACTION_MODIFY_HEADER_WITH_CONST)
#define BIT_MASK_MOD_META_WITH_CONST                         (1<<EXTEND_ACTION_MODIFY_METADATA_WITH_CONST)
#define BIT_MASK_MOD_HEADER_WITH_META                        (1<<EXTEND_ACTION_MODIFY_HEADER_WITH_METADATA)
#define BIT_MASK_MOD_META_WITH_META                          (1<<EXTEND_ACTION_MODIFY_METADATA_WITH_METADATA)
#define BIT_MASK_MOD_HEADER_WITH_HEADER                      (1<<EXTEND_ACTION_MODIFY_HEADER_WITH_HEADER)
#define BIT_MASK_MOD_META_WITH_HEADER                        (1<<EXTEND_ACTION_MODIFY_METADATA_WITH_HEADER)
#define BIT_MASK_MOD_STD_META                                (1<<EXTEND_ACTION_MODIFY_STANDARD_METADATA)

#define BIT_MASK_ADD_HEDAER                                  (1<<PRIMITIVE_ACTION_ADD_HEDAER)
#define BIT_MASK_COPY_HEADER                                 (1<<PRIMITIVE_ACTION_COPY_HEADER)
#define BIT_MASK_REMOVE_HEADER                               (1<<PRIMITIVE_ACTION_REMOVE_HEDAER)
#define BIT_MASK_GENERATE_DIGIST                             (1<<PRIMITIVE_ACTION_GENERATE_DIGEST)

#define BIT_MASK_ADD                                         ((1<<PRIMITIVE_ACTION_ADD_TO_FIELD) | (1<<PRIMITIVE_ACTION_ADD))
#define BIT_MASK_SUBTRACT                                    ((1<<PRIMITIVE_ACTION_SUBTRACT_FROM_FIELD) | (1<<PRIMITIVE_ACTION_SUBTRACT))
#define BIT_MASK_REGISTER                                    ((1<<PRIMITIVE_ACTION_REGISTER_READ) | (1<<PRIMITIVE_ACTION_REGISTER_WRITE))
#define BIT_MASK_COUNTER                                     ((1<<PRIMITIVE_ACTION_COUNT))

#define BIT_MASK_DROP                                        (1<<PRIMITIVE_ACTION_DROP)
#define BIT_MASK_BIT_OR                                      (1<<PRIMITIVE_ACTION_BIT_OR)
#define BIT_MASK_BIT_XOR                                     (1<<PRIMITIVE_ACTION_BIT_XOR)
#define BIT_MASK_BIT_AND                                     (1<<PRIMITIVE_ACTION_BIT_AND)
#define BIT_MASK_TRUNCATE                                    (1<<PRIMITIVE_ACTION_TRUNCATE)
#define BIT_MASK_HASH                                        (1<<EXTEND_ACTION_HASH)
#define BIT_MASK_PROFILE                                     (1<<EXTEND_ACTION_PROFILE)

#define BIT_MASK_STD_META     1
#define BIT_MASK_USER_META    2
#define BIT_MASK_HEADER       4

#define USER_META     		meta.user_metadata.meta
#define LOAD_HEADER   		meta.user_metadata.load_header
#define HEADER_LENGTH 		hdr.desc_hdr.len
#define HEADER_FLAG         hdr.desc_hdr.flag
#define POLICY_ID     		meta.vdp_metadata.vdp_id
#define REMOVE_OR_ADD_FLAG 	meta.vdp_metadata.remove_or_add_flag
#define STAGE_ID            meta.vdp_metadata.stage_id
#define PROGRAM_ID  	    meta.vdp_metadata.inst_id
#define MATCH_RESULT 	    meta.vdp_metadata.match_chain_result
#define ACTION_BITMAP 	    meta.vdp_metadata.action_chain_bitmap
#define MOD_FLAG            meta.vdp_metadata.mod_flag
#define ACTION_ID           meta.vdp_metadata.action_chain_id
#define MATCH_BITMAP        meta.vdp_metadata.match_chain_bitmap


#define PROG_ID	  meta.vdp_metadata.inst_id
#define MOD_FLAG  meta.vdp_metadata.mod_flag
#define REMOVE_OR_ADD_HEADER meta.vdp_metadata.remove_or_add_flag



#define CPU_PORT    255
#define DROP_PORT   511

#endif
