#Data Frames - Descrição
#A função data.frame () cria frames de dados, coleções fortemente acopladas de
# variáveis que compartilham muitas das propriedades de matrizes e de listas, usadas como
# a estrutura de dados fundamental da maioria dos softwares de modelagem em R.

# Utilização - formato
# data.frame(..., row.names = NULL, check.rows = FALSE,
#          check.names = TRUE, fix.empty.names = TRUE,
#          stringsAsFactors = FALSE)
L3 <- LETTERS[1:3]
fac <- sample(L3, 10, replace = TRUE)
(d <- data.frame(x = 1, y = 1:10, fac = fac))
## The "same" with automatic column names:
data.frame(1, 1:10, sample(L3, 10, replace = TRUE))

is.data.frame(d)

## do not convert to factor, using I() :
(dd <- cbind(d, char = I(letters[1:10])))
rbind(class = sapply(dd, class), mode = sapply(dd, mode))

stopifnot(1:10 == row.names(d))  # {coercion}

(d0  <- d[, FALSE])   # data frame with 0 columns and 10 rows
(d.0 <- d[FALSE, ])   # <0 rows> data frame  (3 named cols)
(d00 <- d0[FALSE, ])  # data frame with 0 columns and 0 rows
