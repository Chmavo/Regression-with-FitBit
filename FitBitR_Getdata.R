library(fitbitr)
library(plyr)

#get new API token
token <- get_fitbit_token()

#make call to fitbit API to download data and parse response to JSON
hr_resp <-
  fitbit_GET("1/user/-/activities/heart/date/2016-01-01/today.json",
             token = token)
hr_ret <- fitbit_parse(hr_resp)
hr_ret.i <-
  lapply(hr_ret$`activities-heart`, function(x) {
    unlist(x)
  })
hr_data <- rbind.fill(lapply(hr_ret.i,
                             function(x)
                               do.call("data.frame", as.list(x))))
hr_data$value.restingHeartRate <-
  as.numeric(as.character(hr_data$value.restingHeartRate))