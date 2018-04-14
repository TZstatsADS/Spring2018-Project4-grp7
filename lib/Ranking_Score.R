
#Calculate the ranking score


R<-function(predict,true,d=0,alpha=10){ # We ran a set of experiments using a halife of 10 items
                                        # and found little sensitivity of results.
  
  r<-rep(0,nrow(true))
  r_max<-rep(0,nrow(true))
  
  for(a in 1:nrow(true)){
    
    r[a]<-sort(r[a],decreasing = T)
    true[a,]<-sort(true[a,],decreasing = T)
    
    for(j in 1:ncol(true)){
      
      r[a]<-r[a]+max(predict[a,]-d,0)/2^((j-1)/(alpha-1))
      r_max[a]<-r_max[a]+sum(max(true[a,]-d,0)/2^((j-1)/(alpha-1)))
      
    }
  }
  
  rs<-100*sum(r)/sum(r_max)
  return(rs)
}