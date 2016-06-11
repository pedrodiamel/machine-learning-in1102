
#' Estadastica descriptiva
#'
#' @param X dados de la tabla
#'
#' @return 
#' @export
#'
#' @examples
st.descrip_measure <- function( X ){
  
  media = mean(X);  
  desviacion = sd(X);  
  varianza = var(X); 
  minimo = min(X);  
  maximo = max(X); 
  mediana = median(X); 
  rango = range(X); 
  quartiles = quantile(X); 
  n = length(X);
  kt = kurtosis(X);
  skw = skewness(X);
  
  res = list(media = media, desviacion = desviacion,  
             varianza = varianza, minimo = minimo, maximo = maximo,
             mediana = mediana, rango = rango, quartiles =quartiles,
             n = n, kt = kt, skw = skw);
  
  return (res)
  
  
}

st.descrip_measure.toSting <- function(X){
  
  minimo = min(X); 
  quartiles = quantile(X); 
  mediana = median(X);
  media = mean(X);  
  desviacion = sd(X);  
  varianza = var(X); 
  maximo = max(X); 
  n = length(X);
  
  rango = range(X); 
  kt = kurtosis(X);
  skw = skewness(X);
  
  cat("minimo:", minimo,"\n")
  cat("quartiles:", quartiles[1], quartiles[2], quartiles[3], quartiles[4], quartiles[5],"\n")
  cat("mediana:", mediana,"\n")
  cat("media:", media ,"\n")
  cat("desviacion:", desviacion,"\n")
  cat("varianza:", varianza,"\n")
  cat("maximo:", maximo,"\n")
  cat("cout:", n,"\n")
  cat("rango:", rango[1],rango[2],"\n")
 
  
  cat("kurtosis:", kt,"\n")
  cat("skewness:", skw,"\n")
  
  
}



#' Analisis: Histograma 
#'
#' @param Tab tabla
#' @param X campo
#' @param xlab, ylab
#'
#' @return
#' @export
#'
#' @examples
#' 
#' 
st.graph.hist <- function(Tab, X, xlab, ylab){

  #Histograma
  ggplot(Tab, aes(x=X)) +
    geom_histogram(
      aes(y=..density..),
      binwidth = 0.03,
      colour="black", 
      fill="white" 
    ) +
    stat_function(fun=dnorm, 
                  args=list(mean=mean(X), sd=sd(X)), 
                  color ="red") +
    xlab(xlab) + 
    ylab(ylab)
   
  
}


#' Analisis: QQnorm 
#'
#' @param Tab 
#' @param X 
#' @param xlab 
#' @param ylab 
#'
#' @return
#' @export
#'
#' @examples
st.graph.qqnorm <- function(Tab, X, xlab="X", ylab="Y"){
  
  
  
  y <- quantile(X, c(0.25, 0.75))
  x <- qnorm(c(0.25, 0.75))
  slope <- diff(y)/diff(x)
  int <- y[1L] - slope * x[1L]
  
  
  #Q-Q
  ggplot(Tab, aes(sample = X)) + 
    stat_qq(alpha = 0.5) +
    geom_abline(slope = slope, intercept = int, color="red") +
    ylab(ylab) + 
    xlab(xlab)
  
  
  
  
}






#' Title
#'
#' @param Test Adherencia
#' H_0: X es normal
#' H_1: X no es normal 
#'
#' @return
#' @export
#'
#' @examples
st.test.adherencia <- function ( X ){
  
  
  # Shapiro Wilk test
  swt = shapiro.test(X);
  
  # Lillie test
  #Performs the Lilliefors (Kolmogorov-Smirnov) test 
  #for the composite hypothesis of normality, see e.g. 
  #Thode (2002, Sec. 5.1.1).
  llt = lillie.test(X);
  
  
  #Performs the Anderson-Darling test for 
  #the composite hypothesis of normality, see e.g. 
  #Thode (2002, Sec. 5.1.4).
  adt = ad.test(X)
  
  
  # Kormogorov Smirnov test
  #kst = ks.test(X, "pnorm", mean(X), sd(X));
  kst = 0;
  
  
  res = list(shapiro = swt, lillie = llt, anderson = adt, kormogorov = kst );
  return (res)
  
}




#' Test no parametrico de friedman con post test de nemenyi
#' H_0: mu_1 = mu_2 = ... m_n
#' H_1: Emu_i != mu_j, i!=j 
#' 
#' @param X datos
#' @param p nivel de significancia 
#'
#' @return
#' @export
#'
#' @examples
st.test.friedman <- function(X, p){
  
  
  #Test de friedman
  tf = friedman.test(X); 
  ptn = 0; 
  
  
  #Si existen diferencias significativas
  #aplicar post test
  if ( tf$p.value < p ){ 
    
    #Post test de nemenyi
    ptn = posthoc.friedman.nemenyi.test(X);
  
  }
  
  res = list(tfriedman = tf, ptnemenyi = ptn)
  return (res);
  
  
}


