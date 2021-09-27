if(!require(pacman)) install.packages("pacman")
library(pacman)

pacman::p_load(tidyverse, car, rstatix, ggpubr, 
               RVAideMemoire, psych, DescTools, patchwork,
               knitr, kableExtra, janitor, xtable)

#Vídeo de ajuda:
#https://www.youtube.com/watch?v=-khgg8lzbNY

dados <- read.csv2("Dados/dados1.csv")
glimpse(dados)

############################
#### Análise Descritiva ####
#Tabela
dados %>%
  mutate(
    gravacao = as_factor(gravacao),
    gravacao = lvls_revalue(
      gravacao, c("Anúncio","Música de Elevador", "Música Clássica"))) %>%
  group_by(gravacao) %>%
  summarise(
    round(min(tempo)), 
    round(quantile(tempo, .25),3),
    round(mean(tempo), 3),
    median(tempo),
    round(quantile(tempo, .75),3),
    max(tempo),
    round(sd(tempo), 2)) %>% 
  kbl(
    align = "c",
    caption = "Tabela 1: Medidas Resumo",
    col.names = c("Tipo de Áudio","Min","Q1","Media", "MD","Q3","Max", "SD")
  ) %>% 
  kable_styling(
    latex_options = c("striped", "hover"), full_width = F)

describeBy(dados$tempo, group = dados$gravacao)



#Gráfico
p1 <- 
  dados %>% 
    mutate(gravacao = as_factor(gravacao)) %>% 
    group_by(gravacao) %>% 
    ggplot(
      aes(
        x = gravacao, y = tempo ,fill = gravacao)) +
    geom_boxplot() +
      scale_x_discrete(
        labels = c("Anúncio","Música de Elevador", "Música Clássica")) +
      scale_fill_discrete( # Modifica o rótulo da legenda
        labels = c("Anúncio","Música de Elevador", "Música Clássica")) +
      labs(x = "", y = "Tempo (min)", fill="",title = "A)") +
      theme_bw()+ 
      theme(legend.position = "bottom")

p2 <-  
  dados %>% 
    mutate(gravacao = as_factor(gravacao)) %>% 
    group_by(gravacao) %>% 
    ggplot(
      aes(x = tempo,fill = gravacao)) +
    geom_density(alpha = 0.4) +
    # scale_fill_discrete(
    # labels = c("Anúncio","Música de Elevador", "Música Clássica")) +
    scale_fill_manual(values = c("red", "green", "blue"),
                      labels = c("Anúncio","Música de Elevador", "Música Clássica")) +
    guides(color = "none")+
    labs(x = "", y = "Tempo (min)", fill="",title = "B)") +
    theme_bw()+ 
    theme(legend.position = "bottom")

p1+p2

#############################
#### Análise Inferêncial ####

# Análise da normalidade da distribuição.
## Aplicando o teste de Shapiro-Wilk
byf.shapiro(tempo ~ gravacao, dados)

dados %>% 
  mutate(gravacao = as_factor(gravacao),
         gravacao = lvls_revalue(
           gravacao, c("Anúncio","Música de Elevador", "Música Clássica"))) %>% 
  rename(Gravação = gravacao, Tempo = tempo) %>% 
  byf.shapiro(Tempo ~ Gravação,.)

# Análise da Variância
##Aplicação do Teste de Levene
dados %>% 
  mutate(gravacao = as_factor(gravacao)) %>% 
  leveneTest(tempo ~ gravacao, ., center = mean)

var.test(as.numeric(dados$tempo) ~ dados$gravacao, alternative = "three.sided")

anova1 <- dados %>% 
  mutate(
    gravacao = as_factor(gravacao),
    gravacao = lvls_revalue(
      gravacao, c("Anúncio","Música de Elevador", "Música Clássica"))) %>% 
  aov(tempo ~ gravacao,.)

anova1 %>% summary


PostHocTest(anova1, method = "bonf")

round(
  cbind(Bonferroni = PostHocTest(anova1, method = "bonf")$gravacao[, "pval"]), 4
)



