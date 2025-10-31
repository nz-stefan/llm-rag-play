#################################################################################
# Ingest medical papers into DuckDB vector store
#
# Author: Stefan Schliebs
# Created: Fri Oct 31 05:41:07 2025
#################################################################################


library(ragnar)
library(dplyr)


# Config ------------------------------------------------------------------

F_PDFS <- "/home/rstudio/data/articles"
F_VECTOR_STORE <- "/home/rstudio/src/app/papers.ragnar.duckdb"


# Process PDF files -------------------------------------------------------

# create a new vector store
store <- ragnar_store_create(
  F_VECTOR_STORE,
  embed = function(x) embed_openai(x, model = "text-embedding-3-small")
)

# get list of all available PDFs
pdf_files <- list.files(F_PDFS, pattern = ".*pdf", full.names = TRUE)

# loop over PDFs, chunk and insert into store
for(pdf_file in pdf_files) {
  cat(paste0("Processing ", pdf_file, "...\n"))

  chunks <- pdf_file %>% read_as_markdown() %>% markdown_chunk()
  ragnar_store_insert(store, chunks)
}

# build the index
cat("Building DB index...\n")
ragnar_store_build_index(store)

DBI::dbDisconnect(store@con)

cat("done\n")
