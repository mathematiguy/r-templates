library(shiny)
library(shinyWidgets)
library(shinyjs)
library(data.table)
library(shinydashboard)
library(ggplot2)
library(grid)
library(gridExtra)
library(cowplot)

source('functions.r')

options(warn = 1)

load('data/data.rdata', v=F)

input <- list(iter       = 117)

## * SERVER
shinyServer(function(input, output, session) {

    output$param <- renderUI(sliderInput("param", label = "Parameter", min = 1, max = 10, value = 5))

    ## observeEvent(input$nextbutt, {
    ##     updateSliderInput(session, "iter", value = input$iter + 1)
    ## })

    ## * Posteriors
    output$a_plot <- renderPlot({

        ggplot(dat_plot, aes(x = x, y = y, colour = z)) +
            geom_point() +
            theme_minimal()

    })

    output$a_table <- DT::renderDataTable({
        DT::datatable(dat_table,
                      escape = T,
                      options = list(autoWidth = FALSE, paging = TRUE, searching = TRUE, info=TRUE,
                                     pageLength = 30, scrollX = TRUE),
                      filter = 'top',
                      class = 'nowrap hover compact',
                      rownames = F,
                      selection = 'single',
                      fillContainer=FALSE)
        }
    )

    ## output$keepAlive <- renderText({
    ##   req(input$count)
    ##   paste("keep alive ", input$count)
    ## })
    
})
