import time
from sage.graphs.graph_generators import graphs

# -------------------------------
# Parameters
# -------------------------------
n = 200
p = (log(n) + log(log(n))) / n   # near Hamiltonian threshold

print(f"Generating random graph with n={n}, p={p:.4f}")
G = graphs.RandomGNP(n, p)

# Ensure connectivity (Hamiltonian cycle impossible otherwise)
while not G.is_connected():
    G = graphs.RandomGNP(n, p)

# -------------------------------
# Solve Hamiltonian Cycle
# -------------------------------
start = time.time()

cycle = G.hamiltonian_cycle()

end = time.time()

# -------------------------------
# Report
# -------------------------------
if cycle:
    print("Hamiltonian cycle found!")
    print("Cycle length:", len(cycle))
else:
    print("No Hamiltonian cycle exists.")

print("Elapsed time (seconds):", round(end - start, 3))
