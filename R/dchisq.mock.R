#' Mock a distributed Chi^2 analysis.
dchisq.mock <- function(df, expl_vars, splits=5) {
    datasets <- list()

    for (k in 1:splits) {
        datasets[[k]] <- df[seq(k, nrow(df), by=splits), ]
    }

    client <- vantage.infrastructure::MockClient(datasets)
    results <- dchisq(client, expl_vars)
    return(results)
}

