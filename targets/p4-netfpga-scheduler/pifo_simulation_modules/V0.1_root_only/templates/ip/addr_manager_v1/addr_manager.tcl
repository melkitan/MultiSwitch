#
# Copyright (c) 2015 Noa Zilberman
# All rights reserved.
#
# This software was developed by
# Stanford University and the University of Cambridge Computer Laboratory
# under National Science Foundation under Grant No. CNS-0855268,
# the University of Cambridge Computer Laboratory under EPSRC INTERNET Project EP/H040536/1 and
# by the University of Cambridge Computer Laboratory under DARPA/AFRL contract FA8750-11-C-0249 ("MRC2"), 
# as part of the DARPA MRC research programme.
#
# @NETFPGA_LICENSE_HEADER_START@
#
# Licensed to NetFPGA C.I.C. (NetFPGA) under one or more contributor
# license agreements.  See the NOTICE file distributed with this work for
# additional information regarding copyright ownership.  NetFPGA licenses this
# file to you under the NetFPGA Hardware-Software License, Version 1.0 (the
# "License"); you may not use this file except in compliance with the
# License.  You may obtain a copy of the License at:
#
#   http://www.netfpga-cic.org
#
# Unless required by applicable law or agreed to in writing, Work distributed
# under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations under the License.
#
# @NETFPGA_LICENSE_HEADER_END@
#

# Vivado Launch Script
#### Change design settings here #######
set design addr_manager
set top addr_manager
set device xc7vx690t-3-ffg1761
set proj_dir ./ip_proj
set ip_version 1.00
set lib_name NetFPGA
#####################################
# set IP paths
#####################################
set axi_lite_ipif_ip_path ../../../xilinx/cores/axi_lite_ipif/source/
#####################################
# Project Settings
#####################################
create_project -name ${design} -force -dir "./${proj_dir}" -part ${device} -ip
set_property source_mgmt_mode All [current_project]  
set_property top ${top} [current_fileset]
set_property ip_repo_paths $::env(SUME_FOLDER)/lib/hw/  [current_fileset]
puts "Creating Addr Manager"
# Project Constraints
#####################################
# Project Structure & IP Build
#####################################

# read_verilog "$::env(P4_PROJECT_PIFO_MODULES_DIR)/modules/pifo_calendar_atom_v0_2.v"
read_verilog "./hdl/addr_manager.v"


update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
ipx::package_project

set_property name ${design} [ipx::current_core]
set_property library ${lib_name} [ipx::current_core]
set_property vendor_display_name {KoreaUniv} [ipx::current_core]
set_property company_url {http://www.korea.ac.kr} [ipx::current_core]
set_property vendor {NetFPGA} [ipx::current_core]
set_property supported_families {{virtex7} {Production}} [ipx::current_core]
set_property taxonomy {{/NetFPGA/Generic}} [ipx::current_core]
set_property version ${ip_version} [ipx::current_core]
set_property display_name ${design} [ipx::current_core]
set_property description ${design} [ipx::current_core]
ipx::infer_user_parameters [ipx::current_core]




ipx::add_user_parameter {ADDR_WIDTH} [ipx::current_core]
set_property value_resolve_type {user} [ipx::get_user_parameters ADDR_WIDTH]
set_property display_name {ADDR_WIDTH} [ipx::get_user_parameters ADDR_WIDTH]
set_property value {12} [ipx::get_user_parameters ADDR_WIDTH]
set_property value_format {long} [ipx::get_user_parameters ADDR_WIDTH]

ipx::add_user_parameter {THRESHOLD_ALMOST_FULL} [ipx::current_core]
set_property value_resolve_type {user} [ipx::get_user_parameters THRESHOLD_ALMOST_FULL]
set_property display_name {THRESHOLD_ALMOST_FULL} [ipx::get_user_parameters THRESHOLD_ALMOST_FULL]
set_property value {48} [ipx::get_user_parameters THRESHOLD_ALMOST_FULL]
set_property value_format {long} [ipx::get_user_parameters THRESHOLD_ALMOST_FULL]

ipx::add_user_parameter {ADDR_TABLE_DEPTH} [ipx::current_core]
set_property value_resolve_type {user} [ipx::get_user_parameters ADDR_TABLE_DEPTH]
set_property display_name {ADDR_TABLE_DEPTH} [ipx::get_user_parameters ADDR_TABLE_DEPTH]
set_property value {4096} [ipx::get_user_parameters ADDR_TABLE_DEPTH]
set_property value_format {long} [ipx::get_user_parameters ADDR_TABLE_DEPTH]



# ipx::add_subcore xilinx.com:ip:blk_mem_gen:8.4
ipx::infer_user_parameters [ipx::current_core]


ipx::check_integrity [ipx::current_core]
ipx::save_core [ipx::current_core]
update_ip_catalog
close_project

file delete -force ${proj_dir} 










