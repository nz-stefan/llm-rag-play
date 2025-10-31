#################################################################################
# Entry point of the Shiny app
#
# Author: Stefan Schliebs
# Created: Fri Oct 31 05:16:20 2025
#################################################################################


library(shiny)
library(shinychat)
library(ragnar)
library(ellmer)
library(stringr)


# Global constants --------------------------------------------------------

F_GREETINGS <- "/home/rstudio/src/app/greetings.md"
F_SYSTEM_PROMPT <- "/home/rstudio/src/app/prompt.md"
F_VECTOR_STORE <- "/home/rstudio/papers.ragnar.duckdb"

