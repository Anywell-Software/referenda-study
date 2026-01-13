library(jsonlite)
library(glue)
library(stringr)

json_data <- fromJSON("json-data-referenda.json")
resources <- json_data$result$resources$download_url
print(resources)

urls <- lapply(resources, fromJSON)

length(urls)

counter <- 0
for (iter in resources) {
  counter <- counter + 1
  fileName <- str_glue("/Users/shansai/Swiss-Referenda/vorlagen/{counter}.json")
  download.file(iter, fileName)
}

for (iter in urls) {
  print(iter$schweiz$vorlagen$result$stimmbeteiligungInProzent)
}