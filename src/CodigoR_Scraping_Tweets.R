
# Librerias utilizadas
library(rtweet)
library(tidyverse)
library(dplyr)

setwd("C:/Users/eduri/OneDrive/Documents/Tesis")

appname <- "sample2023" # Nombre de la app en Twitter

#Agregamos las llaves para acceder al API de Twitter
consumer_key <- "XXXXXXX"
consumer_secret <- "XXXXXXXXXXX"
access_token <- "XXXXXXXXXXX"
access_secret <- "XXXXXXXXXXX"

#Accedemos con esta funcion a la API
twitter_token <- create_token(
  app = appname,
  consumer_key = consumer_key,
  consumer_secret = consumer_secret,
  access_token = access_token, 
  access_secret = access_secret)

#Libreria para extraer los tweets

library(twitteR)

#Funcion para obtener los tweets con la palabra buscada
tweets <- function(word, count) {
  frecuency <- searchTwitter(word, n=count)
  df <- twListToDF(frecuency)
  return (df)
}

#palabras que se buscaron
word1 <- as.data.frame(tweets("Plan integral de movilidad", 3000))
word2 <- as.data.frame(tweets("Dialogo por la movilidad sustentable de Lopez Mateos", 3000))
word3 <- as.data.frame(tweets("Avenida Lopez Mateos", 3000))
word4 <- as.data.frame(tweets("Tren ligero linea 4", 3000))
word5 <- as.data.frame(tweets("Ampliación tren ligero linea 1", 3000))
word6 <- as.data.frame(tweets("Segundo piso Lopez Mateos", 3000))
word7 <- as.data.frame(tweets("BRT Chapala", 3000))
word8 <- as.data.frame(tweets("Transporte Jalisco", 3000))
word9 <- as.data.frame(tweets("solución lopez mateos", 3000))
word10 <- as.data.frame(tweets("Modulos Ocelotes", 3000))
word11 <- as.data.frame(tweets("Camino Real a Colima", 3000))
word12 <- as.data.frame(tweets("planeación y Ordenamiento Territorial", 3000))

# Se concatenan todas las palabras para armar un solo dataframe
tweets_mov_lp <- rbind(word1, word2, word3, word4, word5, word6, word7, word8, word9, word10, word11, word12)

# Se exporta en formato excel
write.xlsx(tweets_mov_lp, "Plan_integral_movilidad.xlsx")







