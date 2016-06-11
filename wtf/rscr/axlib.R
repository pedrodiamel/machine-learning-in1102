## If you want to source() a bunch of files, something like
## the following may be useful:
sourcedir <- function(path, trace = TRUE, ...) {
    for (nm in list.files(path, pattern = "[.][RrSsQq]$")) {
       if(trace) cat(nm,":")
       source(file.path(path, nm), ...)
       if(trace) cat("\n")
    }
}

##Loading data
loaddata.csv <- function( path )
{
	#Load data
	con = file(path, "r");
	DB <- read.csv(con, head=T, sep=";");
	close(con);	
	return(DB);
}

##Loading data
loaddata.table <- function( path )
{
  #Load data
  con = file(path, "r");
  DB <- read.table(con, head=T, sep=",");
  close(con);	
  return(DB);
}

