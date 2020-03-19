install.packages("RSocrata")
library(RSocrata)
install.packages("sqldf")
library(sqldf)
install.packages("jsonlite")
library(jsonlite)



#Step 1
AccidentData<-read.socrata('https://opendata.maryland.gov/resource/pdvh-tf2u.json')

#Step 2
#All the column names are listed in the instructions, so I did not remove any since they seemed to be necessary.
#Removing the #NAs from the data to clean it up
CleanAccidentData<-na.omit(AccidentData)

#Step 3
sqldf("select count(CleanAccidentData.day_of_week) as 'Sunday Accidents' from CleanAccidentData where day_of_week like 'SUNDAY%'")
sqldf("select count(CleanAccidentData.day_of_week) as 'Accidents with Injuries' from CleanAccidentData where injury like 'YES%'")
sqldf("select CleanAccidentData.day_of_week as 'Accident Day', count(CleanAccidentData.injury) as 'Number of Injuries'  
      from CleanAccidentData where injury like 'YES%' GROUP BY 1")

#Step 4
tapply(CleanAccidentData$day_of_week, CleanAccidentData$day_of_week, function(x) CleanAccidentData$day_of_week="SUNDAY")
