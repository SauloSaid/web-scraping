#===============================================================================
#Ler todas as proposições e filtrar, entre elas, as relativas a reforma agraria 
#===============================================================================

##  pacotes 
library(bRasilLegis)
library(dplyr)
library(stringr)

#Obter os PLS
PL <- data.frame("")
tipos <- listarSiglasTipoProposicao()
exemplo <-listarProposicoes("PL", 1946)
anos <- c(1945:1970)

for (i in seq_along(anos))
     {
       exemplo <-listarProposicoes("PL", anos[i])
       PL <- bind_rows(PL, exemplo)
}
 ano1 <- c(1949:1964)
#Obter as PECs
exemplo <- NULL
PEC <- data.frame("")
for (i in seq_along(anos))
{
  exemplo <-listarProposicoes(sigla = "PEC", ano = ano1[i])
  PEC <- bind_rows(PEC, exemplo)
}
lista <- list("")
for (i in seq_along(ano1))
{
lista[[i]] <- listarProposicoes("PEC", ano1[i])
    
}

PECs <- bind_rows(lista)

$Juntar PECs e PLS
PL$X.. <- NULL
proposicoes <- rbind(PECs, PL)

#Filtrar proposições de acordo com texto
proposicoes$txtEmenta <- str_to_lower(proposicoes$txtEmenta)
teste <- proposicoes %>% filter(str_detect(proposicoes$txtEmenta, pattern = "agraria")| 
                                  str_detect(proposicoes$txtEmenta, pattern = "desapropriação por interesse social")| 
                                  str_detect(proposicoes$txtEmenta, pattern = "desapropriação por utilidade pública") |
                                  (str_detect(proposicoes$txtEmenta, pattern = " 141")& str_detect(proposicoes$txtEmenta, pattern = " 16")))

#Imprimir os projetos que fazem referência à reforma agrária
setwd("C:/Users/Saulo/Documents/Capítulo V")
write.table(teste, "Matérias legislativas sobre a reforma agrária.csv", sep=";", row.names = FALSE)

