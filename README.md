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
# Load the package
library(vtg.chisq)

# Function to create a client
setup.client <- function() {
  # Define parameters
  username <- "username@example.com"
  password <- "password"
  collaboration_id <- 1
  host <- 'https://api-test.distributedlearning.ai'
  api_path <- ''
  
  # Create the client
  client <- vtg::Client(host, username, password, collaboration_id, api_path)
  client$authenticate()

  return(client)
}

# Create a client
client <- setup.client()

# The explanatory variables should correspond to a single, 
# one-hot encoded variable.
expl_vars <- c()

# vtg.chisq contains the function `dchisq`.
result <- dchisq(client, expl_vars)
```

## Example use for testing
```R
# Load the package
library(vtg.chisq)

# Load a dataset
data(SEER)

# Select the columns corresponding to the variable "Mar"
expl_vars <- c("Mar2","Mar3","Mar4","Mar5","Mar9")

# Run the Chi^2 analysis
dchisq.mock(SEER, expl_vars)
```
