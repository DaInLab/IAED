# 1. Resumo e visualização
df = read.csv("./data/heart_failure_clinical_records_dataset.csv")

# colunas no conjunto de dados:
colnames(df)
# [1] "age"                      "anaemia"                  "creatinine_phosphokinase"
# [4] "diabetes"                 "ejection_fraction"        "high_blood_pressure"     
# [7] "platelets"                "serum_creatinine"         "serum_sodium"            
#[10] "sex"                      "smoking"                  "time" 

# O conjunto de dados tem diferentes parâmetros de saúde, idade, sexo e DEATH_EVENT (Evento de Morte)
# Vendo quais variáveis estão correlacionadas. 
# Requer a biblioteca ‘corrplot’.
# O pacote  corrplot fornece uma visâo exploratória visual da matriz de correlação realizando uma
#  reordenação automática das variáveis para detectar padrões ocultos entre estas variáveis.
# Documentação: https://cran.r-project.org/web/packages/corrplot/vignettes/corrplot-intro.html

if (!"corrplot" %in% installed.packages()) install.packages("corrplot")

library(corrplot) 
corrplot(cor(df), type = "upper")

# Utilizando gráficos como guia para decidir os próximos passos

# Existem seis variáveis contínuas no dataset: age (idade), creatinine_phosphokinase (Creatina Fosfoquinase)
# ejection_fraction (fração de ejeção), platelets (plaquetas), serum_creatinine (creatinina sérica) e 
# serum_sodium (sódio sérico)
# Variáveis contínuas podem assumir qualquer valor
# Para verificar a distribuição, essas seis variáveis serão separadas em diferente datasets (df[]).
# Em seguida os datasets serão plotados em histogramas (hist.data.frame()).
# Documentação: https://www.rdocumentation.org/packages/Hmisc/versions/4.5-0
# O pacote Hmisc calcula o número máximo de histogramas que cabem em uma página e, 
# em seguida, desenha uma matriz de histogramas.

if (!"Hmisc" %in% installed.packages()) install.packages("Hmisc")

library(Hmisc) 

df1 = df[, c('age', 'creatinine_phosphokinase', 'ejection_fraction' , 'platelets', 'serum_creatinine', 'serum_sodium')]
hist.data.frame(df1, title = "Histogramas das variáveis contínuas")

#A visualização da distribuição dos dados das seis variáveis nos histogramas 
# dão uma boa ideia sobre como estão esses dados.

# Para apresentar mais dados a função summary() (resumo) pode fornecer alguns parâmetros estatísticos básicos
 # sobre as seis variáveis contínuas.

summary(df1)

#      age        creatinine_phosphokinase ejection_fraction   platelets      serum_creatinine
# Min.   :40.00   Min.   :  23.0           Min.   :14.00     Min.   : 25100   Min.   :0.500   
# 1st Qu.:51.00   1st Qu.: 116.5           1st Qu.:30.00     1st Qu.:212500   1st Qu.:0.900   
# Median :60.00   Median : 250.0           Median :38.00     Median :262000   Median :1.100   
# Mean   :60.83   Mean   : 581.8           Mean   :38.08     Mean   :263358   Mean   :1.394   
# 3rd Qu.:70.00   3rd Qu.: 582.0           3rd Qu.:45.00     3rd Qu.:303500   3rd Qu.:1.400   
# Max.   :95.00   Max.   :7861.0           Max.   :80.00     Max.   :850000   Max.   :9.400   

#  serum_sodium  
# Min.   :113.0  
# 1st Qu.:134.0  
# Median :137.0  
# Mean   :136.6  
# 3rd Qu.:140.0  
# Max.   :148.0 

# Para os dados categóricos (pode assumir apenas um número limitado, e geralmente fixo, de valores possíveis)
#  essas seis  variáveis também serão separadas em diferente datasets (df[]).

df2 = df[, c('anaemia', 'diabetes', 'high_blood_pressure', 'sex', 'smoking', 'DEATH_EVENT')]
head(df2)
#  anaemia diabetes high_blood_pressure sex smoking DEATH_EVENT
#1       0        0                   1   1       0           1
#2       0        0                   0   1       0           1
#3       0        0                   0   1       1           1
#4       1        0                   0   1       0           1
#5       1        1                   0   0       0           1
#6       1        0                   1   1       1           1

# O gráfico de correlação nâo mostra correlação existente entre as varáveis ´sexo´ e `morte`
# 
# Entretanto, queremos ver o qual número de falecimentos em homens e mulheres.
# Antes disso, uma boa ideia é alterar os valores 0 e 1 dessas colunas para algumas strings significativas.

df$death = ifelse(df$DEATH_EVENT == 1, "Yes", "No")
df$sex = ifelse(df$sex == 1, "Male", "Female")
table(df$sex, df$death)
       
#         No Yes
# Female  71  34
# Male   132  62

# Observa-se que há mais homens do que mulheres neste conjunto de dados.
# Qual é a porcentagem de homens e mulheres?

data = table(df$sex)
data1 = round(data/sum(data)*100)
data1 = paste(names(data1), data1)
paste(data1, "%", sep = "")
# [1] "Female 35%" "Male 65%" 

# Para aprender mais sobre o conjunto de dados, vamos verificar a distribuição
# das idades masculina e feminina separadamente na amostra

# ggplot2 é um pacote dedicado à visualização de dados. 
# Melhora muito a qualidade e a estética dos gráficos e torna mais fácil a sua criação.

ggplot(df, aes(x = age)) + 
  geom_histogram(fill = "white", colour = "black") + 
  facet_grid(sex ~ .)

# Os histogramas mostram que a população masculina é mais velha do que a população feminina.

# Observa-se que a creatinina sérica e o sódio sérico mostram alguma correlação.
# Um gráfico de dispersão (scatter plot) pode mostrar isso mais claramente:

ggplot(df) + 
  geom_point(aes(x = serum_creatinine, y = serum_sodium, colour = death, shape = death)) + 
  ggtitle("Creatinina sérica vs Sódio Sérico")

# Por causa de alguns outliers (valor aberrante ou atípico, é uma observação que apresenta 
# um grande afastamento das demais ou que é inconsistente), a maioria dos dados é agrupada em um só lugar. 
# Nesse tipo de situação, uma boa prática é verificar o mesmo gráfico sem os outliers também. 

df_scr = df[df$serum_creatinine < 4.0 & df$serum_sodium > 120,]
ggplot(df_scr) + 
  geom_point(aes(x = serum_creatinine, y = serum_sodium, colour = death, shape = death)) + 
  ggtitle("Creatinina sérica vs Sódio Sérico")

# O gráfico mostra claramente a relação entre o sódio sérico e a creatinina sérica. 
# Os pontos estão separados por eventos de morte usando diferentes cores e formas.


# O próximo gráfico é a fração de ejeção vs evento de morte. Ele mostrará um gráfico de jitter
# que, na verdade, é uma versão modificada do gráfico de dispersão. 

# Quando uma das variáveis no gráfico de dispersão é categórica, os pontos temdem 
# a permanecer em linha reta e se sobrepõem, tornando o gráfico difícil de entender.
# É por isso que em um gráfico de jitter eles desviam um pouco os pontos, 
# o que dá uma melhor compreensão dos dados. 
# Além disso, adicionaremos um ponto vermelho que mostrará a média dos dados. 

ggplot(df, aes(y = ejection_fraction, x = death)) + 
  ggtitle("Fração de Ejeção vs Evento de Morte") +
  geom_jitter()

# A variável tempo apresenta forte correlação com eventos de óbito. 
# Um boxplot pode mostrar a diferença através do 'tempo' para eventos 
# de morte e nenhum evento de morte: 

ggplot(df, aes(death, time))+geom_point() + 
  labs(title="Óbitos x tempo separados por gênero ", x = "Death", y = "Time") +
  geom_boxplot(fill='steelblue', col="black", notch=TRUE) + 
  facet_wrap(~ sex)

# Creatina fosfoquinase e óbitos apresentam alguma correlação. 
# O próximo gráfico explora isso com um histograma:

ggplot(df, aes(x=creatinine_phosphokinase, fill=death)) + 
  geom_histogram(bins=20) + 
  labs(title = "Distribuição de Creatina fosfoquinase", 
       x = "Creatina fosfoquinase", y = "Quantidade")

# A anemia também está relacionada à creatinina fosfoquinase. 
# A distribuição pode ser separada por anemia para observar a distribuição separadamente:

ggplot(df, aes(x=creatinine_phosphokinase, fill=death)) + 
  geom_histogram(bins=20)+facet_wrap(~anaemia) + 
  labs(title = "Distribuição de Creatina fosfoquinase", 
       x = "Creatina fosfoquinase", y = "Quantidade")

# A distribuição é bem diferente para a população com anemia e sem anemia!

# A variável 'tempo' tem forte correlação com óbitos. 
# O gráfico de dispersão de idade versus tempo mostra eventos de morte com cores diferentes.  

ggplot(df, aes(x = age, y = time, col = death))+geom_point() + 
  labs(title = "Age vs Time", x = "Idade", y = "Tempo")

# Gráfico mostrando a distribuição da creatinina sérica separada em cores diferentes
# para os óbitos:

ggplot(df, aes(x = serum_creatinine, fill = death))+
  geom_histogram() + 
  labs(title = "Distribuição da creatinina sérica separada em cores diferentes", 
          x = "Creatinina Sérica", y = "Quantidade")

# Poucos valores discrepantes no lado direito do gráfico.
# Vamos verificar a mesma distribuição sem esses outliers: 

df_sc = df[df$serum_creatinine < 4.0,]

ggplot(df_sc, aes(x = serum_creatinine, fill = death))+
  geom_histogram() + 
  labs(title = "Distribuição da creatinina sérica separada em cores diferentes", 
       x = "Creatinina Sérica", y = "Quantidade")

# Sem os outliers, a distribuição no gráfico fica mais clara. 

# A fração de ejeção pode ser diferenteem óbitos. 
# Ver se a fração de ejeção é diferente com base no sexo.

ggplot(df, aes(death, ejection_fraction, fill = as.factor(sex))) + 
  geom_bar(stat = "summary", fun = "median", col = "black",
           position = "dodge") + 
  geom_point(position = position_dodge(0.9)) + 
  labs(title = "Fração de Ejeção por Óbito", 
       x = "Óbito", y = "Fração de Ejeção")
# Os pontos pretos nas colunas mostram a variação dos dados. 

# O próximo gráfico explora a relação entre a anemia e a creatinina fosfoquinase
# separadamente para óbitos e nenhum evento de morte. 

ggplot(df, aes(x = as.factor(anaemia), y = creatinine_phosphokinase, fill = death)) + 
  geom_violin() +
  stat_summary(aes(x= as.factor(anaemia), y = creatinine_phosphokinase), fun = median, geom='point', colour = "red", size = 3)+
  facet_wrap(~death)+
  geom_jitter(position = position_jitter(0.1), alpha = 0.2) + 
  labs(title = "Creatinina Fosfoquinase para Estados de Anemia Separados por Óbitos", 
       x = "Anemia", y ="Creatinina Fosfoquinase")

#Neste gráfico, você pode ver vários ângulos diferentes ao mesmo tempo. o gráfico em formato de violino
# mostra a distribuição e os valores discrepantes. 
# Ao mesmo tempo, o gráfico de jitter com pontos vermelhos apontam para a mediana dos respectivos dados. 

#Modelo preditivo
# Prever óbitos usando outros recursos do conjunto de dados. 
# Primeiro, devemos verificar as proporções de óbitos: 
data = table(df$death)
round(data/sum(data), 2)
#   No  Yes 
# 0.68 0.32 

# Para este modelo preditivo, o conjunto de dados será mais uma vez importado
# porque foramfritas várias alterações no dataset importado antes.
d = read.csv("./data/heart_failure_clinical_records_dataset.csv")

# Agora, o data frame será dividido em duas partes
if (!"caTools" %in% installed.packages()) install.packages("caTools")

library(caTools)
set.seed(1243)
split = sample.split(df1$DEATH_EVENT, SplitRatio = 0.75)

# A divisão fornece valores booleanos para cada DEATH_EVENT. 
# 75% deles são verdadeiros e 25% falsos (SplitRatio = 0.75).
# Com base neste valor de divisão, os dados de tereinamento (training_data) 
# e os dados de teste (test_data) serão separados: 
training_data = subset(d, split == TRUE)
test_data = subset(d, split == FALSE)

# Agora o dataframe para o classificador.
# Para este projeto foi escolhido o classificador da máquina de vetor de suporte (SVM).
# SVM ou Support Vector Machine é um modelo linear utilizado em problemas de classificação e regressão. 
# SVM possui um conjunto de métodos de aprendizado supervisionado que analisam 
# os dados e reconhecem padrões, usado para tanto técnicas de classificação e análise de regressão

if (!"e1071" %in% installed.packages()) install.packages("e1071")
library(e1071)
svm_fit = svm(formula = DEATH_EVENT ~ .,
              data = training_data,
              type = 'C-classification',
              kernel = 'linear'
)
# Os dados de treinamento foram ajustados no classificador e agora o classificador está treinado.
# Este classificador agora pode ser utilizado para testar o modelo com os dados de teste. 
# Usando os dados de teste, pode-se prever o DEATH_EVENT (óbitos). 
# Portanto, é necessário retirar a variável DEATH_EVENT (o 13o. campo) dos dados de teste. 
y_pred = predict(svm_fit, newdata = test_data[-13])

# A previsão foi realizada. Agora é preciso verificar a precisão da previsão. 
# A função ConfusionMatrix do pacote 'caret’ será utilizada, pois fornece várias informações
# com apenas uma linha de código:
#  
if (!"caret" %in% installed.packages()) install.packages("caret")
library(caret)
confusionMatrix(y_pred, as.factor(test_data$DEATH_EVENT))

# Matriz de confusão é uma tabela que permite a visualização do desempenho de um algoritmo de classificação. 
# Essa tabela de contingência 2x2 especial é também chamada de matriz de erro.  

#Confusion Matrix and Statistics
#
#          Reference
#Prediction  0  1
#         0 47  5
#         1  4 19
#                                          
#               Accuracy : 0.88            
#                 95% CI : (0.7844, 0.9436)
#    No Information Rate : 0.68            
#    P-Value [Acc > NIR] : 5.362e-05       
#                                          
#                  Kappa : 0.7212          
#                                          
# Mcnemar's Test P-Value : 1               
#                                          
#            Sensitivity : 0.9216          
#            Specificity : 0.7917          
#         Pos Pred Value : 0.9038          
#         Neg Pred Value : 0.8261          
#             Prevalence : 0.6800          
#         Detection Rate : 0.6267          
#   Detection Prevalence : 0.6933          
#      Balanced Accuracy : 0.8566          
#                                          
#       'Positive' Class : 0

# A precisão geral da previsão é de 88%. 
# A matriz de confusão prevê com precisão 47 eventos sem morte e 4 sem óbitos erroneamente previstos
# Por outro lado, 19 com óbitos foram previstos com precisão e 5 eventos de morte foram erroneamente previstos como nenhuma morte. 
# Neste caso, o verdadeiro positivo é 19, o falso positivo é 4 e o falso negativo é 5. 
# Usando essas informações, a pontuação F1 é calculada usando a fórmula: true_positive/(true_positive + 0.5*(false_positive + false_negative))

F1 = round(19/(19 + 0.5*(4 + 5)),2)
F1
# [1] 0.81




