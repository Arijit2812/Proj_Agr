# Import R packages needed for the app here:
library(shiny)
library(DT)
library(RColorBrewer)
library(shinyFiles)

# Define any Python packages needed for the app here:
PYTHON_DEPENDENCIES = c('pip', 'numpy', 'mrcnn', 'matplotlib')

# Begin app server
shinyServer(function(input, output, session) {
  
  # Import python functions to R
  reticulate::source_python('python_functions_rcnn_shape.py')
  reticulate::source_python('python_functions_rcnn_growth.py')
  reticulate::source_python('python_functions_rcnn_heel.py')
  reticulate::source_python('python_functions_rcnn_fetlock.py')
  reticulate::source_python('python_functions_rcnn_splay.py')
  
  hoof_data <- reactiveValues()
  observeEvent(input$myFile, {
    inFile <- input$myFile
    if (is.null(inFile))
      return()
    # print(inFile)
    hoof_data$hoof_image_tmp <- tempfile(fileext='.JPG')
    file.copy(inFile$datapath, hoof_data$hoof_image_tmp, overwrite=TRUE)
  })
  
  # Test that the Python functions have been imported
  output$myImage <- renderPlot({
#    if (input$aspect == "Shape") {
#        test_shape_image('C:/Users/BhattacharjeeA/shiny-reticulate-app/test1.JPG')
#        } else if (input$aspect == "Growth") {
#          test_growth_image('C:/Users/BhattacharjeeA/shiny-reticulate-app/test11.JPG')
#          }
    
#    test_image('C:/Users/BhattacharjeeA/shiny-reticulate-app/test11.JPG')
    if (!is.null(hoof_data$hoof_image_tmp)) {
      withProgress(message = 'Making plot', {
        if (input$aspect == "Shape") {
          test_shape_image(hoof_data$hoof_image_tmp)
        } else if (input$aspect == "Growth") {
          test_growth_image(hoof_data$hoof_image_tmp)
        } else if (input$aspect == "Heel") {
          test_heel_image(hoof_data$hoof_image_tmp)
        } else if (input$aspect == "Fetlock") {
          test_fetlock_image(hoof_data$hoof_image_tmp)
        } else if (input$aspect == "Splay") {
          test_splay_image(hoof_data$hoof_image_tmp)
        }
#        test_image(hoof_data$hoof_image_tmp)
      })
    }
  })
  
  output$myResult <- renderUI({
    if (!is.null(hoof_data$hoof_image_tmp)) {
      withProgress(message = 'Making plot', {
        if (input$aspect == "Shape") {
          test_shape_result(hoof_data$hoof_image_tmp)
        } else if (input$aspect == "Growth") {
          test_growth_result(hoof_data$hoof_image_tmp)
        } else if (input$aspect == "Heel") {
          test_heel_result(hoof_data$hoof_image_tmp)
        } else if (input$aspect == "Fetlock") {
          test_fetlock_result(hoof_data$hoof_image_tmp)
        } else if (input$aspect == "Splay") {
          test_splay_result(hoof_data$hoof_image_tmp)
        }
      })
    }
  })
  
})