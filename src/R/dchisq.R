#' Run a distributed Chi^2 analysis
#'
#' FIXME: need to handle > 2 sites.
dchisq <- function(client, expl_vars) {
  log <- lgr::get_logger_glue("vtg/vtg.chisq")

  image.name <- "harbor.distributedlearning.ai/vantage/vtg.chisq:trolltunga"

  client$set.task.image(
    image.name,
    task.name="ChiSq"
  )

  # Run in a MASTER container
  if (client$use.master.container) {
    log$debug("Running `dchisq` in master container using image '{image.name}'")
    result <- client$call("dchisq", expl_vars)
    return(result)
  }

  # Run in a REGULAR container
  log$debug("Retrieving colSums using image '{image.name}'")
  colsums <- client$call("colSums", expl_vars)

  if (length(colsums) == 1) {
    msg <- paste(
      "Computing the Chi^2 statistic between sites, requires at least",
      "two sites!"
    )

    stop(msg)
  }

  log$debug("Computing statistic")
  s <- colsums[[1]]
  d <- colsums[[2]]
  result <- compute.chisq(s, d)

  return(result)
}
