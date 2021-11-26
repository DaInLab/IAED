# Gerando dataframe

# Em Python
import pandas as pd

df_p = pd.DataFrame({'Aluno' : ['Marina','Felipe','Cleyton','Isabel'],'Créditos cursados': 
    [20,64,32,24],'Rendimento acadêmico' : [8.55,7.88,8.17,9.04],'Mês de nascimento' : 
    ['Novembro','Setembro','Janeiro','Julho'], 'Curso': 
    ['Computação','Estatística','Computação','Matemática']})
df_p

#Out:
#      Aluno  Créditos cursados  ...  Mês de nascimento        Curso
# 0   Marina                 20  ...           Novembro   Computação
# 1   Felipe                 64  ...           Setembro  Estatística
# 2  Cleyton                 32  ...            Janeiro   Computação
# 3   Isabel                 24  ...              Julho   Matemática
#
#[4 rows x 5 columns]
