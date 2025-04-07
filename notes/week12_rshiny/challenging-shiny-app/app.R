library(tidyverse)
library(shiny)
library(stringr)
library(ggplot2)
source("./modules.R")

# Define UI for application that draws a histogram

ui <- fluidPage(theme = "flatly.css", tags$style(type = "text/css", ".irs-grid-pol.small {height: 0px;}"),

                # Application title
                titlePanel("The Challenging Nostalgia and Performance Metrics in Baseball Project"),
                tags$p("Author: ", tags$a("Daniel J. Eck", href = "https://ecklab.github.io/")), 
                br(),
                tags$p("Objectively ranking or comparing baseball players across eras remains one of the 
                       most interesting problems for baseball fans, historians, and statisticians alike. 
                       There exist several conventional statistical approaches, several advanced 
                       statistical approaches, and several more anecdotal approaches that claim to 
                       solve this complex ranking task. I have investigated many of these approaches 
                       and have found that they have collectively failed to deliver on their claims 
                       to objectively compare players across eras. The simple explanation is that existing 
                       approaches do not properly account for the changing (improving) talent pool 
                       from which MLB players are drawn from."),
                       
                tags$p("In particular, rakings lists of baseball's greatest players include more players 
                from the past than what is expected. The reason for this is twofold: 
                       1) nostalgic memory is biased; 
                       2) statistical techniques compare players vs their peers, and this type of 
                       methodology exhibits biases when the distribution of talent changes (improves). 
                For more details, see my FanGraphs article", 
                tags$a("Challenging WAR and Other Statistics as Era-Adjustment Tools", 
                  href = "https://community.fangraphs.com/challenging-war-and-other-statistics-as-era-adjustment-tools/"), 
                "or my paper on this subject", tags$a("Challenging nostalgia and performance metrics in baseball.", 
                  href = "https://www.tandfonline.com/doi/full/10.1080/09332480.2020.1726114"),
                " My paper is behind a paywall.", 
                tags$a("Here", 
                  href = "https://github.com/DEck13/baseball_research/blob/master/Challenging_nostalgia/reproducible-analysis.pdf"),
                "is a link to a free version of the published paper that also provides the calculations 
                in the analysis."),
                
                tags$p("This webpage contains a Shiny app that is meant to be a fun tool which 
                demonstrates how problematic performance metrics (WAR) and nostalgia (fan and media polls) 
                are at assessing baseball's greatest players from a pure talent perspective. In addition, 
                this application allows you the user to play around and conduct your own analyses."),

                tags$p("The table below displays baseball's all-time greatest players according to five 
                sources. The first and second sources are, respectively, baseball references's wins 
                above replacement (bWAR) and Fangraph's wins above replacement (fWAR). WAR is a 
                one-number summary of a player's aggregate value. The third source is from ESPN, 
                it is a proxy measure for the overall rankings among sports journalists. The fourth list is 
                from the", tags$a("Hall of Stats,", href = "http://www.hallofstats.com/"), " an 
                organization that \"shows us what the Hall of Fame would look like if we removed 
                all 235 inductees and replaced them with the top 235 eligible players in history, 
                according to a mathematical formula.\" The fifth source is from Joe Posnanski's The 
                Baseball 100 book. We only consider NL/AL players from Posnanski's list so that his list 
                is comparable with the others. We applaud his efforts to include Negro League legends in the 
                upper echelon of baseball greatness, and we think he will end up being on the right side of 
                history."),  
                
                tags$p("Players who started their career in 1950 or before appear in bold 
                text. The year 1950 is chosen because it is the closest Census collection 
                year to when baseball was integrated in 1947. The year 1950 is also close to the midpoint 
                of professional baseball (this sentence was written in 2022)."),
                
                br(),
                
        tags$head(tags$style(
         'tr:nth-child(1) {
           border: solid thick;
          }

          tr:nth-child(2) {
            border: solid thick;
          }

          table { 
            width: 80%;
            cellpadding: 2px;
            display: table;
            border-collapse: separate;
            white-space: normal;
            line-height: normal;
            font-weight: normal;
            font-size: medium;
            font-style: normal;
            color: -internal-quirk-inherit;
            text-align: start;
            border-spacing: 2px;
            font-variant: normal;
          }  

          td {
            display: table-cell;
            vertical-align: inherit;
          }

          tr {
            display: table-row;
            vertical-align: inherit;
          }'
        )),
        
                tags$div(
                  HTML("
        <table>
          <thead>
            <tr><th>rank</th><th>bWAR</th><th>fWAR</th><th>ESPN</th><th>Hall of Stats</th><th>Posnanski</th></tr>
          </thead>
          <tbody>
<tr><td>1</td>  <td><strong>Babe Ruth</strong></td> 
                <td><strong>Babe Ruth</strong></td>
                <td><strong>Babe Ruth</strong></td>
                <td><strong>Babe Ruth</strong></td>
                <td>Willie Mays</td></tr>
<tr><td>2</td>  <td><strong>Walter Johnson</strong></td>
                <td>Barry Bonds</td>
                <td>Willie Mays</td>
                <td>Barry Bonds</td>
                <td><strong>Babe Ruth</strong></tr>
<tr><td>3</td>  <td><strong>Cy Young</strong></td>
                <td>Willie Mays</td>
                <td>Hank Aaron</td>
                <td><strong>Walter Johnson</strong></td>
                <td>Barry Bonds</td></tr>
<tr><td>4</td>  <td>Barry Bonds</td> 
                <td><strong>Ty Cobb</strong></td>
                <td><strong>Ty Cobb</strong></td>
                <td>Willie Mays</td>
                <td>Hank Aaron</td></tr>
<tr><td>5</td>  <td>Willie Mays</td> 
                <td><strong>Honus Wagner</strong></td>
                <td><strong>Ted Williams</strong></td>
                <td><strong>Cy Young</strong></td>
                <td><strong>Ted Williams</strong></td></tr>
<tr><td>6</td>  <td><strong>Ty Cobb</strong></td>
                <td>Hank Aaron</td>
                <td><strong>Lou Gehrig</strong></td>
                <td><strong>Ty Cobb</strong></td>
                <td><strong>Walter Johnson</strong></td></tr>
<tr><td>7</td>  <td>Hank Aaron</td>
                <td>Roger Clemens</td>
                <td>Mickey Mantle</td>
                <td>Hank Aaron</td>
                <td><strong>Ty Cobb</strong></td></tr>
<tr><td>8</td>  <td>Roger Clemens</td>
                <td><strong>Cy Young</strong></td>
                <td>Barry Bonds</td>
                <td>Roger Clemens</td>
                <td><strong>Stan Musial</strong></td></tr>
<tr><td>9</td>  <td><strong>Tris Speaker</strong></td>
                <td><strong>Tris Speaker</strong></td>
                <td><strong>Walter Johnson</strong></td>
                <td><strong>Rogers Hornsby</strong></td>
                <td>Mickey Mantle</td></tr>
<tr><td>10</td> </td><td><strong>Honus Wagner</strong></td>
                <td><strong>Ted Williams</strong></td>
                <td><strong>Stan Musial</strong></td>
                <td><strong>Honus Wagner</strong></td>
                <td><strong>Honus Wagner</strong></td></tr>
<tr><td>11</td> <td><strong>Stan Musial</strong></td>
                <td><strong>Rogers Hornsby</strong></td>
                <td>Pedro Martinez</td>
                <td><strong>Tris Speaker</strong></td>
                <td>Roger Clemens</td></tr>
<tr><td>12</td> <td><strong>Rogers Hornsby</strong></td>
                <td><strong>Stan Musial</strong></td>
                <td><strong>Honus Wagner</strong></td>
                <td><strong>Ted Williams</strong></td>
                <td><strong>Lou Gehrig</strong></td></tr>
<tr><td>13</td> <td><strong>Eddie Collins</strong></td>
                <td><strong>Eddie Collins</strong></td>
                <td>Ken Griffey Jr.</td>
                <td><strong>Stan Musial</strong></td>
                <td>Alex Rodriguez</td></tr>
<tr><td>14</td> <td><strong>Ted Williams</strong></td>
                <td><strong>Walter Johnson</strong></td>
                <td>Greg Maddux</td>
                <td><strong>Eddie Collins</strong></td>
                <td><strong>Rogers Hornsby</strong></td></tr>
<tr><td>15</td> <td><strong>Pete Alexander</strong></td>
                <td>Greg Maddux</td>
                <td>Mike Trout</td>
                <td><strong>Pete Alexander</strong></td>
                <td><strong>Tris Speaker</strong></td></tr>
<tr><td>16</td> <td>Alex Rodriguez</td>
                <td><strong>Lou Gehrig</strong></td>
                <td><strong>Joe DiMaggio</strong></td>
                <td>Alex Rodriguez</td>
                <td>Mike Schmidt</td></tr>
<tr><td>17</td> <td><strong>Kid Nichols</strong></td>
                <td>Alex Rodrgiuez</td>
                <td>Roger Clemens</td>
                <td><strong>Lou Gehrig</strong></td>
                <td>Frank Robinson</td></tr>
<tr><td>18</td> <td><strong>Lou Gehrig</strong></td> 
                <td>Mickey Mantle</td>
                <td>Mike Schmidt</td>
                <td>Mickey Mantle</td>
                <td>Joe Morgan</td></tr>
<tr><td>19</td> <td>Rickey Henderson</td> 
                <td><strong>Mel Ott</strong></td>
                <td>Frank Robinson</td>
                <td><strong>Lefty Grove</strong>
                <td><strong>Lefty Grove</strong></tr>
<tr><td>20</td> <td><strong>Mel Ott</strong></td>
                <td>Randy Johnson</td>
                <td><strong>Rogers Hornsby</strong></td>
                <td><strong>Mel Ott</strong></td>
                <td>Albert Pujols</td></tr>
<tr><td>21</td> <td>Mickey Mantle</td>
                <td>Nolan Ryan</td>
                <td><strong>Cy Young</strong></td>
                <td>Rickey Henderson</td>
                <td>Rickey Henderson</td></tr>
<tr><td>22</td> <td>Tom Seaver</td>
                <td>Mike Schmidt</td>
                <td>Tom Seaver</td>
                <td><strong>Kid Nichols</strong></td>
                <td><strong>Pete Alexander</strong></td></tr>
<tr><td>23</td> <td>Frank Robinson</td>
                <td>Rickey Henderson</td>
                <td>Rickey Henderson</td>
                <td>Mike Schmidt</td>
                <td>Mike Trout</td></tr>
<tr><td>24</td> <td><strong>Nap Lajoie</strong></td>
                <td>Frank Robinson</td>
                <td>Randy Johnson</td>
                <td><strong>Nap Lajoie</strong></td>
                <td>Randy Johnson</td></tr>
<tr><td>25</td> <td>Mike Schmidt</td>
                <td>Bert Blyleven</td>
                <td><strong>Christy Mathewson</strong></td>
                <td><strong>Christy Mathewson</strong></td>
                <td><strong>Eddie Collins</strong></td></tr>



        </tbody>
      </table>")
                ),
                
                br(),
                tags$h2("Your analysis"),
                
                tags$div(
                  tags$p("The displays below allow you to conduct your own analysis on the believability 
                  of each of the all-time rankings that are posted above. The idea is that you get to 
                  build your own MLB eligible population by first selecting countries that play baseball 
                  and then specifying what percentage of that country's population contributes to the 
                  overall baseball talent pool. Your percentages reflect a countries overall interest in 
                  baseball and access to the MLB. Computer scripts take your specifications, build your 
                  MLB eligible population from UN Census data, and then compute the chance that each of 
                  the above all-time rankings could occur in an era-neutral league in which all players 
                  play under the same conditions. This chance is 1/p where p is the probability of 
                  observing at least x players whose career began in 1950 or before in each of the 
                  all-time rankings that are posted above.")),

                tags$div(
                  tags$p("The sliders specify each regions' interest in baseball (measured in percentage 
                  points). All interest is for the period 1960 and after, unless specifically mentioned. 
                  Exceptions include East Asian countries and Brazil. East Asian countries' baseball 
                  interest are for the period 2000 and after, and Brazil's baseball interest is for the 
                  period 2010 and after. These periods roughly reflect when players from these countries 
                  began joining the MLB."),

                  tags$p("The default settings of the slider bars correspond to national and 
                  international baseball interest, and the default countries selected were included in 
                  the original analysis. You have the ability to add Oceanic countries and a general 
                  world country meant to encapsulate the baseball interest beyond the specific countries 
                  under study."
                  )),
        
                br(),
                
                fluidRow(
                  column(3, 
                         # use regions as option groups
                         selectizeInput('countries', 'Countries', choices = list(
                           ####### Original Analysis
                           "Aruba", "Bahamas", "Brazil", "Colombia", "Cuba", "Dominican Republic", "Honduras", 
                           "Jamaica", "Japan", "Mexico", "Netherlands Antilles", "Nicaragua", "Panama", 
                           "Philippines", "Peru", "Puerto Rico", "Republic of Korea", "Taiwan", 
                           "Venezuela (Bolivarian Republic of)", "United States Virgin Islands",
                           ####### Additional choices
                           "Australia", "Guam", "world"), multiple = TRUE, 
                           selected = list("Aruba", "Bahamas", "Brazil", "Colombia", "Cuba", "Dominican Republic", 
                                           "Honduras", "Jamaica", "Japan", "Mexico", "Netherlands Antilles", "Nicaragua", 
                                           "Panama", "Philippines", "Peru", "Puerto Rico", "Republic of Korea", "Taiwan", 
                                           "Venezuela (Bolivarian Republic of)", "United States Virgin Islands")),
                         
                  ),
                  
                  column(3, 
                         sliderInput(inputId = "usa_pre1950",
                                     label = "Baseball interest in US/Canada 1950 or before:",
                                     min = 0, max = 100, value = 20),
                         
                         sliderInput(inputId = "usa_post1950",
                                     label = "Baseball interest in US/Canda post 1950:",
                                     min = 0, max = 100, value = 15),
                         
                         sliderInput(inputId = "latin",
                                     label = "Baseball interest in Latin America:",
                                     min = 0, max = 100, value = 40)),
                  
                  column(3, 
                         sliderInput(inputId = "asia",
                                     label = "Baseball interest in East Asia:",
                                     min = 0, max = 100, value = 30),
                         
                         sliderInput(inputId = "central",
                                     label = "Baseball interest in Central America:",
                                     min = 0, max = 100, value = 20),
                         
                         sliderInput(inputId = "oceania",
                                     label = "Baseball interest in Oceania:",
                                     min = 0, max = 100, value = 5)),
                  
                  column(3, 
                         sliderInput(inputId = "south",
                                     label = "Baseball interest in South America:",
                                     min = 0, max = 100, value = 3),
                         
                         sliderInput(inputId = "caribbean",
                                     label = "Baseball interest in Bahamas/Jamaica:",
                                     min = 0, max = 100, value = 5),
                         
                         numericInput(inputId = "world", 
                                      h5("Baseball interest in the remaining countries:"), 
                                      value = 0.01)),
                  br(),
                  
                  column(3, actionButton("submit", "Submit"))
                ),
                
                #br(),
                #tags$h2("Output"),
                #br(),
                
                fluidRow(
                  column(3, div(tableOutput("data"), style = "font-size:150%")), 
                  column(6, plotOutput("plot"), offset = 0.5)
                  
                ), 
                
                tags$h2("Additional details"), 
                tags$div(
                  tags$p("The default choices for population interest weights in the slider bars 
                  reflect national and international baseball interest. These selections are meant to be 
                  slightly conservative. Some rationale for the default choices in the slider bars come 
                  from",
                  tags$a("Gallup polling data,", 
                         href = "https://news.gallup.com/poll/4735/sports.aspx"), 
                  tags$a("changing salaries,", 
                         href = "https://www.investopedia.com/financial-edge/0510/baseball-greats-who-were-paid-like-benchwarmers.aspx"), 
                  tags$a("changing media exposure,", 
                         href = "http://www.baseballessential.com/news/2015/12/19/the-history-of-baseball-broadcasting-early-television/"), 
                  tags$a("changing concentration of talent", 
                         href = "https://www.researchgate.net/publication/247739058_Concentration_of_Playing_Talent_Evolution_in_Major_League_Baseball"),
                  " and several online articles and publications about baseball interest abroad, many 
                  of which can be accessed by diving through Wikipedia's", 
                  tags$a("History of baseball outside the United States", 
                         href = "https://en.wikipedia.org/wiki/History_of_baseball_outside_the_United_States"),
                  "page."
                  )),
                
                tags$div(HTML('<p>Countries are grouped into regions as follows, these regions are 
                  selected more for comparable baseball interest rather than geographic location:</p>
                  <p style="margin-left: 40px">  <b>Latin America:</b> Aruba, Cuba, Dominican Republic 
                  Netherlands Antilles, Puerto Rico, US Virgin Islands, Venezuela 
                  <br>    <b>East Asia:</b> Japan, Philippines, Republic of Korea, Taiwan
                  <br>    <b>Central America:</b> Honduras, Mexico, Nicaragua, Panama
                  <br>    <b>South America:</b> Brazil, Colombia, Peru 
                  <br>    <b>Bahamas/Jamaica:</b> Bahamas, Jamaica 
                  <br>    <b>Oceania:</b> Australia, Guam</p>'
                  )), 
        
                tags$p("The populations constructed above are tabulated from decadal UN or Census 
                counts of males aged 20-29. For 1950 and before these counts only include white American 
                males, reflecting the segration of the MLB that existed at the time. Note that the 
                populations that you considered in this app are tabulated up to year 2010 and not the 
                present day, so that every male age 20 or older in 2010 was tabulated. We stop in 2010 
                because these are career rankings lists, and more recent players would not be eligible 
                for this lists due to a lack of longevity."),
                
                tags$h2("Sources"), 
                tags$div(
                  tags$p(
                    tags$a("Here", 
                           href = "https://www.espn.com/mlb/story/_/id/33145121/top-100-mlb-players-all"),
                    "is the link to the ESPN list of the top 25 (and more) players of all time.", 
                    "Here are bWAR's rankings of the greatest", 
                    tags$a("players", 
                           href = "https://www.baseball-reference.com/leaders/WAR_career.shtml"),
                    " Note that the table presented here was collected in mid 2022 and the rankings may 
                    have changed since then. The changes are minor and the conclusions of the original remain 
                    unchanged, bWAR still includes too many players who started their career before 1950 
                    in their top 25 list. Here are the fWAR's rankings of the greatest", 
                    tags$a("hitters", 
                           href = "https://www.fangraphs.com/leaders.aspx?pos=all&stats=bat&lg=all&qual=y&type=8&season=2019&month=0&season1=1871&ind=0&team=0&rost=0&players=0"),
                    "and", 
                    tags$a("pitchers.", 
                           href = "https://www.fangraphs.com/leaders.aspx?pos=all&stats=pit&lg=all&qual=y&type=8&season=2019&month=0&season1=1871&ind=0&team=0&rost=0&age=0&filter=&players=0&startdate=&enddate="),
                    " Note that the table presented here was collected in mid 2022 and the rankings 
                    may have changed since then. The changes are very minor and the conclusions of the 
                    original remain unchanged, fWAR still includes too many players who started their 
                    career before 1950 in their top 25 list. Note that the Hall of Stats list was included 
                    in early 2022."
                  ),
                  
                  tags$p("Note that the original paper and FanGraphs article included Ranker as a source. 
                         Ranker was removed because it changes very frequently. But it is worth mentioning 
                         that the last time I went on Ranker, I found that the Ranker list would pass the 
                         statistical tests presented here. The community of online fans that participate 
                         on Ranker might not have era-biases! That being said, there is a lot to disagree 
                         about with the Ranker list.")
                  
                  )
                
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  outputs_analysis <- eventReactive(input$submit, {
    countries <- unlist(list(countries = c("United States of America", "Canada", 
                                           input$countries)))
    foo <- population_data[population_data$region %in% countries, ]
    foo$region <- droplevels(foo$region)
    
    #"Aruba", "Bahamas", "Brazil", "Colombia", "Cuba", "Dominican Republic", 
    #"Honduras", "Jamaica", "Japan", "Mexico", "Netherlands Antilles", "Nicaragua", 
    #"Panama", "Philippines", "Peru", "Puerto Rico", "Republic of Korea", "Taiwan", 
    #"Venezuela (Bolivarian Republic of)", "United States Virgin Islands"
    
    asian_countries <- c("Japan", "Philippines", "Republic of Korea", "Taiwan")
    latin_countries <- c("Aruba", "Cuba", "Dominican Republic", "Netherlands Antilles", 
                         "Puerto Rico", "United States Virgin Islands", 
                         "Venezuela (Bolivarian Republic of)")
    central_american_countries <- c("Honduras", "Mexico", "Nicaragua", "Panama")
    south_american_countries <- c("Brazil", "Colombia", "Peru")
    caribbean_countries <- c("Bahamas", "Jamaica")
    oceania_countries <- c("Australia", "Guam")
    
    
    bar <- split(foo, f = as.factor(foo$region))
    baz <- lapply(bar, function(xx){
      region <- unique(xx$region)
      if(region == "Brazil"){
        xx$age25 <- 0
        xx <- (xx %>% filter(year == 2010))
      }
      xx <- xx %>% mutate(total = age20 + age25) %>% dplyr::select("year", "total")
      if(region %in% asian_countries) xx <- xx %>% filter(year >= 2000) %>% 
        mutate(total = input$asia * total)
      else if(region %in% latin_countries) xx <- xx %>% mutate(total = input$latin * total)
      else if(region %in% central_american_countries) xx <- xx %>% mutate(total = input$central * total)
      else if(region %in% south_american_countries) xx <- xx %>% mutate(total = input$south * total)
      else if(region %in% caribbean_countries) xx <- xx %>% mutate(total = input$caribbean * total)
      else if(region %in% oceania_countries) xx <- xx %>% mutate(total = input$oceania * total)
      else if(region %in% c("United States of America", "Canada")){
        xx <- xx %>% mutate(total = input$usa_post1950 * total)
      }
      
    })
    if("Taiwan" %in% countries){ 
      baz$'Taiwan' <- data.frame(year = c(2000, 2010), total = input$asia * c(1.5, 1.5))
    }
    
    qux <- do.call(rbind, baz)
    pops_year_post1950 <- unlist(lapply(split(qux, f = as.factor(qux$year)), 
                                        function(xx) sum(xx$total)))
    
    ## get world totals
    if("world" %in% input$countries){
      foo <- population_data %>% filter(region %in% countries) %>% 
        filter(region != "world") %>% mutate(total = age20 + age25)
      bar <- split(foo, f = as.factor(foo$year))
      total_by_year <- unlist(lapply(bar, function(xx) sum(xx$total)))
      
      world_total_by_year <- ((population_data %>% filter(region == "world") %>% 
                                 group_by(year) %>% mutate(total = age20 + age25))$total - 
                                as.numeric(total_by_year)) * input$world
      
      pops_year_post1950 <- pops_year_post1950 + world_total_by_year
    }
    
    total_post1950 <- sum(c(pops_year_post1950)) #pops_year_post1950[length(pops_year_post1950)]/2))
    US_Can_total_pre1950 <- input$usa_pre1950 * sum(c(Can, US))
    total <-  US_Can_total_pre1950 + total_post1950
    p_pre1950 <- US_Can_total_pre1950 / total
    p_post1950 <- 1 - p_pre1950
    
    # count of great players who started their careers before 1950
    bWAR10 <- 6;   bWAR25 <- 15
    fWAR10 <- 6;   fWAR25 <- 12
    ESPN10 <- 6;   ESPN25 <- 11
    HOS10 <- 6;    HOS25 <- 17
    POS10 <- 6;    POS25 <- 12
    
    # binomial calculations for top 10 lists
    #pranker10 <- pbinom(ranker10 - 1, p = p_pre1950, size = 10, lower = FALSE)
    #pbWAR10   <- pbinom(bWAR10 - 1, p = p_pre1950, size = 10, lower = FALSE)
    #pfWAR10   <- pbinom(fWAR10 - 1, p = p_pre1950, size = 10, lower = FALSE)
    #pESPN10   <- pbinom(ESPN10 - 1, p = p_pre1950, size = 10, lower = FALSE)
    
    # binomial calculations for top 25 lists
    pbWAR25   <- pbinom(bWAR25 - 1, p = p_pre1950, size = 25, lower = FALSE)
    pfWAR25   <- pbinom(fWAR25 - 1, p = p_pre1950, size = 25, lower = FALSE)
    pESPN25   <- pbinom(ESPN25 - 1, p = p_pre1950, size = 25, lower = FALSE)
    pHOS25   <- pbinom(HOS25 - 1, p = p_pre1950, size = 25, lower = FALSE)
    pPOS25   <- pbinom(POS25 - 1, p = p_pre1950, size = 25, lower = FALSE)
    
    #output <- list( probabilities = c(pranker25, pbWAR25, pfWAR25, pESPN25), 
    odds = round(1 / c(pbWAR25, pfWAR25, pESPN25, pHOS25, pPOS25))
    #)
    #output
    
    list(data = data.frame(
      List = c("bWAR", "fWAR", "ESPN", "HOS", "POS"),
      Chance = as.character(paste("1 in", odds, sep = " "))), 
      pop_figures = c(total_post1950, US_Can_total_pre1950, p_post1950, p_pre1950), 
      stringsAsFactors = FALSE)
  })
  
  output$data <- renderTable({
    outputs_analysis()$data
  })
  
  output$plot <- renderPlot({
    pops <- outputs_analysis()$pop_figures
    pops_dat <- data.frame(fact = 
      c(rep("1950 or before", pops[2] / 1000), rep("post 1950", pops[1] / 1000)))#, 
    #perc = c(rep(round(pops[4], 3), pops[2]), rep(round(pops[3], 3), pops[1])))
    ggplot(data = pops_dat) + 
      geom_bar(mapping = aes(x = factor(fact), fill = factor(fact)),  
               position = "dodge") + 
      #geom_text(aes(label = perc, x = factor(fact), y = perc)) +
      coord_flip() + 
      #geom_text(aes(=factor(labs_dat), size = 4)) + #position=position_dodge(width=0.9), size=4)) + 
      labs(x = "Time period", y = "MLB eligible population (in millions)") + 
      theme(panel.background = element_blank(), 
            axis.text = element_text(size = 12),
            axis.title = element_text(size = 14),
            legend.text = element_text(size = 14),
            legend.title = element_text(size = 14), 
            legend.key = element_rect(fill = "white"), 
            axis.ticks.x = element_blank()) + 
      guides(fill = guide_legend(title = "Time period"))
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)


