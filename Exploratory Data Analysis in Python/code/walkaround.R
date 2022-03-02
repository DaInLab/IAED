library(reticulate)
library(tidyverse)

# Seeing your enviroments
conda_list()

#Using it
conda_list()[[1]][1] %>% 
  use_condaenv(required = TRUE)

#Checking python

import platform
print(platform.python_version())


use_python("D:\\anaconda3/python.exe")

python <- "D:\\anaconda3/python.exe"
conda_info <- reticulate:::get_python_conda_info(python)
new_path <- reticulate:::conda_run(
  "python",
  c("-c", shQuote("import os; print(os.environ['PATH'])")),
  conda = conda_info$conda,
  envname = conda_info$root,
  stdout = TRUE
)
new_path

install.packages("remotes")
library(remotes)
remotes::install_github("rstudio/reticulate")
