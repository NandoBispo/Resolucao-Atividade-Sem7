if(!require(tidyverse)) install.packages("tidyverse")
library(tidyverse)
if(!require(RVAideMemoire)) install.packages("RVAideMemoire") 
library(RVAideMemoire) #Possibilita o teste de Shapiro-Wilk por grupo
if(!require(car)) install.packages("car")   
library(car)
if(!require(psych)) install.packages("psych")
library(psych) 
if(!require(rstatix)) install.packages("rstatix") 
library(rstatix)
if(!require(DescTools)) install.packages("DescTools")
library(DescTools)
library(patchwork)
library(knitr)
library(kableExtra)

# library(DT)
library(janitor)
library(xtable)

dados2 <- read_delim("Dados/htwt.txt", delim = "\t")


