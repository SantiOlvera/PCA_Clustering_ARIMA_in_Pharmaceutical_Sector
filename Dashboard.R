library(shiny)
library(shinydashboard)
library(readr)
library(tidyr)
library(dplyr)
library(factoextra)
library(corrplot)

ui <- dashboardPage(
  dashboardHeader(title = "Análisis de Empresas"),
  dashboardSidebar(
    sidebarMenu(
      selectInput("industry", "Seleccione una industria", 
                  choices = c("Salud", "Comunicación/Entretenimiento")),
      menuItem("Empresas", tabName = "empresas"),
      menuItem("Matriz de Correlación", tabName = "correlacion"),
      menuItem("PCA", tabName = "pca"),
      menuItem("Clustering", tabName = "clustering")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "empresas",
              h2("Empresas analizadas"),
              uiOutput("company_images")
      ),
      tabItem(tabName = "correlacion",
              h2("Matriz de Correlación"),
              plotOutput("correlacion_plot")
      ),
      tabItem(tabName = "pca",
              h2("Gráficas de PCA"),
              plotOutput("pca_screeplot"),
              plotOutput("pca_biplot"),
              plotOutput("pca_contrib_1"),
              plotOutput("pca_contrib_2"),
              plotOutput("pca_contrib_3")
      ),
      tabItem(tabName = "clustering",
              h2("Gráficas de Clustering"),
              plotOutput("clustering_optimal"),
              tabBox(
                title = "Clustering",
                id = "tabset1", height = "250px",
                tabPanel("Con PCA", 
                         plotOutput("clustering_pca"),
                         plotOutput("silhouette_pca")
                ),
                tabPanel("Sin PCA", 
                         plotOutput("clustering_no_pca"),
                         plotOutput("silhouette_no_pca")
                )
              )
      )
    )
  )
)

server <- function(input, output) {
  
  # Lectura y procesamiento de datos
  health_companies <- c('UNH','JNJ','LLY','ABBV','PFE','MRK','TMO','ABT','DHR','BMY', 'AMGN','ISRG', 'SYK', 'ELV', 'VRTX', 'MDT', 'BSX', 'REGN', 'CI', 'HCA', 'GILD', 'ZTS', 'MCK', 'CSV', 'BDX','EW', 'DXCM', 'MRNA', 'A', 'IDXX', 'COR', 'HUM', 'IQV', 'CNC', 'GEHC','BIIB', 'MTD', 'RMD', 'WST','ZBH')
  
  communication_companies <- c('META', 'GOOGL', 'NFLX', 'AAPL', 'T', 'TMUS', 'CMCSA', 'CHTR', 'PARA', 'WBD', 'LYV', 'UNVGY')
  
  Razones_Financieras <- reactive({
    if (input$industry == "Salud") {
      dfs <- list(
        A = read_csv("./financial_ratios/A_financial_ratios.csv"),
        ABBV = read_csv("./financial_ratios/ABBV_financial_ratios.csv"),
        ABT = read_csv("./financial_ratios/AMGN_financial_ratios.csv"),
        AMGN = read_csv("./financial_ratios/ABT_financial_ratios.csv"),
        BDX = read_csv("./financial_ratios/BDX_financial_ratios.csv"),
        BIIB = read_csv("./financial_ratios/BIIB_financial_ratios.csv"),
        BMY = read_csv("./financial_ratios/BMY_financial_ratios.csv"),
        BSX = read_csv("./financial_ratios/BSX_financial_ratios.csv"),
        CNC = read_csv("./financial_ratios/CNC_financial_ratios.csv"),
        COR = read_csv("./financial_ratios/COR_financial_ratios.csv"),
        CSV = read_csv("./financial_ratios/CSV_financial_ratios.csv"),
        DHR = read_csv("./financial_ratios/DHR_financial_ratios.csv"),
        DXCM = read_csv("./financial_ratios/DXCM_financial_ratios.csv"),
        EW = read_csv("./financial_ratios/EW_financial_ratios.csv"),
        GEHC = read_csv("./financial_ratios/GEHC_financial_ratios.csv"),
        GILD = read_csv("./financial_ratios/GILD_financial_ratios.csv"),
        HCA = read_csv("./financial_ratios/HCA_financial_ratios.csv"),
        IDXX = read_csv("./financial_ratios/IDXX_financial_ratios.csv"),
        IQV = read_csv("./financial_ratios/IQV_financial_ratios.csv"),
        JNJ = read_csv("./financial_ratios/JNJ_financial_ratios.csv"),
        LLY = read_csv("./financial_ratios/LLY_financial_ratios.csv"),
        MCK = read_csv("./financial_ratios/MCK_financial_ratios.csv"),
        MDT = read_csv("./financial_ratios/MDT_financial_ratios.csv"),
        MRK = read_csv("./financial_ratios/MRK_financial_ratios.csv"),
        MTD = read_csv("./financial_ratios/MTD_financial_ratios.csv"),
        PFE = read_csv("./financial_ratios/PFE_financial_ratios.csv"),
        REGN = read_csv("./financial_ratios/REGN_financial_ratios.csv"),
        RMD = read_csv("./financial_ratios/RMD_financial_ratios.csv"),
        TMO = read_csv("./financial_ratios/TMO_financial_ratios.csv"),
        UNH = read_csv("./financial_ratios/UNH_financial_ratios.csv"),
        WST = read_csv("./financial_ratios/DHR_financial_ratios.csv"),
        ZBH = read_csv("./financial_ratios/DHR_financial_ratios.csv"),
        ZTS = read_csv("./financial_ratios/DHR_financial_ratios.csv")
      )
    } else {
      dfs <- list(
        META = read_csv("./financial_ratios_com/META_financial_ratios.csv"),
        GOOGL = read_csv("./financial_ratios_com/GOOGL_financial_ratios.csv"),
        NFLX = read_csv("./financial_ratios_com/NFLX_financial_ratios.csv"),
        AAPL = read_csv("./financial_ratios_com/AAPL_financial_ratios.csv"),
        T = read_csv("./financial_ratios_com/T_financial_ratios.csv"),
        TMUS = read_csv("./financial_ratios_com/TMUS_financial_ratios.csv"),
        CMCSA = read_csv("./financial_ratios_com/CMCSA_financial_ratios.csv"),
        CHTR = read_csv("./financial_ratios_com/CHTR_financial_ratios.csv"),
        PARA = read_csv("./financial_ratios_com/PARA_financial_ratios.csv"),
        WBD = read_csv("./financial_ratios_com/WBD_financial_ratios.csv"),
        LYV = read_csv("./financial_ratios_com/LYV_financial_ratios.csv"),
        UNVGY = read_csv("./financial_ratios_com/UNVGY_financial_ratios.csv")
      )
    }
    
    razones_financieras <- bind_rows(lapply(names(dfs), function(name) transform_df(dfs[[name]], name)))
    
    razones_financieras <- subset(razones_financieras, select = -c(InvAct, rotinv, diainv, diacxc))
    
    razones_financieras[, -1] <- lapply(razones_financieras[, -1], function(x) as.numeric(as.character(x)))
    
    razones_financieras <- na.omit(razones_financieras)
    
    rownames(razones_financieras) <- razones_financieras$Company
    
    rownames_vec <- rownames(razones_financieras)
    
    razones_financieras <- razones_financieras[, -1]
    
    rownames(razones_financieras) <- rownames_vec
    
    razones_financieras
  })
  
  transform_df <- function(df, company_name) {
    df %>%
      rename(Razóm = Razón, Valor = Valor) %>%
      pivot_wider(names_from = Razóm, values_from = Valor) %>%
      mutate(Company = company_name) %>%
      select(Company, everything())
  }
  
  output$company_images <- renderUI({
    companies <- if (input$industry == "Salud") health_companies else communication_companies
    folder <- if (input$industry == "Salud") "health_images" else "communication_images"
    
    fluidRow(
      lapply(companies, function(company) {
        box(
          title = company,
          status = "primary",
          solidHeader = TRUE,
          width = 2,
          imageOutput(paste0(company, "_image"), height = 100)
        )
      })
    )
  })
  
  observe({
    companies <- if (input$industry == "Salud") health_companies else communication_companies
    folder <- if (input$industry == "Salud") "health_images" else "communication_images"
    
    lapply(companies, function(company) {
      output[[paste0(company, "_image")]] <- renderImage({
        list(src = paste0("./", folder, "/", company, ".jpg"),
             contentType = "image/jpeg",
             width = "100%",
             height = "100%")
      }, deleteFile = FALSE)
    })
  })
  
  observeEvent(input$industry, {
    output$correlacion_plot <- renderPlot({
      R <- cor(Razones_Financieras(), use = "pairwise.complete.obs")
      corrplot(R, type = "upper", method = "ellipse", tl.cex = 0.9)
    })
    
    comp_principales <- reactive({
      prcomp(Razones_Financieras(), rank. = 3)
    })
    
    output$pca_screeplot <- renderPlot({
      fviz_screeplot(comp_principales())
    })
    
    output$pca_biplot <- renderPlot({
      fviz_pca_biplot(comp_principales(), repel = T, geom.ind = "point")
    })
    
    output$pca_contrib_1 <- renderPlot({
      fviz_contrib(comp_principales(), choice = "var", axes = 1)
    })
    
    output$pca_contrib_2 <- renderPlot({
      fviz_contrib(comp_principales(), choice = "var", axes = 2)
    })
    
    output$pca_contrib_3 <- renderPlot({
      fviz_contrib(comp_principales(), choice = "var", axes = 3)
    })
    
    prueba2 <- reactive({
      comp_principales()$x
    })
    
    optimal_clusters <- reactive({
      if (input$industry == "Salud") 3 else 2
    })
    
    output$clustering_optimal <- renderPlot({
      fviz_nbclust(prueba2(), FUNcluster = kmeans, k.max = 8)
    })
    
    kmeans1 <- reactive({
      eclust(prueba2(), "kmeans", hc_metric = "eucliden", k = optimal_clusters())
    })
    
    output$clustering_pca <- renderPlot({
      fviz_cluster(kmeans1())
    })
    
    output$silhouette_pca <- renderPlot({
      fviz_silhouette(kmeans1())
    })
    
    kmeans2 <- reactive({
      eclust(Razones_Financieras(), "kmeans", hc_metric = "eucliden", k = optimal_clusters())
    })
    
    output$clustering_no_pca <- renderPlot({
      fviz_cluster(kmeans2())
    })
    
    output$silhouette_no_pca <- renderPlot({
      fviz_silhouette(kmeans2())
    })
  })
}

shinyApp(ui, server)
