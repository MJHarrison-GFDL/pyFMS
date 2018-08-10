#!/bin/bash


(. activate pyFMS;export PREFIX="$CONDA_PREFIX";make -f Makefile_gfortran build_libs/libfms.a)
#(. activate pyFMS;python setup.py config_fc --f90flags="-i4 -r8 -DPY_SOLO" --fcompiler=gfortran \
#          --f90flags="-fcray-pointer -fdefault-real-8 \
#          -ffixed-line-length-132 -ffree-line-length-0 -DPY_SOLO" build;python setup.py install)
