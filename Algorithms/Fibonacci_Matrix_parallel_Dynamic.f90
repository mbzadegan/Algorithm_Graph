!================================================================
! Parallel Fibonacci via Matrix Exponentiation (OpenMP)
! Computes F(n) by raising matrix M = [[1,1],[1,0]] to the power n
! and returning element (1,2). Uses binary exponentiation (O(log n))
! Parallelization: OpenMP tasks for recursive exponentiation and
! OpenMP parallel do for small 2x2 multiplication (demonstration).
! gfortran -fopenmp Fibonacci_Matrix_parallel_Dynamic.f90 -o fib_omp
!================================================================
program fib_matrix_omp
    use omp_lib
    implicit none
    integer(kind=8) :: n
    integer(kind=8), dimension(2,2) :: M, R
    real :: t0, t1
    integer :: threads

    print *, "Parallel Matrix-Exponentiation Fibonacci (OpenMP)"
    print *, "Enter n (0 <= n <= 92 recommended for 64-bit result):"
    read *, n
    if (n < 0) then
        print *, "n must be non-negative"
        stop
    end if

    ! Base matrix
    M = reshape([1_8,1_8, 1_8,0_8], [2,2])

    call cpu_time(t0)
    call matrix_power(M, n, R)
    call cpu_time(t1)

    print *
    print *, "F(", n, ") = ", R(1,2)
    print *, "Elapsed time (s): ", t1 - t0

contains

    recursive subroutine matrix_power(A, exp, Out)
        integer(kind=8), intent(in) :: A(2,2)
        integer(kind=8), intent(in) :: exp
        integer(kind=8), intent(out) :: Out(2,2)
        integer(kind=8) :: half(2,2), tmp(2,2)
        integer :: i

        if (exp == 0) then
            ! Identity matrix
            Out = 0_8
            Out(1,1) = 1_8
            Out(2,2) = 1_8
            return
        else if (exp == 1) then
            Out = A
            return
        end if

        ! compute half = A^(exp/2) possibly in parallel
        !$omp task shared(A,exp,half) if(exp > 1)
        call matrix_power(A, exp/2, half)
        !$omp end task

        !$omp taskwait

        ! tmp = half * half
        call mat_mul(half, half, tmp)

        if (mod(exp,2) == 0) then
            Out = tmp
        else
            ! Out = A * tmp
            call mat_mul(A, tmp, Out)
        end if
    end subroutine matrix_power

    subroutine mat_mul(X, Y, Z)
        integer(kind=8), intent(in) :: X(2,2), Y(2,2)
        integer(kind=8), intent(out) :: Z(2,2)
        integer :: i, j, k
        integer(kind=8) :: sum
        Z = 0_8

        ! Small fixed-size multiply; parallelize the outer loops for demo.
        !$omp parallel do private(i,j,k,sum) collapse(2)
        do i = 1, 2
            do j = 1, 2
                sum = 0_8
                do k = 1, 2
                    sum = sum + X(i,k) * Y(k,j)
                end do
                Z(i,j) = sum
            end do
        end do
        !$omp end parallel do
    end subroutine mat_mul

end program fib_matrix_omp
