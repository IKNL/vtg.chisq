#' Mock a distributed Chi^2 analysis.
dchisq.mock <- function(df, expl_vars, splits=2) {
    datasets <- list()

    for (k in 1:splits) {
        datasets[[k]] <- df[seq(k, nrow(df), by=splits), ]
    }

    client <- vtg::MockClient$new(datasets, pkgname=getPackageName())
    results <- dchisq(client, expl_vars)
    return(results)
}

