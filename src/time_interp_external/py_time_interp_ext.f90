module py_time_interp_ext_mod

  use time_interp_external_mod, only : init_external_field, time_interp_external
  use mpp_io_mod, only : MPP_NETCDF, MPP_MULTI, MPP_SINGLE


  implicit none

  private


  integer, parameter :: max_grids=10
  type(grid1d_t), dimension(0:max_grids), target :: grid

  integer, parameter :: max_ids = 100
  integer, dimension(max_ids) :: ids


  public :: init_field, interp_field

contains


  function init_field(file,fieldname,format)
    character(len=*), intent(in)            :: file,fieldname
    integer, intent(in), optional           :: format

    integer :: n, form

    form=MPP_NETCDF
    if (PRESENT(format)) form=format

    do n=1,max_ids
      if (ids(n)>0) continue
    enddo
    print *,'n=',n

    ids(n)=init_external_field(file,fieldname,form)

    return

  end function init_field




end module py_time_interp_ext_mod
