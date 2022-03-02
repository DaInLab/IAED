# 
# Let’s import the necessary packages 
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

#Let’s import the dataset
arquivo_mac = "/Users/jpalbino/Library/Mobile Documents/com~apple~CloudDocs/GitHub/IAED/Exploratory Data Analysis in Python/data/heart_failure_clinical_records_dataset.csv"
df = pd.read_csv(arquivo_mac)

arquivo_win = "D:/GitHub/IAED/Exploratory Data Analysis in Python/data/heart_failure_clinical_records_dataset.csv"
df = pd.read_csv(arquivo_win)


# Dataset is a bit bigger for showing a screenshot. It has 299 rows of data.
# Here are the columns of the dataset:
df.columns

# ‘age’, ‘creatinine_phosphokinase’, ‘ejection_fraction’, ‘platelets’, ‘serum_creatinine’, ‘serum_sodium’, ‘time’ are the continuous variables.
# ‘anaemia’, ‘diabetes’, ‘high_blood_pressure’, ‘sex’, ‘smoking’, ‘DEATH_EVENT’ are categorical variables

# starting EDA project by observing the distribution of the continuous variables.
df[['age', 'creatinine_phosphokinase', 
    'ejection_fraction', 'platelets', 
    'serum_creatinine', 'serum_sodium']].hist(bins=20,

figsize=(15, 15))
plt.show()
# shows at a glance where the majority population lies and the nature of the distribution.

# to find some commonly used descriptive variable data such as mean, median, max, min, std, and quartiles.
continous_var = ['age', 'creatinine_phosphokinase',
                 'ejection_fraction', 'platelets', 
                 'serum_creatinine', 'serum_sodium']
df[continous_var].describe()

# As we have seen the distribution separately and statistical parameters, 
# tt will be nice to see how each of these variables relates to the ‘DEATH_EVENT’. 
# This column has 0 and 1 values. It will change it to ‘yes’ and ‘no’. 
# In same way, we will also change the ‘sex’ column and replace 0 and 1 with ‘male’ and ‘female’.
# Neste processo, serão criadas duas novas colunas correspondentes "sex1"e "death".
df['sex1'] = df['sex'].replace({1: "Male", 0: "Female"}) 
df['death'] = df['DEATH_EVENT'].replace({1: "yes", 0: "no"})

# In the next plot, we will see a pairplot that will show the relationship between each of the continuous variables with the rest of them. 
# We will also use a different color for death events.
sns.pairplot(df[["creatinine_phosphokinase", "ejection_fraction",
                  "platelets", "serum_creatinine",
                  "serum_sodium", "time", "death"]],
                  hue = "death",
                  diag_kind='kde', kind='scatter', palette='husl') 
plt.show()



