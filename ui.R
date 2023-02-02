# Import R packages needed for the UI
library(shiny)
library(shinycssloaders)
library(DT)

ui <- fluidPage(
  
  titlePanel('Hoof conformation'),
  
  sidebarLayout(
    
    # ---------------- Sidebar panel with changeable inputs ----------------- #
    sidebarPanel(
      
      h4('Select Hoof aspect'),
      radioButtons(inputId = "aspect", label = "Hoof aspect", 
                  choices = c("Shape", "Splay", "Growth","Heel", "Fetlock"), selected = "Shape"),
      h4('Select a file'),
      fileInput("myFile", "Choose an image file",
                multiple = TRUE,
                accept = c("image/png",
                           "image/jpeg",
                           ".JPG")),
#      br(),
#      sliderInput('n',
#                  'Number of pics:',
#                  value = 1,
#                  min = 1,
#                  max = 10),
#      hr()
    ),
    
    # ---------------- Sidebar panel with changeable inputs ----------------- #
    mainPanel(
      
      # Output: Image output ----
      plotOutput('myImage'),
      br(),
      uiOutput('myResult')
    )
  )
)