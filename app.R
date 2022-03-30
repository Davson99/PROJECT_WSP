
# Ładowanie bibliotek
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyFiles)
library(DT)

# Ustalenie rozmiaru pliku wejsciowego
options(shiny.maxRequestSize = 30*1024^2)

ui <- dashboardPage(
    skin = ("purple"),
    
    # Pasek górny 
    dashboardHeader(title = span(tagList(icon("gitkraken"),"Klasyfikator"))), 
    
    # Pasek boczny
    dashboardSidebar(sidebarMenuOutput("Semi_collapsible_sidebar")),
    
    # Ustalenie stylu 
    dashboardBody(tags$head(tags$link(rel = "stylesheet",
                                      type = "text/css", href = "style.css")),
                  
                  
                  tabItems(
                      
                      tabItem(tabName = "home",
                              
                              fluidRow(
                                  box( title = span(tagList(icon("dna"), "Przykladowa aplikacja do klasyfikcji"), style="color:gray"), background = "gray",width = 12,
                                       br(),
                                       "Tutaj mozna zamiescic niezbedne informacje",
                                       style="text-align: justify; color:gray" ))),
                    
                  
                      tabItem(tabName = "subitem_wynik",

                              # Ładowanie pliku do klasyfikacji
                              column(width=10, offset= 0, box(title="Klasyfikacja", width=10,
                                                              fileInput("file1", "Zaladuj dane do klasyfikacji",
                                                                        accept = c(
                                                                            "text/csv",
                                                                            "text/comma-separated-values,text/plain",
                                                                            ".csv"),
                                                                        buttonLabel = "Wybierz plik",
                                                                        placeholder = "Nie wybrano pliku"),
                                                              
                                                              # Parametry do klasyfikatora
                                                              h4("Wprowadz parametry klasyfikatora"),
                                                              p("Tu nalezy umiescic inputy do tych parametrow"),
                                                              
                                                              # Przycisk do pobrania wyników CSV
                                                              tags$b("Wynik klasyfikacji"), 
                                                              br(),
                                                              downloadButton("download_tabela", "Tabela wynikow (.xlsx)", class = "butt"),
                                                              tags$head(tags$style(".butt{background-color:#bcbbbd;} .butt{color: white;}")),
                                                              br(),
                                                              br() ) ),
                              
                            # Wynik klasyfikacji
                              column(width=10, 
                                     dataTableOutput("wynik"))),
                      
                      # Wizualizacja
                      tabItem(tabName = "subitem_wizualizacja",
                              
                              fluidRow(
                                  box( title = span(tagList(icon("dna"), "Wizualizacja"), style="color:gray"), background = "gray", width = 12,
                                       br(),
                                       "Tutaj mozna zamiescic wizualizacje wynikow",
                                       style="text-align: justify; color:gray" ))))))

server <- function(input, output, session) {
    
    # Zdefiniowanie menu
    output$Semi_collapsible_sidebar=renderMenu({
        sidebarMenu(
            menuItem("Home", tabName = "home", icon = icon("home")),
            
            menuItem("Klasyfikacja", icon = icon("list-alt"),
                     menuSubItem("Proces klasyfikacji", tabName = "subitem_wynik"),
                     menuSubItem("Wizualizacja", tabName = "subitem_wizualizacja")))
    })
    
    # Wyswietlenie wyniku klasyfikacji
    output$wynik <- renderDataTable({
        
        # Zadanie warunku "Zwracaj null dopoki nie zostanie zaladowany plik z danymi"
        inFile <- input$file1
        if (is.null(inFile))
            return(NULL)
        
        # Ponizsza linia wyswietla wynik na sztywno, wylacznie w celu prezentacji. W tym miejscu trzeba pozniej wprowadzic odpowiedni kod
        newFile <- read.table("./przykładowy_wynik_klasyfikacji_format.csv", sep = ";", header  = TRUE)
        
    })
  
}

# Uruchom aplikacje
shinyApp(ui = ui, server = server)
