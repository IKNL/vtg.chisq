#' Return counts for each (binned) value for a variable.
#'
#' Chi2 analysis is run for each variable independently. This function expects
#' the dataset to be 1-hot encoded. As such, we can sum over rows/columns to get
#' counts.
#'
#' Return: counts for each variable (vector)
RPC_colSums <- function(df, expl_vars) {
    # S[i]: nr. of occurrences in dataset S, bin i (scalar)
    # S: vector of occurrences for all bins
    # sum(S): total number of occurrences across bins; this should correspond
    # to the number of rows, since the chi2 should be run against a single
    # variable.
    return(colSums(df[expl_vars]))
}


