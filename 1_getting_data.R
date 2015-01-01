
###########################################
########getting data from islamic finder#
#######################################

#loading necessary libraries
library(dplyr)
library(XML)
library(stringr)
library(testthat)

#getting data (REQUIRES INTERNET ACCESS)#################################
jan <- readHTMLTable(el_url, stringsAsFactors=F, trim = T, which = 6)
feb <- readHTMLTable(el_url, stringsAsFactors=F, trim = T, which = 9)
march <- readHTMLTable(el_url, stringsAsFactors=F, trim = T, which = 12)
april <- readHTMLTable(el_url, stringsAsFactors=F, trim = T, which = 14)
may <- readHTMLTable(el_url, stringsAsFactors=F, trim = T, which = 17)
june <- readHTMLTable(el_url, stringsAsFactors=F, trim = T, which = 20)
july <- readHTMLTable(el_url, stringsAsFactors=F, trim = T, which = 24)
aug <- readHTMLTable(el_url, stringsAsFactors=F, trim = T, which = 27)
sept <- readHTMLTable(el_url, stringsAsFactors=F, trim = T, which = 30)
oct <- readHTMLTable(el_url, stringsAsFactors=F, trim = T, which = 32)
nov <- readHTMLTable(el_url, stringsAsFactors=F, trim = T, which = 35)
dec <- readHTMLTable(el_url, stringsAsFactors=F, trim = T, which = 38)

#combining data
rezar <- rbind(jan, feb, march, april, may, june, july, aug, sept, oct, nov, dec) %>%
            rename(date = V1, fajiez = V2, sunrise = V3, dhuhr = V4, #renaming columns
                   asr = V5, maghrib = V6, isha = V7) %>%
            filter(date != "Date") #getting rid of header rows

#ensuring data extraction came out okay
leap_year <- ifelse(el_año %in% c(2016, 2020, 2024, 2028, 2032, 2036),
                        "yes", "no")
test_that(paste("we have a correct annual calendar for", el_año), 
            if (leap_year == "no") expect_equal(nrow(rezar), 365)
            else expect_equal(nrow(rezar), 366))

#writing out data
write.csv(rezar, paste0("raw_calendario_", el_año, ".csv"), row.names=F)

#saving some RAM
remove(el_url, leap_year)
remove(jan, feb, march, april, may, june, july, aug, sept, oct, nov, dec) 

