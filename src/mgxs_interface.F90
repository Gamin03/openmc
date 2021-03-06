module mgxs_interface

  use, intrinsic :: ISO_C_BINDING

  use hdf5_interface

  implicit none

  interface

    subroutine add_mgxs_c(file_id, name, energy_groups, delayed_groups, &
         n_temps, temps, tolerance, max_order, legendre_to_tabular, &
         legendre_to_tabular_points, method) bind(C)
      use ISO_C_BINDING
      import HID_T
      implicit none
      integer(HID_T), value, intent(in) :: file_id
      character(kind=C_CHAR),intent(in) :: name(*)
      integer(C_INT), value, intent(in) :: energy_groups
      integer(C_INT), value, intent(in) :: delayed_groups
      integer(C_INT), value, intent(in) :: n_temps
      real(C_DOUBLE),        intent(in) :: temps(1:n_temps)
      real(C_DOUBLE), value, intent(in) :: tolerance
      integer(C_INT), value, intent(in) :: max_order
      logical(C_BOOL),value, intent(in) :: legendre_to_tabular
      integer(C_INT), value, intent(in) :: legendre_to_tabular_points
      integer(C_INT),     intent(inout) :: method
    end subroutine add_mgxs_c

    function query_fissionable_c(n_nuclides, i_nuclides) result(result) bind(C)
      use ISO_C_BINDING
      implicit none
      integer(C_INT), value, intent(in) :: n_nuclides
      integer(C_INT),        intent(in) :: i_nuclides(1:n_nuclides)
      logical(C_BOOL)                   :: result
    end function query_fissionable_c

    subroutine create_macro_xs_c(name, n_nuclides, i_nuclides, n_temps, temps, &
         atom_densities, tolerance, method) bind(C)
      use ISO_C_BINDING
      implicit none
      character(kind=C_CHAR),intent(in) :: name(*)
      integer(C_INT), value, intent(in) :: n_nuclides
      integer(C_INT),        intent(in) :: i_nuclides(1:n_nuclides)
      integer(C_INT), value, intent(in) :: n_temps
      real(C_DOUBLE),        intent(in) :: temps(1:n_temps)
      real(C_DOUBLE),        intent(in) :: atom_densities(1:n_nuclides)
      real(C_DOUBLE), value, intent(in) :: tolerance
      integer(C_INT),     intent(inout) :: method
    end subroutine create_macro_xs_c

    subroutine calculate_xs_c(i_mat, gin, sqrtkT, uvw, total_xs, abs_xs, &
         nu_fiss_xs) bind(C)
      use ISO_C_BINDING
      implicit none
      integer(C_INT), value, intent(in) :: i_mat
      integer(C_INT), value, intent(in) :: gin
      real(C_DOUBLE), value, intent(in) :: sqrtkT
      real(C_DOUBLE),        intent(in) :: uvw(1:3)
      real(C_DOUBLE),     intent(inout) :: total_xs
      real(C_DOUBLE),     intent(inout) :: abs_xs
      real(C_DOUBLE),     intent(inout) :: nu_fiss_xs
    end subroutine calculate_xs_c

    subroutine sample_scatter_c(i_mat, gin, gout, mu, wgt, uvw) bind(C)
      use ISO_C_BINDING
      implicit none
      integer(C_INT), value, intent(in) :: i_mat
      integer(C_INT), value, intent(in) :: gin
      integer(C_INT),     intent(inout) :: gout
      real(C_DOUBLE),     intent(inout) :: mu
      real(C_DOUBLE),     intent(inout) :: wgt
      real(C_DOUBLE),     intent(inout) :: uvw(1:3)
    end subroutine sample_scatter_c

    subroutine sample_fission_energy_c(i_mat, gin, dg, gout) bind(C)
      use ISO_C_BINDING
      implicit none
      integer(C_INT), value, intent(in) :: i_mat
      integer(C_INT), value, intent(in) :: gin
      integer(C_INT),     intent(inout) :: dg
      integer(C_INT),     intent(inout) :: gout
    end subroutine sample_fission_energy_c

    subroutine get_name_c(index, name_len, name) bind(C)
      use ISO_C_BINDING
      implicit none
      integer(C_INT), value,  intent(in)    :: index
      integer(C_INT), value,  intent(in)    :: name_len
      character(kind=C_CHAR), intent(inout) :: name(name_len)
    end subroutine get_name_c

    function get_awr_c(index) result(awr) bind(C)
      use ISO_C_BINDING
      implicit none
      integer(C_INT), value, intent(in) :: index
      real(C_DOUBLE)                    :: awr
    end function get_awr_c

    function get_nuclide_xs_c(index, xstype, gin, gout, mu, dg) result(val) &
         bind(C)
      use ISO_C_BINDING
      implicit none
      integer(C_INT),  value,   intent(in) :: index
      integer(C_INT),  value,   intent(in) :: xstype
      integer(C_INT),  value,   intent(in) :: gin
      integer(C_INT), optional, intent(in) :: gout
      real(C_DOUBLE), optional, intent(in) :: mu
      integer(C_INT), optional, intent(in) :: dg
      real(C_DOUBLE)                       :: val
    end function get_nuclide_xs_c

    function get_macro_xs_c(index, xstype, gin, gout, mu, dg) result(val) &
         bind(C)
      use ISO_C_BINDING
      implicit none
      integer(C_INT),  value,   intent(in) :: index
      integer(C_INT),  value,   intent(in) :: xstype
      integer(C_INT),  value,   intent(in) :: gin
      integer(C_INT), optional, intent(in) :: gout
      real(C_DOUBLE), optional, intent(in) :: mu
      integer(C_INT), optional, intent(in) :: dg
      real(C_DOUBLE)                       :: val
    end function get_macro_xs_c

    subroutine set_nuclide_angle_index_c(index, uvw) bind(C)
      use ISO_C_BINDING
      implicit none
      integer(C_INT), value, intent(in) :: index
      real(C_DOUBLE),        intent(in) :: uvw(1:3)
    end subroutine set_nuclide_angle_index_c

    subroutine set_macro_angle_index_c(index, uvw) bind(C)
      use ISO_C_BINDING
      implicit none
      integer(C_INT), value, intent(in) :: index
      real(C_DOUBLE),        intent(in) :: uvw(1:3)
    end subroutine set_macro_angle_index_c

    subroutine set_nuclide_temperature_index_c(index, sqrtkT) bind(C)
      use ISO_C_BINDING
      implicit none
      integer(C_INT), value, intent(in) :: index
      real(C_DOUBLE), value, intent(in) :: sqrtkT
    end subroutine set_nuclide_temperature_index_c

  end interface

  ! Number of energy groups
  integer(C_INT), bind(C) :: num_energy_groups

  ! Number of delayed groups
  integer(C_INT) :: num_delayed_groups

  ! Energy group structure with decreasing energy
  real(8), allocatable :: energy_bins(:)

  ! Midpoint of the energy group structure
  real(8), allocatable :: energy_bin_avg(:)

  ! Energy group structure with increasing energy
  real(C_DOUBLE), allocatable, target :: rev_energy_bins(:)

contains

  function rev_energy_bins_ptr() result(ptr) bind(C)
    type(C_PTR) :: ptr
    ptr = C_LOC(rev_energy_bins(1))
  end function

end module mgxs_interface
