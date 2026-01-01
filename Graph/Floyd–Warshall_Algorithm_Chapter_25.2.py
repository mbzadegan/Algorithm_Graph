# Given a directed graph G=(V,E) with edge weights (which may be negative, but no negative cycles), compute the shortest paths between every pair of vertices.


def floyd_warshall(weights):
    """
    Floyd-Warshall algorithm for all-pairs shortest paths.
    weights: adjacency matrix (2D list), where
        weights[i][j] = edge weight from i to j,
        or float('inf') if no edge exists.
    Returns distance matrix and predecessor matrix.
    """
    n = len(weights)
    dist = [row[:] for row in weights]  # copy of weights
    pred = [[None if weights[i][j] == float("inf") else i
             for j in range(n)] for i in range(n)]

    for k in range(n):
        for i in range(n):
            for j in range(n):
                if dist[i][k] + dist[k][j] < dist[i][j]:
                    dist[i][j] = dist[i][k] + dist[k][j]
                    pred[i][j] = pred[k][j]

    return dist, pred


def reconstruct_path(pred, i, j):
    """Reconstruct shortest path from i to j using predecessor matrix."""
    if pred[i][j] is None:
        return []
    path = [j]
    while j != i:
        j = pred[i][j]
        path.append(j)
    return path[::-1]


# Example: Graph with 4 vertices
INF = float("inf")
weights = [
    [0,   3,   INF, 5],
    [2,   0,   INF, 4],
    [INF, 1,   0,   INF],
    [INF, INF, 2,   0]
]

dist, pred = floyd_warshall(weights)

print("Shortest distance matrix:")
for row in dist:
    print(row)

print("\nExample shortest path from 0 → 2:")
print(reconstruct_path(pred, 0, 2))
