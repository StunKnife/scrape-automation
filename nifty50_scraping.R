#load libs

library(tidyverse)
library(rvest)
library(janitor)

#nse top gainers

url <- 'https://www.moneycontrol.com/stocks/marketstats/nsegainer/index.php'

# extract html

url_html <- read_html(url)

#table extraction

url_tables <- url_html %>% html_table(fill = TRUE)

#extract relevant table

top_gainers <- url_tables[[2]]

#extract relevant columns

#Seleciona colunas de 1 a 7
top_gainers %>%
  select(1:7) -> top_gainers

#organiza a base de dados reformulando alguns caracteres para a aplicação do pipe
top_gainers %>%
  clean_names() -> top_gainers

#filtra as observações que são diferentes de na
top_gainers %>%
  filter(!is.na(low)) -> top_gainers

#retirou os \t da coluna de nomes
top_gainers %>%
  separate(company_name,
           into = 'company_name',
           sep = '\t') -> top_gainers


write_csv(top_gainers,paste0('data/',Sys.Date(),'_top_gainers','.csv'))

#getwd()


