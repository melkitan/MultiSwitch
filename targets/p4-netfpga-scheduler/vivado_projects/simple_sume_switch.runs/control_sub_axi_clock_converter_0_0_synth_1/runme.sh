#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/tools/Xilinx/SDK/2018.2/bin:/tools/Xilinx/Vivado/2018.2/ids_lite/ISE/bin/lin64:/tools/Xilinx/Vivado/2018.2/bin
else
  PATH=/tools/Xilinx/SDK/2018.2/bin:/tools/Xilinx/Vivado/2018.2/ids_lite/ISE/bin/lin64:/tools/Xilinx/Vivado/2018.2/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=/tools/Xilinx/Vivado/2018.2/ids_lite/ISE/lib/lin64
else
  LD_LIBRARY_PATH=/tools/Xilinx/Vivado/2018.2/ids_lite/ISE/lib/lin64:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/home/jkchoi/Documents/git/p4-netfpga-live/contrib-projects/sume-sdnet-switch/projects/switch_calc_pifo/simple_sume_switch/hw/project/simple_sume_switch.runs/control_sub_axi_clock_converter_0_0_synth_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

EAStep vivado -log control_sub_axi_clock_converter_0_0.vds -m64 -product Vivado -mode batch -messageDb vivado.pb -notrace -source control_sub_axi_clock_converter_0_0.tcl
