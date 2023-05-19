import numpy as np

# Number of nodes
nn = int(input("Enter the number of nodes: "))

# Plate properties
E = float(input("Enter the Young's modulus of the plate material: "))
nu = float(input("Enter the Poisson's ratio of the plate material: "))
t = float(input("Enter the thickness of the plate: "))

# Define the coordinates of the nodes
x = np.linspace(-1, 1, nn)
y = np.linspace(-1, 1, nn)
X, Y = np.meshgrid(x, y)
X = np.reshape(X, (nn * nn, 1))
Y = np.reshape(Y, (nn * nn, 1))

# Compute the geometry functions
zigmaxx = 1 - X**2
zigmax0 = 1 - Y**2
zigmayy = 1 - Y**2
zigmay0 = 1 - X**2
zigmaxy = X * Y

# Calculate the stiffness matrix
C = E / (1 - nu**2) * np.array([[1, nu, 0], [nu, 1, 0], [0, 0, (1 - nu) / 2]])
w1 = np.concatenate((zigmaxx, zigmax0, zigmayy, zigmay0, zigmaxy), axis=1)
GN = np.concatenate((np.diff(w1, axis=1), np.diff(w1, axis=0), np.diff(w1, axis=0), np.diff(w1, axis=1), np.zeros((nn*nn, nn*nn))), axis=1)
MATG = np.transpose(GN) @ np.array([[zigmaxx, zigmaxy], [zigmaxy, zigmayy]]) @ GN
KG = np.trapz(np.trapz(MATG, x=[-1, 1]), x=[-1, 1])

# Boundary conditions
KB = np.zeros((nn, nn))
KB[0, :] = 1
KB[-1, :] = 1
KB[:, 0] = 1
KB[:, -1] = 1
KG = np.zeros((nn * nn, nn * nn))
KG[:nn, :nn] = np.copy(KB)
KG[-nn:, -nn:] = np.copy(KB)
KG[nn * (nn - 1)::nn, nn * (nn - 1)::nn] = np.copy(KB)
KG[::nn, ::nn] = np.copy(KB)
KG[nn:-nn, nn:-nn] = np.copy(KG)

# Support conditions
KG[0, 0] = 1e30
KG[1, 1] = 1e30
KG[-1, -1] = 1e30
KG[-2, -2] = 1e30
KG[nn * (nn - 1), nn * (nn - 1)] = 1e30
KG[nn * (nn - 1) + 1, nn * (nn - 1) + 1] = 1e30
KG[nn * nn - 1, nn * nn - 1] = 1e30
KG[nn * nn - 2, nn * nn - 2] = 1e30

# Load vector
P = np.zeros((nn * nn, 1))
P[nn * (nn - 1) + nn // 2] = -10

# Displacement vector
U = np.linalg.solve(KG, P)

# Reshape the displacement vector to match the shape of the plate
U = np.reshape(U, (nn, nn))

# Print the displacement results
print("Displacement:")
print(U)
