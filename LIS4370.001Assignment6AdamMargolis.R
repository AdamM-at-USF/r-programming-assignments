# Task 1: Matrix Addition & Subtraction

# Define matrices A and B
A <- matrix(c(2, 0, 1, 3), ncol = 2)
B <- matrix(c(5, 2, 4, -1), ncol = 2)

# Matrix addition
A_plus_B <- A + B
print("Task 1 - Matrix Addition (A + B):")
print(A_plus_B)

# Matrix subtraction
A_minus_B <- A - B
print("Task 1 - Matrix Subtraction (A - B):")
print(A_minus_B)


# ==============================================================================
# Task 2: Create a Diagonal Matrix

# Create a 4x4 matrix with specified diagonal values
D <- diag(c(4, 1, 2, 3))

print("Task 2 - Diagonal Matrix (D):")
print(D)


# ==============================================================================
# Task 3: Construct a Custom 5x5 Matrix

# Option A: Building using diag(), matrix(), and cbind()
# Create the 5x5 diagonal matrix with 3s on the main diagonal
m_diag <- diag(3, nrow = 5, ncol = 5)

# Create a 5x1 column vector representing the first column [3, 2, 2, 2, 2]^T
col1 <- matrix(c(3, 2, 2, 2, 2), ncol = 1)

# Combine the first column with columns 2 through 5 of the diagonal matrix,
# then overwrite the first row's remaining entries with 1s
M <- cbind(col1, m_diag[, 2:5])
M[1, 2:5] <- 1

print("Task 3 - Custom 5x5 Matrix:")
print(M)