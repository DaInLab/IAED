# Gerando dataframe

# Em R
# Não precisa carregar nenhuma biblioteca, faz parte do "base" do R
# library(base)
#O Pacote Base R - Descrição
# Funções da base R
#
#Detalhes
# Este "pacote" (ou "biblioteca") contém as funções básicas que permitem que 
# a linguagem R funcione como uma linguagem: comandos aritméticos, 
# de entrada e saída, de suporte básico de programação, etc. 
# Seu conteúdo está disponível por herança em qualquer ambiente.

# Para uma lista completa das funções, use o comando library (help = "base").

df_r = data.frame('Aluno' = c('Marina','Felipe','Cleyton','Isabel'),
                "Créditos cursados" = c(20,64,32,24),
                'Rendimento acadêmico' = c(8.55,7.88,8.17,9.04),
                'Mês de nascimento' = c('Novembro','Setembro','Janeiro','Julho'),
                'Curso' = 
                  c('Computação','Estatística','Computação','Matemática')
                )
df_r
#    Aluno Créditos.cursados Rendimento.acadêmico Mês.de.nascimento       Curso
#1  Marina                20                 8.55          Novembro  Computação
#2  Felipe                64                 7.88          Setembro Estatística
#3 Cleyton                32                 8.17           Janeiro  Computação
#4  Isabel                24                 9.04             Julho  Matemática
