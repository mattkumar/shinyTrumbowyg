library(shiny)
source("trumbowygInput.R")

# define what buttons you would like on the widget
btn_list <- list('strong', 'em', 'underline',
                 'foreColor', 'backColor', 
                 'fontsize',
                 'emoji',
                 'formatting',
                 'undo', 
                 'redo',
                 'superscript', 'subscript',
                 'link',
                 'justifyLeft', 'justifyCenter', 'justifyRight',
                 'unorderedList', 'orderedList',
                 'fullscreen')

# define ui
ui <- fluidPage(
    theme = bs_theme(bootswatch = "sketchy"),
    h4("Enhanced Text Editor PoC"),
    HTML("<p>Create a custom shiny input binding for <a href=\"https://alex-d.github.io/Trumbowyg/\">trumbowyg.js</a> via htmlwidgets</p>"),
    HTML("<p>Add-in a few <a href=\"https://alex-d.github.io/Trumbowyg/documentation/plugins/\">Plugins</a>, such as emoji and color support</p>"),
    trumbowygInput("editor", 
                   label = " ",
                   value = "Hello, world",
                   btns = btn_list),
    br(),
    h4('Sample HTML Output'),
    p('View the underlying html returned from the editor'),
    verbatimTextOutput('html'),
    br(),
    h4('Download as Rmarkdown Report'),
    p('Render the returned html directly into an Rmarkdown document'),
    downloadButton('report','Render Example')
)

# define server
server <- function(input, output, session) {
 
    # render html for viewing
    output$html <- renderPrint(input$editor)
    
    
    # render report
    # https://shiny.rstudio.com/articles/generating-reports.html
    output$report <- downloadHandler(
        filename = "report.html",
        content = function(file) {
            tempReport <- file.path(tempdir(), "report.Rmd")
            file.copy("report.Rmd", tempReport, overwrite = TRUE)
            params <- list(n = input$editor)
            
            # Knit the document, passing in the `params` list, and eval it in a
            # child of the global environment (this isolates the code in the document
            # from the code in this app).
            rmarkdown::render(tempReport, output_file = file,
                              params = params,
                              output_format = rmarkdown::pdf_document(),
                              envir = new.env(parent = globalenv())
            )
        }
    )
}

 

shinyApp(ui = ui, server = server)
