library(shiny)

ui <- fluidPage(
  titlePanel("Lowa House Price Prediction"),
  
  sidebarLayout(
    # Sidebar panel for inputs
    sidebarPanel(
      numericInput(inputId = "LotArea", label = "Your House Lot Area", value = 1000, min = 1000, max = 300000, step = 1),
      sliderInput(inputId = "OverallCond", label = "Overall Condition of Home", min = 0, value = 0, step = 1, max = 10),
      numericInput(inputId = "YearBuilt", label = "What Year Was Your House Built?", value = 1850, min = 1850, step = 1),
      numericInput(inputId = "X1stFlrSF", label = "Total Size of Your First Floor in Square Foot", value = 1000, min = 1000, step = 1),
      numericInput(inputId = "X2ndFlrSF", label = "Total Size of Your Second Floor in Square Foot", value = 1000, min = 1000, step = 1),
      sliderInput(inputId = "BsmtFullBath", label = "How Many Fully Completed Basement Bathrooms Do You Have?", min = 0, value = 0, step = 1, max = 5),
      sliderInput(inputId = "FullBath", label = "How Many Fully Completed Bathrooms Do You Have?", min = 0, value = 0, step = 1, max = 5),
      sliderInput(inputId = "TotRmsAbvGrd", label = "How Many of The Rooms In Your House Are Above Grade?", min = 0, value = 0, step = 1, max = 20),
      sliderInput(inputId ="GarageCars", label = "How Many Cars Can You Fit In Your Garage?", min = 0, value = 0, step = 1, max = 5)
      
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      textOutput(outputId = "Predicted")
      
    )
  )
)

shinyUI(ui)