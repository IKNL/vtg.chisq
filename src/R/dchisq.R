#' Run a distributed Chi^2 analysis
#'
#' FIXME: need to handle > 2 sites.
dchisq <- function(client, expl_vars) {
  writeln("Retrieving colSums")
  image.name <- "harbor.distributedlearning.ai/vantage/vtg.chisq:trolltunga"

  client$set.task.image(
    image.name,
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
  s <- colsums[[1]]
  d <- colsums[[2]]
  result <- compute.chisq(s, d)

  return(result)
}


