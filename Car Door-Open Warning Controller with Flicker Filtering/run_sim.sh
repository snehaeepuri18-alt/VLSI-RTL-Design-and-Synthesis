#!/bin/bash
# usage: ./run_sim.sh rtl   or   ./run_sim.sh gls
GLSDIR=/home/vsduser/OpenSTA/OpenSTA/VSDBabySoC/src/gls_model

case "$1" in
  rtl)
    iverilog -g2012 -s tb_door_warning -o rtl_sim door_warning.v tb_door_warning.v \
      && vvp rtl_sim
    ;;
  gls)
    iverilog -g2012 -DGLS -DFUNCTIONAL -DUNIT_DELAY=#1 -s tb_door_warning -o gls_sim \
      tb_door_warning.v door_warning_net.v $GLSDIR/primitives.v $GLSDIR/sky130_fd_sc_hd.v \
      && vvp gls_sim
    ;;
  *)
    echo "usage: $0 rtl|gls"
    ;;
esac
