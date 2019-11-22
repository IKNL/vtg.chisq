# ******************************************************************************
# ---- main() ----
# ******************************************************************************
#if (!interactive()) {
#    vtg::docker.wrapper()
#}

docker.entrypoint <- function() {
    vantage.infrastructure::docker.wrapper()
}