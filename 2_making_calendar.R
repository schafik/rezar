
################################################
########getting .csv file to google calendar##
#############################################

##read in csv file 
rezar <- read.csv("raw_calendario_2015.csv", stringsAsFactors=F)

##read in template data frame for google calendar
template <- read.csv("template.csv", stringsAsFactors=F, header = T)

##creating 6 data frames for 5 prayers + sunrise
#1) fajr ##################################################################
#gathering only fajr data
fajiez <- select(rezar, fajiez)
fajiez <- cbind(fajiez, template) %>% 
            mutate(Description = "fajiez",
                   Subject = Description,
                   Start.Time = paste0(fajiez, ":00", " AM"),
                   End.Time = Start.Time)
#time transformations 
fajiez$Start.Time <- strptime(fajiez$Start.Time, format="%X")
fajiez$Start.Time <- as.character(strftime(fajiez$Start.Time, format="%T %p"))
fajiez$End.Time <- strptime(fajiez$End.Time, format="%X")
fajiez$End.Time <- as.character(
                      strftime(fajiez$End.Time+60*5, #can change length of event here
                                 format="%H:%M:%S %p")) 
#renaming and selecting relevant columns
fajiez <- select(fajiez, `Start Date` = Start.Date, `Start Time` = Start.Time, 
                          `End Date` = End.Date, `End Time` = End.Time,
                           `All Day Event` = All.Day.Event, everything(), -starts_with("faj"))  

#ensuring fajr is all in the AM!
test_that("fajr is in the AM", 
          expect_equal(length(str_detect(fajiez$`Start Time`, "AM")), 
                       nrow(fajiez)))

#2) sunrise ################################################################
sunrise <- select(rezar, sunrise)
sunrise <- cbind(sunrise, template) %>% 
  mutate(Description = "sunrise", Subject = Description,
         Start.Time = paste0(sunrise, ":00", " AM"), End.Time = Start.Time)
sunrise$Start.Time <- strptime(sunrise$Start.Time, format="%X")
sunrise$Start.Time <- as.character(strftime(sunrise$Start.Time, format="%T %p"))
sunrise$End.Time <- strptime(sunrise$End.Time, format="%X")
sunrise$End.Time <- as.character(strftime(sunrise$End.Time+60, format="%H:%M:%S %p"))
sunrise <- select(sunrise, `Start Date` = Start.Date, `Start Time` = Start.Time, 
                 `End Date` = End.Date, `End Time` = End.Time,
                 `All Day Event` = All.Day.Event, everything(), -starts_with("sun"))   

#ensuring sunrise is all in the AM!
test_that("sunrise is in the AM", 
          expect_equal(length(str_detect(sunrise$`Start Time`, "AM")), 
                       nrow(sunrise)))

#3) dhuhr ##################################################################
dhuhr <- select(rezar, dhuhr)
dhuhr <- cbind(dhuhr, template) %>% 
            mutate(Description = "dhuhr", Subject = Description,
                   Start.Time = ifelse(is.na(str_extract(dhuhr, "11:")), 
                                  paste0(dhuhr, ":00", " PM"), paste0(dhuhr, ":00", " AM")),
                   End.Time = Start.Time)
dhuhr$Start.Time <- strptime(dhuhr$Start.Time, format="%r")
dhuhr$Start.Time <- as.character(strftime(dhuhr$Start.Time, format="%T %p"))
dhuhr$End.Time <- strptime(dhuhr$End.Time, format="%r")
dhuhr$End.Time <- as.character(strftime(dhuhr$End.Time+60*5, format="%H:%M:%S %p"))
dhuhr <- select(dhuhr, `Start Date` = Start.Date, `Start Time` = Start.Time, 
                  `End Date` = End.Date, `End Time` = End.Time,
                  `All Day Event` = All.Day.Event, everything(), -starts_with("dh"))  
#test to make sure it can go into google calendar okay with military time!~

#4) asr ###################################################################
asr <- select(rezar, asr)
asr <- cbind(asr, template) %>% 
  mutate(Description = "asr", Subject = Description,
         Start.Time = paste0(asr, ":00", " PM"), End.Time = Start.Time)
asr$Start.Time <- strptime(asr$Start.Time, format="%r")
asr$Start.Time <- as.character(strftime(asr$Start.Time, format="%T %p"))
asr$End.Time <- strptime(asr$End.Time, format="%r")
asr$End.Time <- as.character(strftime(asr$End.Time+60*5, format="%H:%M:%S %p"))
asr <- select(asr, `Start Date` = Start.Date, `Start Time` = Start.Time, 
                `End Date` = End.Date, `End Time` = End.Time,
                `All Day Event` = All.Day.Event, everything(), -starts_with("asr"))    

#ensuring asr is all in the pm!
test_that("asr is in the PM", 
          expect_equal(length(str_detect(asr$`Start Time`, "PM")), 
                       nrow(asr)))

#5) maghrib #################################################################
maghrib <- select(rezar, maghrib)
maghrib <- cbind(maghrib, template) %>% 
  mutate(Description = "maghrib", Subject = Description,
         Start.Time = paste0(maghrib, ":00", " PM"), End.Time = Start.Time)
maghrib$Start.Time <- strptime(maghrib$Start.Time, format="%r")
maghrib$Start.Time <- as.character(strftime(maghrib$Start.Time, format="%T %p"))
maghrib$End.Time <- strptime(maghrib$End.Time, format="%r")
maghrib$End.Time <- as.character(strftime(maghrib$End.Time+60*5, format="%H:%M:%S %p"))
maghrib <- select(maghrib, `Start Date` = Start.Date, `Start Time` = Start.Time, 
              `End Date` = End.Date, `End Time` = End.Time,
              `All Day Event` = All.Day.Event, everything(), -starts_with("magh"))    

#ensuring maghrib is all in the pm!
test_that("maghrib is in the PM", 
          expect_equal(length(str_detect(maghrib$`Start Time`, "PM")), 
                       nrow(maghrib)))

#6) isha ####################################################################
isha <- select(rezar, isha)
isha <- cbind(isha, template) %>% 
  mutate(Description = "isha", Subject = Description,
         Start.Time = paste0(isha, ":00", " PM"), End.Time = Start.Time)
isha$Start.Time <- strptime(isha$Start.Time, format="%r")
isha$Start.Time <- as.character(strftime(isha$Start.Time, format="%T %p"))
isha$End.Time <- strptime(isha$End.Time, format="%r")
isha$End.Time <- as.character(strftime(isha$End.Time+60*5, format="%H:%M:%S %p"))
isha <- select(isha, `Start Date` = Start.Date, `Start Time` = Start.Time, 
                  `End Date` = End.Date, `End Time` = End.Time,
                  `All Day Event` = All.Day.Event, everything(), -starts_with("isha"))    

#ensuring isha is all in the pm!
test_that("isha is in the PM", 
          expect_equal(length(str_detect(isha$`Start Time`, "PM")), 
                       nrow(isha)))

#combining data ###################################################################
my_calendar <- rbind(fajiez, sunrise, dhuhr, asr, maghrib, isha)

#writing out data
write.csv(my_calendar, paste0("calendario_", el_año, ".csv"), row.names=F)

#saving RAM
remove(template, rezar, el_año)
remove(fajiez, sunrise, dhuhr, asr, maghrib, isha)



