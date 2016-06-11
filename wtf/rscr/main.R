
#includes
library(moments)
library(nortest)
library(ggplot2)
library(MASS) # For the data set
library(Sleuth2)
library(PMCMR)

#local
source("axlib.R")
source("stlib.R")


#loading data
DB = loaddata.table("data.dat")

print(names(DB)); #names colum
print(head(DB));  #print 6 first row

summary(DB)
# X = as.matrix(DB);

d = dim(DB);
catg = rep(1,d[1]);
tab1  = c(catg, catg*2,catg*3,catg*4)
tab2  = c(DB[,1],DB[,2],DB[,3],DB[,4]) 
tab = cbind(tab2,tab1);
tab = as.data.frame(tab);
names(tab) <- c("datos","categorias");
tab$categorias <- factor(tab$categorias,levels=1:4,
                         labels=c("B","SVM","MLP","COMB")) 



# Kernel density plots
# grouped by number of categorias (indicated by color)
qplot(tab$datos, data=tab, geom="density", fill=categorias, alpha=I(.5), 
      main="", xlab="Accuracy", 
      ylab="Density") + 
  labs(fill="Algorithms")



# Boxplots by number of categoria 
# observations (points) are overlayed and jittered , "jitter"
qplot(categorias,tab$datos, data=tab, geom=c("boxplot"), 
      fill=categorias, main="",
      xlab="", ylab="Accuracy") +
  labs(fill="Algorithms")



# #Histogramas
# consumo = tab$datos;
# m = ggplot(tab, aes(x=consumo, y=..density.. , fill=categorias)) 
# m + geom_histogram(alpha=0.8, binwidth = 1) +
#   geom_line(stat="density", adjust=.55, alpha=0.4) +
#   expand_limits(y=0) +
#   facet_grid(categorias ~ .) +
#   labs(fill="Algorithms", x = "Energy Consumption (Joules)", y = "Density")


# Analisis aderencia

X = DB$ALL
xlab = "ALL"; ylab = "Accuracy";
st.graph.hist(DB, X,xlab,ylab)
# ggsave("graph/histnorm.png", width=4, height=4, dpi=300)

st.graph.qqnorm(DB, X, xlab, ylab)
# ggsave("graph/qqnorm.png", width=4, height=4, dpi=300)

#Test Adherencia
test_adh = st.test.adherencia(X)
test_adh$shapiro
test_adh$lillie
test_adh$anderson


# Analisis de as asmostras ------------------------------------------------


#Test de Friedman con post test de nemenyi
X = as.matrix(DB);
test_friedman = st.test.friedman(X, 0.05)
test_friedman$tfriedman
test_friedman$ptnemenyi

