# Exploring a RAG enabled chatbot with R

In this toy example, I explore how to set up a vector store using the `{ragnar}` package and ingest
a number of public medical research papers into a duckdb database. The store is added as a retrieval
tool to an LLM chat client via the `{ellmer}` package. Finally, I create a Shiny web application with
the `{shinychat}` package to allow querying the RAG application through a chat interface.


## Dev environment setup

The development environment of this project is encapsulated in a Docker container.

1. Install Docker. Follow the instructions on https://docs.docker.com/install/
2. Clone the GIT repository
   `git clone https://github.com/nz-stefan/llm-rag-play`
3. Open file `.Renviron-template` and follow instructions to set up your `OPENAI_API_KEY`.
4. Setup development Docker container
   `bin/setup-environment.sh`
   You should see lots of container build messages
5. Spin up the container
   `bin/start_rstudio.sh`
6. Open `http://localhost:8797` in your browser to start a new RStudio session
7. Install R packages required for this app. Type the following instructions into the R session window of RStudio
   `renv::restore()`

The installation will take a few minutes. The package library will be installed into
the `renv/library` directory of the project path.
