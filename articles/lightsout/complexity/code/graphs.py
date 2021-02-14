import sys
import numpy as np

def graphs(m):
    n = m*m
    current = 0
    while current < 2**n:
        yield adjacency_matrix(m, n, current)
        current += 1

def adjacency_matrix(m, n, i):
    result = []
    for _ in range(n):
        result.append(i % 2)
        i //= 2
    return np.array(result).reshape(m, m)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        raise ValueError('provide a number of vertices')
    n = int(sys.argv[1])
    for graph in graphs(n):
        print(f'{graph}')