#install.packages("RMariaDB")
#install.packages(c("ggplot2","statsr")
#install.packages("rpart.plot")
#install.packages("randomForest")
#install.packages("RGtk2")
#install.packages('class')

library(rpart.plot)
library(class)
library(randomForest)
library(RMariaDB)

options(scipen = 999)

#connect sql database
connect <- dbConnect(RMariaDB::MariaDB(),
                     user="root", password="pasword",
                     dbname="house_database", host="localhost")

dbListTables(connect)
#SQL query to get all data frome database
select_all_query <- "SELECT * FROM house_database.house_data";


#Turn out SQL query into a dataframe
cut_data <- dbFetch(dbSendQuery(connect, select_all_query))
on.exit(dbDisconnect(connect))
#Cutting the data. Removing uneeded columns
cut_data<-cut_data[,-c(1,12)]

#Renaming column
train<-cut_data

#Model that puts our user input into the random forest
ForestModel<-function(input){
  
  
  #Fit for the random forest
  fit3 <- rpart(SalePrice ~ LotArea + OverallCond + YearBuilt + X1stFlrSF +
                  X2ndFlrSF + BsmtFullBath + FullBath + TotRmsAbvGrd + GarageCars, data = train, cp =.02)
  
  #List of the user inputs which are liked to columns in dataframe
  inputList <- list(LotArea<-input$LotArea,
                    OverallCond<-input$OverallCond,
                    YearBuilt<-input$YearBuilt,
                    X1stFlrSF<-input$X1stFlrSF,
                    X2ndFlrSF<-input$X2ndFlrSF,
                    BsmtFullBath<-input$BsmtFullBath,
                    FullBath<-input$FullBath,
                    TotRmsAbvGrd<-input$TotRmsAbvGrd,
                    GarageCars<-input$GarageCars)
  
  #Making inputlist into a dataframe
  inputList <- as.data.frame(inputList)
  #Random Forest Prediction
  prediction = predict(fit3, inputList, type = "vector")
  return(prediction)
  
}
#Taking in our inputs and outputting the prediction
server <- function(input, output) {
  
  output$Predicted <- renderText({
    paste("Your House Has a Predicted Value of $ ", as.character(round((ForestModel(input)),digits=2)))
  })
}

shinyApp(ui = ui, server = server)



