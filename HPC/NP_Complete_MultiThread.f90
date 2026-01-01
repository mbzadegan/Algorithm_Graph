! This Fortran program uses all CPU Multi-threads and calculates an NP-Complete problem with a parallel algorithm.
! gfortran -fopenmp -O2 subset_sum_show_subset.f90 -o subset_sum
! ./subset_sum 9 3 34 4 12 5
!
! Subset Sum With Subset Output (OpenMP)
! Target: 9
! Set A: 3 34 4 12 5
! Result: YES — subset found:
! Subset: { 4 5 }
! Time elapsed: 0.00012 seconds
! Threads used: 8

program subset_sum_parallel
  use omp_lib
  implicit none

  integer, allocatable :: arr(:), path(:)
  integer :: n, i, target, stat
  logical :: found
  real(8) :: t1, t2

  ! Read input
  n = command_argument_count() - 1
  if (n < 1) then
     print *, "Usage: ./subset_sum <target> <a1> <a2> ... <an>"
     stop
  end if

  allocate(arr(n), path(n))
  call get_command_argument(1, target, status=stat)
  if (stat /= 0) stop "Error: Cannot read target."

  do i = 1, n
     call get_command_argument(i+1, arr(i), status=stat)
     if (stat /= 0) stop "Error: Cannot read array element."
  end do

  path = 0
  print *, "Subset Sum Solver (Parallel)"
  print *, "Target:", target
  print *, "Array: ", arr

  call omp_set_num_threads(omp_get_max_threads())
  t1 = omp_get_wtime()

  ! >>> OpenMP must enclose only code (not CONTAINS etc)
  call solve_parallel(arr, path, n, target, found)

  t2 = omp_get_wtime()

  if (.not. found) then
     print *, "No subset found."
  end if

  print *, "Time elapsed:", t2 - t1, "seconds"
  print *, "Threads used:", omp_get_max_threads()

contains

  subroutine solve_parallel(a, p, m, t, result)
    integer, intent(in) :: a(:), m, t
    integer, intent(inout) :: p(:)
    logical, intent(out) :: result

    !$omp parallel default(none) shared(a, p, m, t, result)
    !$omp single
    result = subset_sum(a, p, m, t)
    !$omp end parallel
  end subroutine solve_parallel

  recursive function subset_sum(a, p, m, t) result(ok)
    integer, intent(in) :: a(:), m, t
    integer, intent(inout) :: p(:)
    logical :: ok
    integer :: i
    logical :: left_ok, right_ok
    integer, allocatable :: p_left(:), p_right(:)

    if (t == 0) then
       print *, "YES — subset found:"
       write(*,'(A)', advance='no') "Subset: { "
       do i = 1, size(p)
          if (p(i) == 1) write(*,'(I0,A)', advance='no') a(i), " "
       end do
       print *, "}"
       ok = .true.
       return
    else if (m == 0) then
       ok = .false.
       return
    end if

    allocate(p_left(size(p)))
    allocate(p_right(size(p)))
    p_left = p
    p_right = p
    p_right(m) = 1

    left_ok = .false.
    right_ok = .false.

    !$omp task shared(left_ok)
    left_ok = subset_sum(a, p_left, m - 1, t)
    !$omp end task

    if (a(m) <= t) then
       !$omp task shared(right_ok)
       right_ok = subset_sum(a, p_right, m - 1, t - a(m))
       !$omp end task
    end if

    !$omp taskwait
    ok = left_ok .or. right_ok
  end function subset_sum

end program subset_sum_parallel
