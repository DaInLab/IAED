# Versão novembro de 2021
#lendo no formato xlsx
library(readxl)
compuador_xlsx <- read_excel("./dados/qual_computador.xlsx")
View(compuador_xlsx)
class(compuador_xlsx)
#[1] "tbl_df"     "tbl"        "data.frame"

#lendo arquivo no formato texto!
sobre.seu.laptop.csv <- read.csv("~/Library/Mobile Documents/com~apple~CloudDocs/GitLab/sobre-o-seu-laptop/dados/Sobre seu laptop.csv")
View(sobre.seu.laptop.csv)
class(sobre.seu.laptop.csv)
#[1] "data.frame"

#Lendo arquivo no formato json!
#install.packages("rjson")
library("rjson")
json_file <- "./dados/Sobre seu laptop.json"
json_data <- fromJSON(file=json_file)
#se verificar o tipo de conversão realizada, ficou tipo "lista"
class(json_data)
#[1] "list"
#para transformar em data.frame
library(plyr)
df_seu_laptop.1 <- data.frame(t(sapply(json_data,c)), stringsAsFactors = F)
View(df_seu_laptop.1)
class(df_seu_laptop.1)
#[1] "data.frame"

#outra biblioteca para ler arquivos tipo json

library(jsonlite)
json_data_frame <- fromJSON(json_file, flatten = T)
class(json_data_frame)
#[1] "matrix"

df <- as.data.frame(json_data_frame, make.names = F, 
                    stringsAsFactors = F)
View(df)
class(df)
#[1] "data.frame"

#lendo tablemas em formato HTML
install.packages("htmltab")
library(htmltab)
html_file <- "./dados/Sobre seu laptop.html"
sobre.seu.laptop.html <- htmltab(doc = html_file, which = 1)
View(sobre.seu.laptop.html)
class(sobre.seu.laptop.html)
#[1] "data.frame"
## Um exemplo "pegando" uma tabela de dados sobre população mundial
##no site Wikipedia na url citada no comando url = 
url <- "http://en.wikipedia.org/wiki/World_population"
xp <- "//caption[starts-with(text(),'World historical')]/ancestor::table"
tabela.populacao.mundial = htmltab(doc = url, which = xp)

##lendo arquivo no formato .ods (Calc)
##O Open Document Format for Office Applications (ODF), também conhecido como OpenDocument, 
##é um formato de arquivo baseado em XML compactado em ZIP para planilhas, gráficos, 
##apresentações e documentos de processamento de texto. Foi desenvolvido com o objetivo 
##de fornecer uma especificação aberta de formato de arquivo baseado em XML para aplicativos 
##de escritório.
install.packages("readODS")
library(readODS)
file_ods = "./dados/Sobre seu laptop.ods"
sobre.seu.laptop.ods = read_ods(path = file_ods, sheet = 1, col_names = TRUE,
         col_types = NULL, na = "", skip = 0, formula_as_formula = FALSE,
         range = NULL)
View(sobre.seu.laptop.ods)
class(sobre.seu.laptop.ods)
#[1] "data.frame"
