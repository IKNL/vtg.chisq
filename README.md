# vantage.chisq

## Installation
Run the following in the R console to install the package and its dependencies:
```R
# This also installs the package vantage.infrastructure
devtools::install_github('mellesies/vantage.chisq')
```

## Example use
```R
# Load the package
library(vantage.chisq)

# Function to create a client
setup.client <- function() {
  # Define parameters
  username <- "username@example.com"
  password <- "password"
  collaboration_id <- 1
  host <- 'https://api-test.distributedlearning.ai'
  api_path <- ''
  
  # Create the client
  client <- vantage.infrastructure::Client(host, username, password, collaboration_id, api_path)
  client$authenticate()

  return(client)
}

# Create a client
client <- setup.client()

# The explanatory variables should correspond to a single, 
# one-hot encoded variable.
expl_vars <- c()

# vantage.chisq contains the function `dchisq`.
result <- dchisq(client, expl_vars)
```

## Example use for testing
```R
# Load the package
library(vantage.chisq)

# Load a dataset
data(SEER)

# Select the columns corresponding to the variable "Mar"
expl_vars <- c("Mar2","Mar3","Mar4","Mar5","Mar9")

# Run the Chi^2 analysis
dchisq.mock(SEER, expl_vars)
```
