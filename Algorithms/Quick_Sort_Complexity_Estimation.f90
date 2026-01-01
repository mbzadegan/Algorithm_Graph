!===========================================================
! QuickSort Algorithm with Empirical Complexity Measurement
! Language: Fortran 90+
! gfortran Quick_Sort_Complexity_Estimation.f90 -o quicksort
! ./quicksort
!===========================================================

program quicksort_complexity
    implicit none
    integer :: n, i
    real :: start_time, end_time, elapsed_time
    real :: theo_complexity, ratio
    integer, allocatable :: arr(:)
    integer(kind=8) :: comparisons, swaps

    comparisons = 0
    swaps = 0

    print *, "Enter number of elements:"
    read(*,*) n
    allocate(arr(n))

    print *, "Enter ", n, " integers:"
    read(*,*) arr

    call cpu_time(start_time)
    call quicksort(arr, 1, n, comparisons, swaps)
    call cpu_time(end_time)

    elapsed_time = end_time - start_time
    theo_complexity = n * log(real(n)) / log(2.0)
    ratio = real(comparisons) / theo_complexity

    print *, ""
    print *, "Sorted array:"
    do i = 1, n
        write(*,'(I8)', advance='no') arr(i)
    end do
    print *, ""

    print *, ""
    print *, "=== QuickSort Complexity Report ==="
    print *, "Number of elements (n): ", n
    print *, "Comparisons: ", comparisons
    print *, "Swaps: ", swaps
    print *, "Execution time (sec): ", elapsed_time
    print *, "Estimated O(n log n): ", theo_complexity
    print *, "Empirical ratio (comparisons / n log n): ", ratio

    deallocate(arr)
end program quicksort_complexity

!===========================================================
contains
!===========================================================

recursive subroutine quicksort(arr, low, high, comparisons, swaps)
    implicit none
    integer, intent(inout) :: arr(:)
    integer, intent(in) :: low, high
    integer(kind=8), intent(inout) :: comparisons, swaps
    integer :: pivot_index

    if (low < high) then
        call partition(arr, low, high, pivot_index, comparisons, swaps)
        call quicksort(arr, low, pivot_index - 1, comparisons, swaps)
        call quicksort(arr, pivot_index + 1, high, comparisons, swaps)
    end if
end subroutine quicksort

!-----------------------------------------------------------
subroutine partition(arr, low, high, pivot_index, comparisons, swaps)
    implicit none
    integer, intent(inout) :: arr(:)
    integer, intent(in) :: low, high
    integer, intent(out) :: pivot_index
    integer(kind=8), intent(inout) :: comparisons, swaps

    integer :: pivot, i, j, temp

    pivot = arr(high)
    i = low - 1

    do j = low, high - 1
        comparisons = comparisons + 1
        if (arr(j) <= pivot) then
            i = i + 1
            call swap(arr(i), arr(j), swaps)
        end if
    end do
    call swap(arr(i + 1), arr(high), swaps)
    pivot_index = i + 1
end subroutine partition

!-----------------------------------------------------------
subroutine swap(a, b, swaps)
    implicit none
    integer, intent(inout) :: a, b
    integer(kind=8), intent(inout) :: swaps
    integer :: temp

    temp = a
    a = b
    b = temp
    swaps = swaps + 1
end subroutine swap
!===========================================================
