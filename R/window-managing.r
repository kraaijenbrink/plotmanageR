# Functions to control external windows
# Only tested on windows
#
# Philip Kraaijenbrink
# 20181017



# get system as string  ====================================

# function taken from R-bloggers:
# https://www.r-bloggers.com/identifying-the-os-from-r/

getOS <- function(){
  sysinf <- Sys.info()
  if (!is.null(sysinf)){
    os <- sysinf['sysname']
    if (os == 'Darwin')
      os <- "osx"
  } else { ## mystery machine
    os <- .Platform$OS.type
    if (grepl("^darwin", R.version$os))
      os <- "osx"
    if (grepl("linux-gnu", R.version$os))
      os <- "linux"
  }
  tolower(os)
}


# open an x11 window ====================================
openWindow <- function(){
  if (getOS() == 'windows') {
    grDevices::windows(
      width  = 8,
      height = 8,
      record = T,
      restoreConsole=T
    )
  } else{
    grDevices::x11(
      width  = 8,
      height = 8
    )
  }
}


# switch active plot window  ====================================
nextWindow <- function(){
  grDevices::dev.set()
}
prevWindow <- function(){
  grDevices::dev.set(
    which=grDevices::dev.prev()
  )
}


# close all active plot windows  ====================================
closeAllWindows <- function(){
  devs  <- dev.list()
  ndevs <- length(devs)
  if (ndevs){
    if ('RStudioGD' %in% names(devs)){
      ndevs <- ndevs-1
    }
    for (i in 1:ndevs){
      dev.off()
    }
  }
}
