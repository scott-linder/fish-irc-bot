msg $chan (find data/file/ -type f | sed 's#^data/file/\(.*\)$#\1#' | tr \n ' ')
