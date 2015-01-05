rezar
=====

use R to make a .csv file of annual prayer times custom to your location that you can upload to google calendar

**prereqs**
  - if you don't have R installed on your machine:
    - go [here](http://cran.rstudio.com/) to install basic R
    - go [here](http://www.rstudio.com/products/rstudio/download/) to install Rstudio (highly recommended) 
  - be sure the following libraries are installed: 
    - library(dplyr)
    - library(XML)
    - library(stringr)
    - library(testthat)

**4 steps**:

1) get the url for gregorian annual prayer times for your hometown from [islamic finder](http://islamicfinder.org/)
  ![alt tag](https://github.com/schafik/rezar/photos/city.png)

2) follow the steps detailed in the `0_where_when.R` script.

3) run the `get_calendar.R` script.
  - *help* [running an R script](http://www.dummies.com/how-to/content/how-to-source-a-script-in-r.html)

4) upload the `calendario_2015.csv` to your google calendar
  - *instructions* [from google](https://support.google.com/calendar/answer/37118?hl=en) on how to upload events from a csv file 
