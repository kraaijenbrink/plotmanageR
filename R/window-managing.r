# Functions to control external windows
# Only works on windows (for now)

# get system as string
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

# open an x11 window
openWindow <- function(){
  if (getOS() == 'windows'){
    windows(width=8, height=8, record=T)
  }else{
    x11(width=8, height=8)
  }
}

# switch active plot window
nextWindow <- function(){
  grDevices::dev.set()
}
prevWindow <- function(){
  grDevices::dev.prev()
}

