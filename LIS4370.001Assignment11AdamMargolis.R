# ==============================================================================
# Assignment #11: Debugging and Defensive Programming in R
# ==============================================================================

# Helper function: Defines Tukey's outlier detection rule for a numeric vector
tukey.outlier <- function(x) {
  q <- quantile(x, probs = c(0.25, 0.75), na.rm = TRUE)
  iqr <- q[2] - q[1]
  lower_bound <- q[1] - 1.5 * iqr
  upper_bound <- q[2] + 1.5 * iqr
  return(x < lower_bound | x > upper_bound)
}

# ------------------------------------------------------------------------------
# 1. Reproduce the Buggy Code & Capture the Error
# ------------------------------------------------------------------------------

tukey_multiple_buggy <- function(x) {
  outliers <- array(TRUE, dim = dim(x))
  for (j in 1:ncol(x)) {
    # The line below contains the bug: '&&' evaluates only the first element
    outliers[, j] <- outliers[, j] && tukey.outlier(x[, j])
  }
  outlier.vec <- vector("logical", length = nrow(x))
  for (i in 1:nrow(x)) {
    outlier.vec[i] <- all(outliers[i, ])
  }
  return(outlier.vec)
}

# Generate test matrix
set.seed(123)
test_mat <- matrix(rnorm(50), nrow = 10)

# Running the buggy code causes an error:
# Error in outliers[, j] <- outliers[, j] && tukey.outlier(x[, j]) : 
#   number of items to replace is not a multiple of replacement length
# 
# Reason: '&&' performs a scalar logical operation, returning a single TRUE/FALSE 
# based only on the first element. Normally vector assignment expects length equal 
# to the column size (10 elements).


# ------------------------------------------------------------------------------
# 2. Corrected & Defensive Tukey Function
# ------------------------------------------------------------------------------

tukey_multiple <- function(x) {
  # Defensive Programming: Type and structure checks
  if (!is.matrix(x)) {
    stop("Input 'x' must be a matrix.")
  }
  if (!is.numeric(x)) {
    stop("Input 'x' must be a numeric matrix.")
  }
  if (nrow(x) == 0 || ncol(x) == 0) {
    stop("Input matrix 'x' cannot be empty.")
  }
  
  # Initialize boolean array for tracking outliers across columns
  outliers <- array(TRUE, dim = dim(x))
  
  # Loop over columns using element-wise logical AND (&)
  for (j in seq_len(ncol(x))) {
    outliers[, j] <- outliers[, j] & tukey.outlier(x[, j])
  }
  
  # Identify rows where every column has an outlier
  outlier.vec <- logical(nrow(x))
  for (i in seq_len(nrow(x))) {
    outlier.vec[i] <- all(outliers[i, ])
  }
  
  return(outlier.vec)
}


# ------------------------------------------------------------------------------
# 3. Validation
# ------------------------------------------------------------------------------

# Test with valid matrix input
result <- tukey_multiple(test_mat)
print(result)
# Expected Output: Logical vector of length 10 (all FALSE for standard normal data)

# Test defensive checks:
# try(tukey_multiple(as.data.frame(test_mat))) # Triggers: Input 'x' must be a matrix.
# try(tukey_multiple(matrix(c("a", "b", "c", "d"), nrow = 2))) # Triggers: Input 'x' must be a numeric matrix.