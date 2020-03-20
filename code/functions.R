

F_to_K <- function(temp){
  K <- ((temp - 32) * (5/9)) + 273.15
  return(K)
}

K_to_C <- function(temp){
  C <- (temp - 273.15)
  return(C)
}
