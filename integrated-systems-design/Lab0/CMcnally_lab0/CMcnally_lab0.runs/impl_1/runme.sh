#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/tools/Xilinx/SDK/2018.3/bin:/tools/Xilinx/Vivado/2018.3/ids_lite/ISE/bin/lin64:/tools/Xilinx/Vivado/2018.3/bin
else
  PATH=/tools/Xilinx/SDK/2018.3/bin:/tools/Xilinx/Vivado/2018.3/ids_lite/ISE/bin/lin64:/tools/Xilinx/Vivado/2018.3/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=/tools/Xilinx/Vivado/2018.3/ids_lite/ISE/lib/lin64
else
  LD_LIBRARY_PATH=/tools/Xilinx/Vivado/2018.3/ids_lite/ISE/lib/lin64:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/home/cmcnally/Documents/Year5/Semester 2/5M9/Labs/Lab0/CMcnally_lab0/CMcnally_lab0.runs/impl_1'
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

# pre-commands:
/bin/touch .write_bitstream.begin.rst
EAStep vivado -log lab0_top.vdi -applog -m64 -product Vivado -messageDb vivado.pb -mode batch -source lab0_top.tcl -notrace

