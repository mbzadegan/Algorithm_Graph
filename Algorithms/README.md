# Introduction to Algorithm Fundamentals

## 1. What is an Algorithm?

An **algorithm** is a finite sequence of well-defined steps designed to solve a specific problem or perform a computation. Algorithms are the foundation of computer science: every software system, from a simple calculator to a modern machine learning model, relies on algorithms to transform input into meaningful output.

An algorithm must have the following properties:

- **Input**: Zero or more inputs are taken before execution.  
- **Output**: At least one output is produced.  
- **Definiteness**: Each step is precisely defined.  
- **Finiteness**: Execution must terminate after a finite number of steps.  
- **Effectiveness**: Every operation is basic enough to be performed within finite time.  

Algorithms are not limited to computers; cooking recipes, mathematical procedures, and navigation instructions are also examples.

---

## 2. Why Study Algorithms?

Algorithms matter for several reasons:

1. **Efficiency**  
   Computer hardware improves constantly, but efficient algorithms often yield orders of magnitude greater performance than hardware upgrades.

2. **Scalability**  
   An algorithm that works well for a dataset of size 1000 may fail when applied to a dataset of size 1 billion. Scalability is often determined by the asymptotic growth rate of the algorithm.

3. **Correctness**  
   An algorithm must not only run fast but also guarantee the right result under all conditions.

4. **Foundation for Advanced Topics**  
   Cryptography, artificial intelligence, data science, and networking all rely on algorithmic thinking.

---

## 3. Algorithm Analysis

### 3.1 Time Complexity

The **time complexity** of an algorithm estimates how running time grows with input size \( n \). It is expressed in terms of *Big-O notation*:

- **O(1)**: Constant time  
- **O(log n)**: Logarithmic time  
- **O(n)**: Linear time  
- **O(n log n)**: Quasi-linear  
- **O(n²)**: Quadratic  
- **O(2ⁿ)**: Exponential  

#### Example

- Linear search has \( O(n) \) time complexity.  
- Binary search has \( O(\log n) \).  

**Binary Search Pseudocode:**

```text
BINARY-SEARCH(A, key)
1. low ← 0
2. high ← length(A) - 1
3. while low ≤ high do
4.     mid ← (low + high) / 2
5.     if A[mid] = key then
6.         return mid
7.     else if A[mid] < key then
8.         low ← mid + 1
9.     else
10.        high ← mid - 1
11. return -1
```

### 3.2 Space Complexity

Algorithms also consume memory. **Space complexity** measures how much memory is required relative to input size.

For example:
- Merge Sort uses \( O(n) \) extra space.  
- Quick Sort uses \( O(\log n) \) space due to recursion.  

---

## 4. Fundamental Algorithmic Techniques

### 4.1 Divide and Conquer

Break a problem into smaller subproblems, solve them independently, and combine solutions.  

**Merge Sort Pseudocode:**

```text
MERGE-SORT(A, left, right)
1. if left < right then
2.     mid ← (left + right) / 2
3.     MERGE-SORT(A, left, mid)
4.     MERGE-SORT(A, mid+1, right)
5.     MERGE(A, left, mid, right)
```

- Example algorithms: Merge Sort, Binary Search, Fast Fourier Transform (FFT).

### 4.2 Greedy Algorithms

Build a solution step by step, always making the locally optimal choice.  

**Activity Selection Example:**

```text
ACTIVITY-SELECTION(activities)
1. sort activities by finishing time
2. select first activity
3. for each next activity do
4.     if activity.start ≥ last_selected.finish then
5.         select activity
```

- Example: Kruskal’s and Prim’s algorithms for Minimum Spanning Tree.

### 4.3 Dynamic Programming

Store solutions to overlapping subproblems to avoid recomputation.  

**Fibonacci DP Example:**

```text
FIBONACCI(n)
1. create array F[0..n]
2. F[0] ← 0, F[1] ← 1
3. for i ← 2 to n do
4.     F[i] ← F[i-1] + F[i-2]
5. return F[n]
```

- Example: Fibonacci sequence, Longest Common Subsequence, Matrix Chain Multiplication.

### 4.4 Graph Algorithms

Graphs model real-world networks.  

- Breadth-First Search (BFS): O(V + E)  
- Depth-First Search (DFS): O(V + E)  

**BFS Pseudocode:**

```text
BFS(G, s)
1. mark all vertices unvisited
2. create queue Q
3. enqueue s, mark visited
4. while Q not empty do
5.     u ← dequeue(Q)
6.     for each neighbor v of u do
7.         if v not visited then
8.             mark v visited
9.             enqueue v
```

- Dijkstra’s algorithm: O(E log V) with a priority queue.

### 4.5 Randomized Algorithms

Introduce randomness to improve performance or simplify design.  
- Example: QuickSort (random pivot selection), Monte Carlo methods.

---

## 5. Classic Problems and Their Algorithms

1. **Sorting**  
   - Bubble Sort (O(n²))  
   - Merge Sort (O(n log n))  
   - QuickSort (O(n log n) average case)

2. **Searching**  
   - Linear Search (O(n))  
   - Binary Search (O(log n))

3. **Graph Problems**  
   - Shortest Path (Dijkstra, Bellman-Ford)  
   - Minimum Spanning Tree (Prim, Kruskal)

4. **Optimization**  
   - Knapsack Problem  
   - Traveling Salesman Problem (TSP)

---

## 6. Theoretical Limits

Not every problem can be solved efficiently:

- **P vs NP**: Open problem asking whether every problem whose solution can be *verified* in polynomial time can also be *solved* in polynomial time.  
- **NP-Complete Problems**: Problems as hard as any in NP (e.g., SAT, TSP, Knapsack).  

Understanding these limits prevents wasted effort searching for efficient algorithms where none exist.

---

## 7. Algorithms in Practice

Algorithms are not purely academic. They are the backbone of real systems:

- **Web Search Engines**: Use graph algorithms (PageRank) and string matching.  
- **Cryptography**: Relies on number theory and modular arithmetic.  
- **Data Science**: Uses sorting, searching, and optimization techniques.  
- **Networking**: Uses shortest path and flow algorithms.  

---

## 8. Conclusion

The study of algorithms teaches us to think logically, solve problems efficiently, and understand the limits of computation. Mastery of algorithmic fundamentals is essential for computer scientists, engineers, and anyone dealing with large amounts of data.  

By practicing both the **design** and **analysis** of algorithms, students build skills that transfer directly into programming, research, and industry applications.  

---

### 📚 References (for further study)
1. Cormen, Leiserson, Rivest, Stein — *Introduction to Algorithms (CLRS)*  
2. Kleinberg & Tardos — *Algorithm Design*  
3. Sedgewick & Wayne — *Algorithms*  
4. Bhargava — *Grokking Algorithms*  
