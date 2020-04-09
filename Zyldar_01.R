library(pixmap)
require(graphics)
library(magick)
library(shiny)
library(shinyjs)
library(devtools)
library(image.darknet)
library(image.LineSegmentDetector)
library(image.CornerDetectionF9)
library(image.ContourDetector)

jscode <- "shinyjs.closeWindow = function() { window.close(); }"

ui <- fluidPage(
  useShinyjs(),
  extendShinyjs(text = jscode, functions = c("closeWindow")),
  actionButton("close", "Cerrar sesión"),
  actionButton("actualiza", "Actualizar"),
  actionButton("button0"," Predice"),
  actionButton("button01","Esquinas"),
  actionButton("button02"," Líneas "),
  actionButton("button03","Contorno"),
  actionButton("button1","Cam Dere"),
  actionButton("button2","Cam Izqu"),
  actionButton("button3","Cam Arri"),
  actionButton("button4","Cam Abaj"),
  actionButton("button5","Adelante"),
  actionButton("button6","Retrocede"),
  actionButton("button7","Izquierda"),
  actionButton("button8","Derecha"),
  actionButton("button9","Parar"),
  plotOutput("plot")
  
)
server <- function(input, output, session) {
  con1 <- socketConnection(host="192.168.1.1", port = 2001, blocking=TRUE,
                           server=FALSE, open="r+")
  
  observeEvent(input$close, {
    close(con1)
    js$closeWindow()
    stopApp()
  })
  observeEvent(input$actualiza, {
    output$plot <- renderPlot({
      input$actualiza
      img <- image_read('http://192.168.1.1:8080/?action=snapshot')
      image_write(img, "C:/Users/Edgar/Documents/R/win-library/3.5/image.CornerDetectionF9/extdata/output.jpg")
      plot(img)
    })
  })
  
  observeEvent(input$button0, {
    output$plot <- renderPlot({
      input$button0
      yolo_tiny_voc <- image_darknet_model(type = 'detect', 
                                           model = "tiny-yolo-voc.cfg", 
                                           weights = system.file(package="image.darknet", "models", "tiny-yolo-voc.weights"), 
                                           labels = system.file(package="image.darknet", "include", "darknet", "data", "voc.names"))
      
      img <- image_read('http://192.168.1.1:8080/?action=snapshot')
      image_write(img, "C:/Users/Edgar/Documents/R/win-library/3.5/image.CornerDetectionF9/extdata/output.jpg")
      x <- image_darknet_detect(file = "C:/Users/Edgar/Documents/R/win-library/3.5/image.CornerDetectionF9/extdata/output.jpg", 
                                object = yolo_tiny_voc,
                                threshold = 0.19)
      
      im_predictions <- image_read(path = "predictions.png") 
      plot(im_predictions)
    })
  })
  
  observeEvent(input$button01, {
    output$plot <- renderPlot({
      input$button01
      img <- image_read('http://192.168.1.1:8080/?action=snapshot')
      image_write(img, "C:/Users/Edgar/Documents/R/win-library/3.5/image.CornerDetectionF9/extdata/output.jpg")
      
      x <- image_read(system.file("extdata", "output.jpg", package="image.CornerDetectionF9"))
      x <- image_convert(x, format = "pgm", depth = 8)
      
      ## Save the PGM file
      f <- tempfile(fileext = ".pgm") # 
      image_write(x, path = f, format = "pgm")
      
      ## Read in the PGM grey scale image
      im_hall <- read.pnm(file = f, cellres = 1)
      plot(im_hall)
      
      corners_hall <- image_detect_corners(im_hall@grey*255,
                                           threshold = 25,
                                           suppress_non_max = TRUE)
      
      plot(im_hall)
      points(corners_hall$x, corners_hall$y, col="red", pch = 20, lwd = .5)
    })
  })
  observeEvent(input$button02, {
    output$plot <- renderPlot({
      input$button02
      img <- image_read('http://192.168.1.1:8080/?action=snapshot')
      image_write(img, "C:/Users/Edgar/Documents/R/win-library/3.5/image.CornerDetectionF9/extdata/output.jpg")
      
      x <- image_read(system.file("extdata", "output.jpg", package="image.CornerDetectionF9"))
      x <- image_convert(x, format = "pgm", depth = 8)
      
      ## Save the PGM file
      f <- tempfile(fileext = ".pgm") # 
      image_write(x, path = f, format = "pgm")
      
      ## Read in the PGM grey scale image
      im_hall <- read.pnm(file = f, cellres = 1)
      
      ## Detect the lines
      linesegments <- image_line_segment_detector(im_hall@grey*255)
      linesegments
      
      ## Plot the image + add the lines in red
      plot(im_hall)
      plot(linesegments, add=TRUE, col = "red")
    })
  })
  
  observeEvent(input$button03, {
    output$plot <- renderPlot({
      input$button03
      img <- image_read('http://192.168.1.1:8080/?action=snapshot')
      image_write(img, "C:/Users/Edgar/Documents/R/win-library/3.5/image.CornerDetectionF9/extdata/output.jpg")
      
      x <- image_read(system.file("extdata", "output.jpg", package="image.CornerDetectionF9"))
      x <- image_convert(x, format = "pgm", depth = 8)
      
      ## Save the PGM file
      f <- tempfile(fileext = ".pgm") # 
      image_write(x, path = f, format = "pgm")
      
      ## Read in the PGM grey scale image
      im_hall <- read.pnm(file = f, cellres = 1)
      
      x <- im_hall@grey * 255
      contourlines <- image_contour_detector(x)
      contourlines
      
      plot(im_hall)
      plot(contourlines, add = TRUE, col = "red")
    })
  })
  
  observeEvent(input$button1, {
    num <- "K"
    write_resp <- writeLines(num, con1)
  })
  observeEvent(input$button2, {
    num <- "J"
    write_resp <- writeLines(num, con1)
  })
  observeEvent(input$button3, {
    num <- "I"
    write_resp <- writeLines(num, con1)
  })
  observeEvent(input$button4, {
    num <- "H"
    write_resp <- writeLines(num, con1)
  })
  observeEvent(input$button5, {
    num <- "1"
    write_resp <- writeLines(num, con1)
  })
  observeEvent(input$button6, {
    num <- "4"
    write_resp <- writeLines(num, con1)
  })
  observeEvent(input$button7, {
    num <- "3"
    write_resp <- writeLines(num, con1)
  })
  observeEvent(input$button8, {
    num <- "2"
    write_resp <- writeLines(num, con1)
  })
  observeEvent(input$button9, {
    num <- "5"
    write_resp <- writeLines(num, con1)
  })
}
shinyApp(ui = ui, server = server)