library(shiny)
library(bslib)

my_theme <- bs_theme(
  bootswatch = "darkly", 
  bg = "#000000",
  fg = "#FFFFFF",
  primary = "#ff9900",
  secondary = "#282828",
  base_font = font_google("Inter"),
  heading_font = font_google("Inter")
)


ui <- fluidPage(
  theme = my_theme,
  
  tags$head(
    tags$style(HTML("
      /* Style the sidebar container */
      .well {
        background-color: #1f1f1f; /* Dark gray to contrast with black bg */
        border: 1px solid #333;
        box-shadow: 0 4px 6px rgba(0,0,0,0.5);
      }
      
      /* Style the image output */
      #dynamic_image img {
        border-radius: 8px;
        border: 2px solid #ff9900; /* Orange border */
        box-shadow: 0 0 15px rgba(255, 153, 0, 0.2); /* Subtle orange glow */
        transition: transform 0.3s ease;
      }
      
      /* Subtle hover effect on image */
      #dynamic_image img:hover {
        transform: scale(1.02);
        box-shadow: 0 0 20px rgba(255, 153, 0, 0.4);
      }
      
      /* Custom styles for the VladHub logo text */
      .logo-text {
        font-weight: 700;
        letter-spacing: -1px;
      }
      .hub-badge {
        background-color: #ff9900;
        color: #000000;
        padding: 2px 8px;
        border-radius: 4px;
        margin-left: 2px;
        display: inline-block;
      }
      
      /* Styling the inputs to match */
      .control-label {
        color: #ff9900;
        font-weight: bold;
      }
    "))
  ),
  

  titlePanel(
    windowTitle = "VladHub",
    title = h1(
      class = "logo-text",
      "Vlad", 
      span(class = "hub-badge", "Hub")
    )
  ),
  
  sidebarLayout(
    sidebarPanel(
      h4("Control Panel"),
      p("Select an option below to update the image on the right."),
      
      selectInput(inputId = "image_selector",
                  label = "Choose an Image:",
                  choices = c("Vlad Efremov",
                              "Vlad Forshakov", 
                              "Vlad Yavorski"))
    ),
    mainPanel(
      h3("Image Display", style = "border-bottom: 1px solid #333; padding-bottom: 10px;"),
      br(),
      imageOutput(outputId = "dynamic_image")
    )
  )
)

server <- function(input, output) {
    output$dynamic_image <- renderImage({
    
    # Define the file path based on selection
    # NOTE: Replace these filenames with your actual local image paths
    # If images are in a subfolder named 'images', use: file.path("images", "my_image.png")
    filename <- switch(input$image_selector,
                       "Vlad Forshakov"  = file.path("assets","vlad1.png"),
                       "Vlad Efremov"    = file.path("assets","vlad2.png"),
                       "Vlad Yavorski"   = file.path("assets","vlad3.png")
                      )
    # Return a list containing the filename and other attributes
    list(src = filename,
         contentType = 'image/png', # Change to 'image/jpeg' if using .jpg files
         width = 400,
         height = 400,
         alt = paste("Image of a", input$image_selector))
    
  }, deleteFile = FALSE) # IMPORTANT: deleteFile must be FALSE when using your own local files
}

# Run the application 
shinyApp(ui = ui, server = server)