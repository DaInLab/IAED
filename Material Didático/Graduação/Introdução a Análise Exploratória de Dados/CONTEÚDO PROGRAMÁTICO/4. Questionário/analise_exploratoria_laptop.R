# Localizando o arquivo .xls
setwd("/Users/jpalbino/Downloads/Data Science Material/Introdução à Ciência de Dados/dados")

# No R, para utilizar determinadas funções, é preciso "carregar" um "pacote"
# Neste caso, carregamos o "pacote" xlxs diretamente do CRAN-R
# Caso o mesmo ainda não esteja transferido o comando é:
## install.packages("xlsx")
library(xlsx)
df <- read.xlsx("sobre_seu_laptop_v2.xlsx", sheetName = "respostas")
head(df)

# Alguns gráficos básicos
# Tipo pizza
pie(df$SO)

# Para melhorar a visualização, usaremos a função table() para subdividir o gráfico em fatores
# table() usa os fatores de classificação cruzada (classificação de acordo com mais de um atributo ao mesmo tempo)
# para construir uma tabela de contingência (tabela estatística que mostra as freqüências dos dados, 
# classificados de acordo com duas variáveis: as linhas indicam uma variável e as colunas indicam outra variável)
# das contagens em cada combinação de níveis de fatores.
table(df$SO)
# 1  2  3 (fatores, onde 1 = Windows, 2 = MacOs e 3 = Linux)
#22  2  2 
pie(table(df$SO))

lbls <- c("Windows", "MacOs", "Linux")
pct <- round(table(df$SO)/sum(table(df$SO))*100, digits=1)
#> pct
#   1    2    3 
#84.6  7.7  7.7 
lbls <- paste(lbls, pct) # add percents to labels 
lbls <- paste(lbls,"%",sep="") # ad % to labels 
pie(table(df$SO), labels = lbls, edges = 200, radius = 0.8,
    clockwise = TRUE, density = 60, angle = 45, col = c("purple", "green3","cyan"), border = NULL,
    lty = NULL, main = "Sistemas Operacionais Utilizados pelos Alunos")
