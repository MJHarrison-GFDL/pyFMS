#!/bin/csh -v

set workdir = $cwd
set root = $cwd:h
set platform = linux
########################set platform = gfdl_hpcs


set maledir=$root/src
echo $maledir

set sharedir     = $root/fms/FMS
set includedir   = $sharedir/{include,mosaic}
set sysincludedir = $CONDA_PREFIX/include
set mppincludedir   = $sharedir/mpp/include
set mkmfTemplate = $root/mkmf/templates/linux-gnu.mk
set npes = 1
set cppDefs      = ("-Duse_netCDF -Duse_netCDF3 -DMAXXGRID=2.e7 -DnoFort2003" )
set MKMF         = $root/fms/bin/mkmf
set LISTPATHS    = $root/fms/bin/list_paths


if ($platform == 'gfdl_hpcs') then
  module load netcdf/4.2
  module load intel_compilers
endif

echo "CONDA_PREFIX=" $CONDA_PREFIX
echo "includedir=" $includedir
echo "sysincludedir=" $sysincludedir
echo "mppincludedir=" $mppincludedir

\rm *.{o,mod}
\rm path_names*
$LISTPATHS $maledir $sharedir
mv -f path_names pt_orig
#egrep -v "atmos_ocean_fluxes|coupler_types|coupler_util|drifters|oda_tools" pt_orig > path_names
egrep "FMS/fms|FMS/mpp|FMS/horiz_interp|FMS/platform|FMS/constants|FMS/memutils|FMS/mosaic|FMS/time_interp|FMS/time_interp_external" pt_orig > path_names


$MKMF -m Makefile -a $workdir  -t $mkmfTemplate -p libfms.a -c "$cppDefs"  path_names  $includedir $mppincludedir $sysincludedir

make DEBUG=1 libfms.a


if ( $status ) then
    unset echo
    echo ERROR: make failed.
    exit 1
else
    unset echo
    echo NOTE: make succeeded.
endif
