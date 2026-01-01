# Usage: python complexity_estimator.py example.py
# file: complexity_estimator.py

import ast

class ComplexityVisitor(ast.NodeVisitor):
    def __init__(self):
        self.max_depth = 0
        self.current_depth = 0

    
    def generic_visit(self, node):
        # Increase depth for loops and recursive functions
        if isinstance(node, (ast.For, ast.While)):
            self.current_depth += 1
            if self.current_depth > self.max_depth:
                self.max_depth = self.current_depth
            self.generic_visit_children(node)
            self.current_depth -= 1
        else:
            self.generic_visit_children(node)

    def generic_visit_children(self, node):
        for child in ast.iter_child_nodes(node):
            self.visit(child)

def estimate_complexity(filename):
    with open(filename, "r") as f:
        source = f.read()

    tree = ast.parse(source, filename=filename)
    visitor = ComplexityVisitor()
    visitor.visit(tree)

    d = visitor.max_depth
    if d == 0:
        return "O(1)"
    elif d == 1:
        return "O(n)"
    else:
        return f"O(n^{d})"

if __name__ == "__main__":
    import sys
    if len(sys.argv) != 2:
        print("Usage: python complexity_estimator.py target_script.py")
        sys.exit(1)

    target = sys.argv[1]
    complexity = estimate_complexity(target)
    print(f"Estimated time complexity of {target}: {complexity}")
