## code to prepare `wine_data` dataset goes here


# retrieve paths to datafiles
first.file <- system.file(
  "extdata",
  "winemag-data-130k-v2.csv",
  package = "WineReviews"
)

second.file <- system.file(
  "extdata",
  "winemag-data_first150k.csv",
  package = "WineReviews"
)

# read the two .csv files
data.part.one <- read.csv(
  first.file,
  stringsAsFactors = FALSE,
  encoding = "UTF-8"
)
data.part.two <- read.csv(
  second.file,
  stringsAsFactors = FALSE,
  encoding = "UTF-8"
)

# select 4 variables and merge the two files
wine.variables <- c("country", "points", "price", "winery")
data.part.one <- data.part.one[, wine.variables]
data.part.two <- data.part.two[, wine.variables]
wine_data <- rbind(data.part.one, data.part.two)

# fill missing prices with the mean price per country
wine_data <- wine_data %>%
  dplyr::group_by(country) %>%
  dplyr::mutate(price = fill_na_mean(price))
# some countries don't have any non-missing price
# we omit these observations from the data
wine_data <- wine_data %>%
  dplyr::filter(!is.na(price))

# save the wine_data dataframe as an .rda file in WineReviews/data/
usethis::use_data(wine_data, overwrite = TRUE)

