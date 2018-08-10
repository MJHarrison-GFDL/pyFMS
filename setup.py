"""
==============================

 This work is licensed under the Creative Commons
 Attribution-NonCommercial-ShareAlike 3.0 Unported License.
 To view a copy of this license, visit
 http://creativecommons.org/licenses/by-nc-sa/3.0/
 or send a letter to Creative Commons, 444 Castro Street,
 Suite 900, Mountain View, California, 94041, USA.

===============================
"""
from numpy.distutils.core import setup,Extension

doclines = __doc__.split("\n")


fms_time_interp_ext = Extension(name = 'fms_time_interp_ext',
                include_dirs = ['build_libs'],
                library_dirs = ['build_libs',"$CONDA_PREFIX/lib"],
                libraries = ['fms','netcdf','netcdff'],
                extra_objects = ['build_libs/*.o'],
                sources = ['src/time_interp_external/py_time_interp_ext.f90'])


if __name__ == '__main__':
    from numpy.distutils.core import setup
    setup(name = "pyfms_time_interp_ext",
          version = '0.0.1',
          description = doclines[0],
          long_description = "\n".join(doclines[2:]),
          author = "Matthew Harrison",
          author_email = "matthew.harrison@noaa.gov",
          url = "none",
          license = 'CCL',
          platforms = ["any"],
          packages=['pyfms_time_interp_ext'],
          ext_modules = [fms_time_interp_ext],
          )
