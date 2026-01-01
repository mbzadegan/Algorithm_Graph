! Below is a complete Fortran program that demonstrates solving a single shortest-path problem using both Dijkstra and Bellman-Ford on the same weighted directed graph.
!
! The program:
!
! Defines a weighted graph with six vertices and several edges (including a negative edge, but no negative cycles).
! Runs both algorithms from the same source vertex (vertex 1).
! Prints the shortest path distances found by each algorithm.
! Allows comparison of results.


program shortest_path_comparison
    implicit none
    integer, parameter :: n = 6           ! number of vertices
    integer, parameter :: m = 9           ! number of edges
    integer :: i, j, u, v, k
    real :: w

    ! Graph edges (u, v, weight)
    integer :: edge_u(m) = [1,1,2,2,3,3,4,5,2]
    integer :: edge_v(m) = [2,3,3,4,4,5,6,6,4]
    real    :: edge_w(m) = [5.0,3.0,2.0,6.0,7.0,4.0,-1.0,2.0,8.0]

    real :: distD(n), distB(n)
    logical :: visited(n)

    integer :: source
    source = 1

    ! ============================================================
    ! Initialize distances
    ! ============================================================
    distD = 1.0e9
    distB = 1.0e9
    visited = .false.

    distD(source) = 0.0
    distB(source) = 0.0

    ! ============================================================
    !  D I J K S T R A  A L G O R I T H M
    ! ============================================================
    do i = 1, n
        real :: minDist
        integer :: current

        minDist = 1.0e9
        current = -1

        ! Select an unvisited node with the smallest distance
        do j = 1, n
            if (.not. visited(j) .and. distD(j) < minDist) then
                minDist = distD(j)
                current = j
            end if
        end do

        if (current == -1) exit
        visited(current) = .true.

        ! Relax outgoing edges
        do k = 1, m
            if (edge_u(k) == current) then
                u = edge_u(k)
                v = edge_v(k)
                w = edge_w(k)
                if (distD(u) + w < distD(v)) then
                    distD(v) = distD(u) + w
                end if
            end if
        end do
    end do

    ! ============================================================
    !  B E L L M A N – F O R D  A L G O R I T H M
    ! ============================================================
    do i = 1, n-1
        do k = 1, m
            u = edge_u(k)
            v = edge_v(k)
            w = edge_w(k)
            if (distB(u) + w < distB(v)) then
                distB(v) = distB(u) + w
            end if
        end do
    end do

    ! ============================================================
    !  O U T P U T  R E S U L T S
    ! ============================================================
    print *, "======================================================="
    print *, "Shortest Paths from Source Vertex = ", source
    print *, "======================================================="
    print *, ""
    print *, "Vertex    Dijkstra     Bellman-Ford"
    print *, "---------------------------------------"

    do i = 1, n
        print '(I3, 6X, F10.2, 6X, F10.2)', i, distD(i), distB(i)
    end do

end program shortest_path_comparison
