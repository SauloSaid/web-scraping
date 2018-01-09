#============================================================
# Como usar o pacote RSelenium
#===========================================================
#Primeiros exemplos tirados do tutorial: https://rdrr.io/cran/RSelenium/f/inst/doc/RSelenium-basics.Rmd

library("RSelenium")
rD <- rsDriver(port=4444L,browser="chrome")
remDr <- rD$client

#Abrir sessão
remDr$open()

#IR para a página do google
remDr$navigate("http://www.google.com/ncr")
#Ir para a página da BBC
remDr$navigate("http://www.bbc.co.uk")

#Obter a página atual
remDr$getCurrentUrl()
#Voltra à página anterior
remDr$goBack()

#Avançar
remDr$goForward()

#Ir para a página inicial do google
remDr$navigate("http://www.google.com/ncr")

#Criar um elemento web
webElem <- remDr$findElement(using = 'name', value = "q")

#Obter o atributo
webElem$getElementAttribute("name")

#Obter a classe do elemento
webElem$getElementAttribute("class")

#Obter o id do lemento
 webElem$getElementAttribute("id")

 #Achar elemento pelo ID
 remDr$navigate("http://www.google.com/ncr")
 webElem <- remDr$findElement(using = 'id', value = "lst-ib")
 
 #Realizar uma busca no google
 remDr$navigate("http://www.google.com/ncr")
 #BDefinir como elemento o espaço para pesquisa
 webElem <- remDr$findElement(using = "css", "[name = 'q']")
 #Procurar por "R Cran". Ou seja, selecionar um elemeno (campo de pesquisa), enviar texto e dar "enter"
 webElem$sendKeysToElement(list("R Cran", key= "enter"))
 
 
 webElems <- remDr$findElements(using = 'css selector', "h3.r")
 resHeaders <- unlist(lapply(webElems, function(x){x$getElementText()}))
 webElem$getElementText()
 
 ##   EXEMPLO: REALIZAR BUSCAS NA BIBLIOTECA DA UNB
 
 
 ##UNB
 #Pagina para buscas dentro da biblioteca
 # https://consulta.bce.unb.br/pergamum/biblioteca/index.php?resolution2=1024_1&tipo_pesquisa=&filtro_bibliotecas=&filtro_obras=&id=
 remDr$navigate("https://consulta.bce.unb.br/pergamum/biblioteca/index.php?resolution2=1024_1&tipo_pesquisa=&filtro_bibliotecas=&filtro_obras=&id=")
 
 #Realizar a busca pelo termo desejado no próprio navegador. 
 
 #Comando para ir para a próxima página da busca
 remDr$getCurrentUrl()
 proximo <- remDr$findElement(using = "css", "#some_ebsco2 .txt_acervo2+ .pmu_paginacao2")
 proximo$clickElement()
 
 #Códigos CSS para para obter o texto dos resultados e a mudança de página
 a <- rep("a.link_azul", 46)
 b <- rep("#some_ebsco2 .txt_acervo2+ .pmu_paginacao2", 46)
 
 #Mais um teste dos comandos, antes de rodar o loop
 tabela <- data.frame(a=a, b=b)
 #Conseguir os dados
 infos <- remDr$findElements(using = "css", "a.link_azul")
 unlist(lapply(infos, function (x){x$getElementText()}))
 
 
 #Mudar de página
 proximo <- remDr$findElement(using = "css", "#some_ebsco2 .txt_acervo2+ .pmu_paginacao2")
 proximo$clickElement()
novo <- NULL
 
#Loop para obter o texto dos resultados, salvar, mudar de página e repetir a mesma operação

memoria <- ''

#Pode-se tanto montar um loop como clicar sucessivas vezes no comando abaixo
#====
 infos <- remDr$findElements(using = "css", "a.link_azul")
novo <- unlist(lapply(infos, function (x){x$getElementText()}))
 memoria <- c(novo, memoria)
 proximo <- remDr$findElement(using = "css", "#some_ebsco2 .txt_acervo2+ .pmu_paginacao2")
 proximo$clickElement()
 #=====
 
 livros <- data.frame(x=memoria)
 novo
OLA <-  livros %>% filter(str_detect(x, "Meu Pergamum")==FALSE & str_detect(x, "Elogios, sugestões, etc")==FALSE & str_detect(x, "Sugestões para aquisição")==FALSE &str_detect(x, "Ajuda")==FALSE )
dados <- unique(OLA$x) %>% as.data.frame() 
dados$. <- as.character(dados$.)



dta1 <- str_split(dados$., string = '/')
novo

write.table(dados, "Livros extraídos da biblioteca da UnB.csv", sep=";", row.names = FALSE)
[1] ""                                                                                                                        
[2] "Meu Pergamum"                                                                                                            
[3] "Elogios, sugestões, etc"                                                                                                 
[4] "Sugestões para aquisição"                                                                                                
[5] "Ajuda"            