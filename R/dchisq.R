#!/usr/bin/env Rscript

#' ----------------------------------------------------------------------------
#' title: dl_chisq.R
#' description:
#'   Implementation of the Chi Squared algorithm.
#'
#'   This implementation can be used with the Vantage federated
#'   learning infrastructure (see https://github.com/IKNL/vantage).
#'
#' authors:
#'   Frank Martin <f.martin@iknl.nl>
#'   Gijs Geleijnse <g.geleijnse@iknl.nl>
#'   Melle Sieswerda <m.sieswerda@iknl.nl>
#' date: 20-nov-2019
#' license: MIT License
#' ----------------------------------------------------------------------------

# ******************************************************************************
# ---- Server/orchestrator functions ----
# ******************************************************************************

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

#' Run a distributed Chi^2 analysis
#'
#' FIXME: need to handle > 2 sites.
dchisq <- function(client, expl_vars) {
  writeln("Retrieving colSums")

  client$set.task.image(
    "docker-registry.distributedlearning.ai/dl_chisq",
    task.name="ChiSq"
  )

  colsums <- client$call("colSums", expl_vars)

  if (length(colsums) == 1) {
    msg <- paste(
      "Computing the Chi^2 statistic between sites, requires at least",
      "two sites!"
    )

    stop(msg)
  }

  writeln("Computing statistics")

  s <- colsums[[1]]$result
  d <- colsums[[2]]$result
  result <- compute.chisq(s, d)
  return(result)
}

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


