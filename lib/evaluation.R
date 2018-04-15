## MAE
test <- read.csv("../data/movie_test.csv")
setwd("~/GitHub/Spring2018-Project4-grp7/output/memory_based_predict/movie")
load("movie_pearson_threshold.Rdata")
pred_pear <- movie_pearson_threshold
load("movie_vector_threshold.Rdata")
pred_vec <- movie_vector_threshold

mae <- function(pred, test){
  mae <- mean(abs(pred - test), na.rm = T)
  return(mae)
}

test <- test[,-1] 
mae(pred_pear, as.matrix(test))
mae(pred_vec, as.matrix(test))


## ROC
library("pROC")
roc_mat <- matrix(4,nrow = nrow(pred_pear),ncol = ncol(pred_pear))
#pred_pear_v <- as.vector(((pred_pear>=roc_mat) == (test >= roc_mat)))
#pred_pear_v <- pred_pear_v[is.na(pred_pear_v)]
pred_pear_v <- as.vector(pred_pear)
test_v <- as.vector(as.matrix(test))
idx1 <- which(is.na(pred_pear_v)==T)
idx2 <- which(is.na(test_v)==T)
idx <- union(idx1,idx2)
pred_pear_v <- pred_pear_v[setdiff(1:length(test_v),idx)]
test_v <- test_v[setdiff(1:length(test_v),idx)]
roc_pear <- roc(test_v,as.numeric(pred_pear_v))
plot(roc_pear)
roc_pear$auc
roc_pear
