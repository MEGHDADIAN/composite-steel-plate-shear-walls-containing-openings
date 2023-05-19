# composite-steel-plate-shear-walls-containing-openings

This Python code is designed to calculate the displacement of composite-steel-plate-shear-walls-containing-openings under a given load using the finite element method. The code allows you to input the number of nodes, Young's modulus, Poisson's ratio, and thickness of the plate. 

The code follows the following steps:

1. It first defines the coordinates of the nodes on the plate using the `np.linspace` function.

2. Next, it computes the geometry functions (`zigmaxx`, `zigmax0`, `zigmayy`, `zigmay0`, and `zigmaxy`) based on the given coordinates.

3. The code then calculates the stiffness matrix (`MATG`) using the formula: C = E / (1 - nu^2) * [[1, nu, 0], [nu, 1, 0], [0, 0, (1 - nu) / 2]], where E is the Young's modulus and nu is the Poisson's ratio.

4. After that, it applies boundary conditions to the stiffness matrix (`KG`) to account for the support conditions of the plate.

5. It also applies support conditions by setting extremely high values (`1e30`) for the corresponding entries in the stiffness matrix to prevent movement in those directions.

6. The code then prompts you to provide the load vector (`P`), which represents the external load applied to the plate. You can modify the code to customize the load vector according to your requirements.

7. Finally, it solves the system of equations `KG * U = P` to obtain the displacement vector (`U`) using the `np.linalg.solve` function. The displacement vector is reshaped to match the shape of the plate.

8. The code prints the resulting displacement matrix (`U`), which represents the vertical displacement of each node in the plate.

To use this code, you need to have the NumPy library installed in your Python environment. You can input the desired parameters (number of nodes, Young's modulus, Poisson's ratio, thickness) and modify the load vector as needed to simulate different scenarios. Ensure that the required functions (`zigmaxx`, `zigmax0`, `zigmayy`, `zigmay0`, and `zigmaxy`) are defined appropriately for your specific use case.

Feel free to customize and adapt the code according to your requirements and further analyze the results of the plate displacement.
