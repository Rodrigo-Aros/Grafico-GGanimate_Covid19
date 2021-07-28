library(readr)
library(tidyverse)
library(patchwork)

datos<-read.csv2("https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto4/2021-05-26-CasosConfirmados-totalRegional.csv",sep = ",", encoding="UTF-8")
datos<-datos[1:16,]

colnames(datos)
glimpse(datos)
str(datos)
summary(datos)


ggplot(datos,
       aes(x=datos$Casos.confirmados.recuperados, y=datos$Casos.nuevos.totales, fill=datos$Casos.totales.acumulados)) +
  geom_point()

# ventiladores ------------------------------------------------------------

vent<-read.csv2("https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto20/NumeroVentiladores_T.csv",sep = ",", encoding = "UTF-8")       
vent[,1]<-substring(vent$Ventiladores,1,10)
vent[,1]<- as.Date(vent$Ventiladores)
vent[1,2:4]<- as.numeric()
class(vent$Ventiladores)
vent<-t(vent)



vent<- vent %>% mutate(año= substring(vent$Ventiladores,1,4)) %>% 
  mutate(mes= substring(vent$Ventiladores,6,7))
                


# real carajo -------------------------------------------------------------

vent<-vent %>%
  gather(variable, valor, disponibles, ocupados,total)


# Ploteo ------------------------------------------------------------------

ggplot(vent,
       aes(x=vent$Ventiladores, y=vent$valor, colour=variable, group=variable))+
  geom_line(size=1) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 0.5)) +
  labs(title = "Evolución camas críticas expresado en ventiladores Nacional",
       subtitle = "Cantidad ventiladores período 2020-2021",
       caption = "Datos: MinCiencia al 17-06-2021",
       x="Periodo 2020-2021",
       y="Cantidad de ventiladores")

  