setwd('C:/Users/donal/OneDrive/桌面/datathon')
library(readr)
library(ggplot2)
library(dplyr)
#install.packages('tidyverse')
library(tidyverse)

#read data
df=read.csv('cleancomplaint.csv')

# We exclude 2011 for only 0.1% of original data
sum(df$year == 2011)/length(df$year)

# Then we select data from 2012 to 2019
df1219=df[(df$year >2011)&(df$year <2020),]

#####Yearly trend, breakdown by product####
productyear = df1219 %>% group_by (year,Product) %>% summarise(count_id=n())

# future step: sort the product in stacked bar chart
#bar plot
ggplot(productyear[order(productyear$count_id,decreasing = T),], aes(fill=Product, y=count_id, x=year)) + 
  geom_bar(stat="identity") + scale_color_brewer(palette = "Set2")+ theme(axis.title.y = element_blank(),legend.position="left")


#####Sub product of "credit reporting" and "debt collection" composition in pie chart####

#select data related to credit reporting 
creditreport=df[df$Product=='Credit reporting, credit repair services, or other personal consumer reports',]

creditreport[creditreport$Sub.product=='',]$Sub.product='Credit reporting'

#breakdown by sub product
creditreportpro = creditreport %>% group_by(Sub.product) %>% summarise(count=n())
# drop category with only 1 record
creditreportpro=creditreportpro[-1,]
creditreportpro=creditreportpro[order(-creditreportpro$count),]

#pie plot of sub product in credit reporting.
ggplot(creditreportpro, aes(x='',y=count,fill=Sub.product)) + geom_bar(stat = 'identity', width =1) + 
  coord_polar('y',start=0) +
  #scale_fill_brewer(palette="Set1")+
  theme(axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid  = element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_blank())

#select data which under debt collection in sub product
debitcollect = df[which(df$Product == 'Debt collection'),] %>% group_by(Sub.product) %>% summarise(count=n())

#pie plot of sub product in debt collection.
ggplot(debitcollect, aes(x='',y=count,fill=Sub.product)) + geom_bar(stat = 'identity', width =1) + 
  coord_polar('y',start=0) +
  theme(axis.text = element_blank(),
        panel.grid  = element_blank(),axis.title.y = element_blank())

#####Explore top 10 companies with most complaints, breakdwon by product
companyproduct = df %>% group_by (Company,Product) %>% summarise(count_id=n())
company = df %>% group_by (Company) %>% summarise(count_id=n())
topcompanies=company[order(company$count_id,decreasing = T),1][c(1:10),]
companyproducttop10 = companyproduct[companyproduct$Company %in% topcompanies$Company,]
companyproducttop10 = companyproducttop10[order(-companyproducttop10$count_id),]

#Vertical stacked bar plot
ggplot(companyproducttop10, aes(fill=Product, y=count_id, x=reorder(Company,count_id))) + 
  geom_bar(stat="identity") + scale_color_brewer(palette = "Set2")+ coord_flip() +  xlab("Company")
companyyear = df1219 %>% group_by (Company,year) %>% summarise(count_id=n())
companyyeartop10 = companyyear[companyyear$Company %in% topcompanies$Company,]
ggplot(companyyeartop10,aes(x=year,y=count_id,color=Company))+geom_line(size=1.1)+ theme(axis.title.y = element_blank())

#future steps:  align similar issues