
fluidPage(
    
  # Copy the line below to make a select box 
 selectInput("select", label = h3("Which Sector?"), 
    choices = list("Agriculture" = 1, "Agriculture_allied_services" = 2, "Industry" = 3, "Mining_and_quarrying" = 4, "Manufacturing"  =5,"Services" =6, "Financial_year" =7, "Financial_year" =8), 
    selected = 1)
  
  hr(),
  fluidRow(column(3, verbatimTextOutput("value")))
  
)