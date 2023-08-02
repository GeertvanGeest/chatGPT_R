library(httr)
library(jsonlite)

source(".env.R")

chatGPT <- function(user_prompt,
                    system_prompt = "you are a helpful assistant",
                    modelName = "gpt-3.5-turbo",
                    temperature = 1,
                    apiKey = API_KEY) {
  
  response <- POST(
    url = "https://api.openai.com/v1/chat/completions", 
    add_headers(Authorization = paste("Bearer", apiKey)),
    content_type_json(),
    encode = "json",
    body = list(
      model = modelName,
      temperature = temperature,
      messages = list(list(
        role = "user", 
        content = user_prompt
      ),
      list(
        role = "system",
        content = system_prompt
      )
      )
    ))
  
  if(status_code(response)>200) {
    stop(content(response))
  }
  
  trimws(content(response)$choices[[1]]$message$content)
}

chatGPT("Explain how nice the beach is today",
        "You are a helpful assistant, that's also a cool surfer dude") |> cat()

chatGPT("What does your planet look like?",
        "You are a organism that lives in a far away universe") |> cat()
