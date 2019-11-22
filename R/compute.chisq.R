compute.chisq <- function(s, d) {
    x <- rbind(s, d)
    result <- chisq.test(x)

    # return(result)

    # The 'unname' calls are for compatability with the alternative implementation.
    return(list(
        X2 = unname(result$statistic),
        df = unname(result$parameter),
        p.value = unname(result$p.value)
    ))
}
