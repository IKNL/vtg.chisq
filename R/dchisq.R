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


