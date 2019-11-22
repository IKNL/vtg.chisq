# The Dockerfile tells Docker how to construct the image with your algorithm.
# Once pushed to a repository, images can be downloaded and executed by the
# network hubs.
FROM custom-r-base

# Change directory to '/app’. This means the subsequent ‘RUN’ steps will
# execute in this directory.
WORKDIR /app

# Install federated chisq package
COPY install_packages.R /app
RUN Rscript install_packages.R

# Create two files that will later serve for input/output
RUN touch input.txt
RUN touch output.txt
RUN touch database


# Tell docker to execute `docker.wrapper()` when the image is run.
CMD Rscript -e 'library(vantage.chisq)' -e 'vantage.infrastructure::docker.wrapper()'

