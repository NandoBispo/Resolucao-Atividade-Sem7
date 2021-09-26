if(!require(tidyverse)) install.packages("tidyverse")
library(tidyverse)                                
if(!require(RVAideMemoire)) install.packages("RVAideMemoire") 
library(RVAideMemoire)                                        
if(!require(car)) install.packages("car")   
library(car)                                
if(!require(psych)) install.packages("psych") 
library(psych)                                
if(!require(rstatix)) install.packages("rstatix") 
library(rstatix)                                
if(!require(DescTools)) install.packages("DescTools") 
library(DescTools)

dados <- read.csv2("Dados/dados1.csv")

##### Verificando normalidade da distribuição.

