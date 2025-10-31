#################################################################################
# UI definitions of the app
#
# Author: Stefan Schliebs
# Created: Fri Oct 31 05:17:11 2025
#################################################################################


ui <- bslib::page_fillable(
  title = "Medical Search Assistant",
  chat_ui("chat")
)
