setwd('C:/Users/donal/OneDrive/桌面/datathon')
library(readr)
library(ggplot2)
library(dplyr)
install.packages('tidyverse')
library(tidyverse)
#df=read.csv('cleancomplaint.csv')
df=read.csv('cleancomplaint (2).csv')


sum(df$year == 2011)
df1219=df[(df$year >2011)&(df$year <2020),]
productyear = df1219 %>% group_by (year,Product) %>% summarise(count_id=n())
#df1[df1$year >2011&df1$year <2020,]
# future step: sort the product in stacked bar chart
#pyorder=productyear[order(productyear$count_id,decreasing = T),]
#View(pyorder)
ggplot(productyear[order(productyear$count_id,decreasing = T),], aes(fill=Product, y=count_id, x=year)) + 
  geom_bar(stat="identity") + scale_color_brewer(palette = "Set2")+ theme(axis.title.y = element_blank(),legend.position="left")

#table(df$Product)
creditreport=df[df$Product=='Credit reporting, credit repair services, or other personal consumer reports',]
table(creditreport$Sub.product)
creditreport[creditreport$Sub.product=='',]$Sub.product='Credit reporting'
creditreport = creditreport %>% group_by(Sub.product) %>% summarise(count=n())
table(creditreport$Sub.product)
creditreport=creditreport[-1,]
creditreport=creditreport[order(-creditreport$count),]

ggplot(creditreport, aes(x='',y=count,fill=Sub.product)) + geom_bar(stat = 'identity', width =1) + 
  coord_polar('y',start=0) +
  #scale_fill_brewer(palette="Set1")+
  theme(axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid  = element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_blank())

debitcollect = df[which(df$Product == 'Debt collection'),] %>% group_by(Sub.product) %>% summarise(count=n())

ggplot(debitcollect, aes(x='',y=count,fill=Sub.product)) + geom_bar(stat = 'identity', width =1) + 
  coord_polar('y',start=0) +
  theme(axis.text = element_blank(),
        panel.grid  = element_blank(),axis.title.y = element_blank())

companyproduct = df %>% group_by (Company,Product) %>% summarise(count_id=n())
company = df %>% group_by (Company) %>% summarise(count_id=n())
topcompanies=company[order(company$count_id,decreasing = T),1][c(1:10),]
companyproducttop10 = companyproduct[companyproduct$Company %in% topcompanies$Company,]
companyproducttop10 = companyproducttop10[order(-companyproducttop10$count_id),]

ggplot(companyproducttop10, aes(fill=Product, y=count_id, x=reorder(Company,count_id))) + 
  geom_bar(stat="identity") + scale_color_brewer(palette = "Set2")+ coord_flip() +  xlab("Company")
companyyear = df1219 %>% group_by (Company,year) %>% summarise(count_id=n())
companyyeartop10 = companyyear[companyyear$Company %in% topcompanies$Company,]
ggplot(companyyeartop10,aes(x=year,y=count_id,color=Company))+geom_line(size=1.1)+ theme(axis.title.y = element_blank())

# need to figure out replace part of string. We replace string in python
# install.packages('stringr')
# library(stringr)
# uniproductdf= df
# uniproductdf$Product =uniproductdf$Product %>%  str_replace_all('Credit card','Credit card or prepaid card')  %>%  str_replace_all('Credit card or prepaid card or prepaid card','Credit card or prepaid card')
# uniproductdf = uniproductdf %>% group_by (year,Product) %>% summarise(count_id=n())
# ggplot(uniproductdf[order(uniproductdf$count_id,decreasing = T),], aes(fill=Product, y=count_id, x=year)) + 
#   geom_bar(stat="identity") + scale_color_brewer(palette = "Set2")
