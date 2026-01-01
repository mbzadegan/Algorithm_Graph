! Dijkstra's Algorithm (Single-Source Shortest Path)
! From CLRS Chapter 24.3
! Author: Mohammad

program dijkstra
    implicit none
    integer, parameter :: n = 6
    integer :: i, j, u, v, minDist
    integer, parameter :: INF = 99999
    integer :: graph(n, n)
    integer :: dist(n)
    logical :: visited(n)

    ! Example graph (adjacency matrix)
    ! 0 means no direct edge
    graph = reshape([ &
        0, 7, 9, 0, 0, 14, &
        7, 0, 10, 15, 0, 0, &
        9, 10, 0, 11, 0, 2, &
        0, 15, 11, 0, 6, 0, &
        0, 0, 0, 6, 0, 9, &
        14, 0, 2, 0, 9, 0 &
    ], shape(graph))

    call dijkstra_shortest_path(graph, n, 1)

contains

    subroutine dijkstra_shortest_path(graph, n, src)
        integer, intent(in) :: n, src
        integer, intent(in) :: graph(n,n)
        integer :: dist(n), i, j, u, minDist
        logical :: visited(n)

        ! Initialize distances and visited array
        do i = 1, n
            dist(i) = INF
            visited(i) = .false.
        end do
        dist(src) = 0

        ! Main Dijkstra loop
        do i = 1, n - 1
            u = min_distance(dist, visited, n)
            visited(u) = .true.

            do j = 1, n
                if (.not. visited(j) .and. graph(u,j) /= 0 .and. dist(u) + graph(u,j) < dist(j)) then
                    dist(j) = dist(u) + graph(u,j)
                end if
            end do
        end do

        ! Print shortest distances
        print *, "Vertex   Distance from Source (", src, "):"
        do i = 1, n
            if (dist(i) == INF) then
                print '(I3, 5X, A)', i, "INF"
            else
                print '(I3, 5X, I5)', i, dist(i)
            end if
        end do
    end subroutine dijkstra_shortest_path


    function min_distance(dist, visited, n) result(min_index)
        integer, intent(in) :: dist(n)
        logical, intent(in) :: visited(n)
        integer, intent(in) :: n
        integer :: min_index, i
        integer :: minDist

        minDist = INF
        min_index = 1

        do i = 1, n
            if (.not. visited(i) .and. dist(i) <= minDist) then
                minDist = dist(i)
                min_index = i
            end if
        end do
    end function min_distance

end program dijkstra
