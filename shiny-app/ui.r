library(data.table)
library(shiny)
library(shinyWidgets)
library(shinyjs)
library(shinydashboard)
library(DT)
library(leaflet)
library(rhandsontable)

addResourcePath('data', 'data')

app_title <- 'App Title'

function(request) {
    
    loadingLogo <- function(href, src, loadingsrc, height = NULL, width = NULL, alt = NULL) {
        tagList(
            tags$head(
                     tags$script(
                              "setInterval(function(){
                     if ($('html').attr('class')=='shiny-busy') {
                     $('div.busy').show();
                     $('div.notbusy').hide();
                     } else {
                     $('div.busy').hide();
                     $('div.notbusy').show();
           }
         },100)")
         )
         , div(class = "busy",  
             img(src=loadingsrc, height = height, width = width, alt = alt))
         , div(class = 'notbusy',
               div(class = 'logo', app_title))
        )
    }

    dashboardPage(
        title = app_title,
        header = dashboardHeader(
            title = loadingLogo('http://www.google.co.nz',
                                'data/logo.png',
                                'data/out.gif')
        )

      , sidebar = dashboardSidebar(
            tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "custom.css"))
          , tags$head(
                     HTML(
                         "
          <script>
          var socket_timeout_interval
          var n = 0
          $(document).on('shiny:connected', function(event) {
          socket_timeout_interval = setInterval(function(){
          Shiny.onInputChange('count', n++)
          }, 15000)
          });
          $(document).on('shiny:disconnected', function(event) {
          clearInterval(socket_timeout_interval)
          });
          </script>
          "
          )
          )
        , uiOutput('param')
        )
        
      , body = dashboardBody(
            width = 12
          , useShinyjs()
          , h2('Hello there!')
          , br()
          , fluidRow(
                column(6
                     , plotOutput('a_plot', height='600px')
                       ),
                column(6
                     , DT::dataTableOutput('a_table')
                       )
            )
        )
    )
}
