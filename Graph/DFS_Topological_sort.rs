// Topological Sort using DFS
// From CLRS Chapter 22.4
// Given a directed acyclic graph (DAG), produce a topological ordering of its vertices.
// That is, order all vertices such that for every directed edge.

use std::collections::HashMap;

fn dfs(
    v: usize,
    graph: &HashMap<usize, Vec<usize>>,
    visited: &mut Vec<bool>,
    stack: &mut Vec<usize>,
) {
    visited[v] = true;

    if let Some(neighbors) = graph.get(&v) {
        for &u in neighbors {
            if !visited[u] {
                dfs(u, graph, visited, stack);
            }
        }
    }

    // When all descendants are visited, push to stack
    stack.push(v);
}

fn topological_sort(graph: &HashMap<usize, Vec<usize>>, n: usize) -> Vec<usize> {
    let mut visited = vec![false; n];
    let mut stack = Vec::new();

    for v in 0..n {
        if !visited[v] {
            dfs(v, graph, &mut visited, &mut stack);
        }
    }

    // Reverse stack to get correct topological order
    stack.reverse();
    stack
}

fn main() {
    // Example DAG (from CLRS)
    let mut graph: HashMap<usize, Vec<usize>> = HashMap::new();

    graph.insert(0, vec![1, 2]);
    graph.insert(1, vec![3]);
    graph.insert(2, vec![3]);
    graph.insert(3, vec![4]);
    graph.insert(4, vec![]);

    let n = 5;
    let order = topological_sort(&graph, n);

    println!("Topological order:");
    for v in order {
        print!("{} ", v);
    }
    println!();
}
