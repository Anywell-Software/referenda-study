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

files <- list.files(path = "/Users/shansai/Swiss-Referenda/vorlagen", pattern = "\\.json$", full.names = TRUE)
properties_list <- list()

for (i in 1:length(files)) {
  content <- fromJSON(files[i])
  stimmbeteiligung <- content$schweiz$vorlagen$resultat$stimmbeteiligungInProzent
  
  properties_list[[i]] <- list(
    abstimmtag = content$abstimmtag,
    stimmbeteiligung = mean(stimmbeteiligung, na.rm = TRUE)
  )
  length(content$schweiz$vorlagen$resultat$stimmbeteiligungInProzent)
  print(mean(stimmbeteiligung, na.rm=TRUE))
}

df <- as.data.frame(do.call(rbind, properties_list))
df$abstimmtag <- as.Date(unlist(df$abstimmtag), format = "%Y%m%d")
df$stimmbeteiligung <- as.numeric(unlist(df$stimmbeteiligung))
print(df)
df <- df[order(df$abstimmtag), ]
plot(df$abstimmtag, df$stimmbeteiligung, 
     type = "b",
     xlab = "Voting Date",
     ylab = "Average Turnout (%)",
     main = "Swiss Referendum Voter Turnout Over Time",
     col = "blue",
     pch = 16)

