# In SageMath, while there is no native bellman_ford method built directly into the Graph class (which primarily uses Dijkstra's algorithm for shortest paths), 
# You can implement it using Sage's graph data structures and methods.
# The Bellman-Ford algorithm finds the shortest path from a single source to all other vertices in a weighted graph, even with negative edge weights, and can detect negative cycles.


def bellman_ford_sage(G, source):
    """
    Computes shortest paths from source using Bellman-Ford in SageMath.
    Returns: A dictionary of distances and a dictionary of predecessors.
    """
    # 1. Initialization
    vertices = G.vertices()
    dist = {v: infinity for v in vertices}
    prev = {v: None for v in vertices}
    dist[source] = 0
    
    # Get all edges: (u, v, weight)
    edges = G.edges()
    
    # 2. Relax edges |V| - 1 times
    for _ in range(len(vertices) - 1):
        for u, v, w in edges:
            # Sage graphs can be undirected; relax both directions if needed
            # For directed graphs (DiGraph), only u -> v is relaxed
            if dist[u] + w < dist[v]:
                dist[v] = dist[u] + w
                prev[v] = u
            if not G.is_directed(): # Handle undirected edges
                if dist[v] + w < dist[u]:
                    dist[u] = dist[v] + w
                    prev[u] = v

    # 3. Check for negative weight cycles
    for u, v, w in edges:
        if dist[u] + w < dist[v]:
            raise ValueError("Graph contains a negative weight cycle")
            
    return dist, prev

# Example usage:
G = DiGraph([(0, 1, 5), (0, 2, 8), (1, 2, -10), (1, 3, 2), (2, 3, 6)], weighted=True)
distances, predecessors = bellman_ford_sage(G, 0)
print(f"Distances from source 0: {distances}")
