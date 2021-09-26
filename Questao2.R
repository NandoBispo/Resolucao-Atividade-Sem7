if(!require(pacman)) install.packages("pacman")
library(pacman)

pacman::p_load(tidyverse, car, rstatix, ggpubr, 
               RVAideMemoire, psych, DescTools, patchwork,
               knitr, kableExtra, janitor, xtable)

# Importação dos dados
dados2 <- read_delim("Dados/htwt.txt", delim = " ")

#####
dados2 %>% 
  ggplot()+
  geom_point(aes(x = Wt, y = Ht))

dados2 %>% 
  summarise(
    round(min(Ht)), 
    round(quantile(Ht, .25),2),
    round(mean(Ht), 2),
    median(Ht),
    round(quantile(Ht, .75),2),
    max(Ht),
    round(sd(Ht), 2)) %>% 
  kbl(
    align = "c",
    caption = "Tabela 1: Medidas Resumo da Variável Altura",
    col.names = c("Min","Q1","Media", "MD","Q3","Max", "SD")
  ) %>% 
  kable_styling(
    latex_options = c("striped", "hover"), full_width = F)

dados2 %>% 
  summarise(
    round(min(Wt)), 
    round(quantile(Wt, .25),2),
    round(mean(Wt), 2),
    median(Wt),
    round(quantile(Wt, .75),2),
    max(Wt),
    round(sd(Wt), 2)) %>% 
  kbl(
    align = "c",
    caption = "Tabela 1: Medidas Resumo da Variável Peso",
    col.names = c("Min","Q1","Media", "MD","Q3","Max", "SD")
  ) %>% 
  kable_styling(
    latex_options = c("striped", "hover"), full_width = F)

describeBy(dados2)

mod <- lm(Wt ~ Ht, dados2)

par(mfrow = c(2, 2))

plot(mod)

par(mfrow = c(1, 1))

shapiro.test(mod$residuals)

summary(rstandard(mod))


durbinWatsonTest(mod)


bptest(mod)

summary(mod)





