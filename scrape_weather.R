# Load JSON parsing library
library(jsonlite)

# Exact weather parameters for Plymouth, WI
url <- "https://open-meteo.com"

message("Downloading weather data inside the GitHub cloud...")

# Read the data straight from the source
data <- fromJSON(url, simplifyVector = TRUE)

# Structure the forecast table
forecast_df <- data.frame(
  scrape_date   = Sys.Date(),
  forecast_date = data$daily$time,
  max_temp_f    = data$daily$temperature_2m_max,
  min_temp_f    = data$daily$temperature_2m_min,
  predicted_rain_in = round(data$daily$rain_sum / 25.4, 2)
)

# Append or save data to the historical spreadsheet file
file_name <- "weather_archive.csv"
if (file.exists(file_name)) {
  write.table(forecast_df, file = file_name, append = TRUE, 
              sep = ",", row.names = FALSE, col.names = FALSE)
} else {
  write.csv(forecast_df, file = file_name, row.names = FALSE)
}

print("Success! Data archived successfully.")
