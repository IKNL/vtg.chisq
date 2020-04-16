# vtg.chisq

Implementation of the federated Chi2 algorithm for the [Vantage6](https://github.com/IKNL/VANTAGE6) federated infrastructure.

## Installation
Run the following in the R console to install the package and its dependencies:
```R
# This also installs the package vtg
devtools::install_github('mellesies/vtg.chisq', subdir='src')
```

## Example use
```R
setup.client <- function() {
  # Define parameters
  username <- "username@example.com"
  password <- "password"
  host <- 'https://trolltunga.vantage6.ai'
  api_path <- ''
  
  # Create the client
  client <- vtg::Client$new(host, api_path=api_path)
  client$authenticate(username, password)

  return(client)
}

# Create a client
client <- setup.client()

# Get a list of available collaborations
print( client$getCollaborations() )

# Should output something like this:
#   id     name
# 1  1 ZEPPELIN
# 2  2 PIPELINE

# Select a collaboration
client$setCollaborationId(1)

# The explanatory variables should correspond to a single, 
# one-hot encoded variable.
expl_vars <- c("Mar2","Mar3","Mar4","Mar5","Mar9")

# vtg.chisq contains the function `dchisq`.
result <- dchisq(client, expl_vars)
```

## Example use for testing
```R
# Load a dataset; this creates the variable `SEER`.
# NOTE: this requires the package `vtg.basic` to be installed!
data('SEER', package='vtg.basic')

# Select the columns corresponding to the variable "Mar"
expl_vars <- c("Mar2","Mar3","Mar4","Mar5","Mar9")

# Mock a distributed Chi^2 analysis.
vtg.chisq::dchisq.mock(SEER, expl_vars)
```
