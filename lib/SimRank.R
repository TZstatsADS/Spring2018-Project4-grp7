Compute_User_SimRank0 <- function(j,k,data){
  if (j == k){R <- 1}
  else{
    userj <- which(data[j,] == 1)
    userk <- which(data[k,] == 1)
    if ((length(userj)+length(userk)-length(unique(c(userj,userk)))
         <= 0.25 * min(length(userj),length(userk)))){R <- 0}
    else{
      R <- ((length(userj) + length(userk) - 
         length(unique(c(userj,userk)))) * 0.8 / 
        length(userk) / length(userj))
    }
  }
  return(R)
}

Compute_Movie_SimRank0 <- function(j,k,data){
  if (j == k){R <- 1}
  else{
    moviej <- which(data[j,] == 1)
    moviek <- which(data[k,] == 1)
    if ((length(moviej)+length(moviek)-length(unique(c(moviej,moviek)))
         <= 0.25 * min(length(moviej),length(moviek)))){R <- 0}
    else{
      R <- ((length(moviej) + length(moviek) - 
               length(unique(c(moviej,moviek)))) * 0.8 / 
              length(moviek) / length(moviej))
    }
  }
  return(R)
}

Compute_User_SimRank1 <- function(j,k,data){
  if (j == k){R <- 1}
  else{
    userj <- which(data[j,] == 1)
    userk <- which(data[k,] == 1)
    if ((length(userj)+length(userk)-length(unique(c(userj,userk)))
         <= 0.25 * min(length(userj),length(userk)))){R <- 0}
    else{
      sum <- 0
      for (i in userj){
        for (j in userk){
          sum <- sum + MovieSimRank0[i,j]
        }
      }
      R <- (sum * 0.8 / length(userk) / length(userj))
    }
  }
  return(R)
}
