# define input
trumbowygInput <- function(inputId, label = NULL, value = "", ...) {
  htmltools::tagList(
    htmltools::htmlDependency(
      name    = "trumbowygInput"
      , version = "0.0.1"
      , src = "inst"
      , script = "trumbowyg.min.js"
      , stylesheet = "trumbowyg.min.css",
      , attachment = "icons.svg"
    ),
    htmltools::htmlDependency(
      name    = "trumbowygColors"
      , version = "0.0.1"
      , src = "inst"
      , script = "trumbowyg.colors.min.js"
      , stylesheet = "trumbowyg.colors.min.css"
    ),
    htmltools::htmlDependency(
      name    = "trumbowygEmoji"
      , version = "0.0.1"
      , src = "inst"
      , script = "trumbowyg.emoji.min.js"
    ),
    htmltools::htmlDependency(
      name    = "trumbowygFontsize"
      , version = "0.0.1"
      , src = "inst"
      , script = "trumbowyg.fontsize.min.js"
    ),
    htmltools::htmlDependency(
      name    = "trumbowyg_binding"
      , version = "0.0.1"
      , src = "inst"
      , script = "trumbowyg_binding.js"
    ),
    if (!is.null(label)) shiny::tags$label(`for` = inputId, label),
    tags$script("$.trumbowyg.svgPath = 'trumbowygInput-0.0.1/icons.svg';"),
    shiny::tags$div(class = "trumbowygInput", id = inputId, style = "height: 200px;",
                    `data-options` = jsonlite::toJSON(list(...), auto_unbox = F), 
                    value)
  )
}
