#################################################################################
# Server logic of the app
#
# Author: Stefan Schliebs
# Created: Fri Oct 31 05:17:01 2025
#################################################################################


function(session, input, output) {
  
  # Set up the chat bot -------------------------------------------------------
  
  # load system prompt
  system_prompt <- str_squish(readLines(F_SYSTEM_PROMPT))
  
  # initialize the bot
  # NOTE: this will require a valid API key in `.Renviron`
  chat <- chat_openai(system_prompt = system_prompt)
  
  # load vector store
  store <- ragnar_store_connect(F_VECTOR_STORE)
  ragnar_register_tool_retrieve(chat, store, top_k = 3)
  
  
  # Set up the chat stream --------------------------------------------------
  
  chatbot_greetings <- str_squish(readLines(F_GREETINGS))
  chat_append("chat", chatbot_greetings, role = "assistant", session = session)
  
  # helper function to append text to the chat window
  append_output <- function(...) {
    txt <- paste0(...)
    chat_append_message(
      "chat",
      list(role = "assistant", content = txt),
      chunk = TRUE,
      operation = "append",
      session = session
    )
  }
  
  # stream LLM response as it becomes available
  observeEvent(input$chat_user_input, {
    stream <- chat$stream_async(input$chat_user_input)
    chat_append("chat", stream)
  })
}
