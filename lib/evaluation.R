## evaluation

# load data
setwd("~/GitHub/Spring2018-Project4-grp7/data")
test <- read.csv("movie_test.csv")
test <- test[,-1]

setwd("~/GitHub/Spring2018-Project4-grp7/output/memory_based_predict/movie")
load("movie_pearson_threshold.Rdata")
pred_pear_thr <- movie_pearson_threshold
load("movie_vector_threshold.Rdata")
pred_vec_thr <- movie_vector_threshold

load("movie_pearson_bestn.Rdata")
pred_pear_bn <- movie_pearson_bestn
load("movie_vector_bestn.Rdata")
pred_vec_bn <- movie_vector_bestn

load("movie_pearson_comb.Rdata")
pred_pear_cb <- movie_pearson_comb
load("movie_vector_comb.Rdata")
pred_vec_cb <- movie_vector_comb


## MAE

#function
mae <- function(pred, test){
  mae <- mean(abs(pred - test), na.rm = T)
  return(mae)
}

#output
mae(pred_pear_thr, as.matrix(test))
mae(pred_vec_thr, as.matrix(test))
mae(pred_pear_bn, as.matrix(test))
mae(pred_vec_bn, as.matrix(test))
mae(pred_pear_cb, as.matrix(test))
mae(pred_vec_cb, as.matrix(test))


## ROC

library("pROC")

# remove NA value
roc_mat <- matrix(4,nrow = nrow(pred_pear_thr),ncol = ncol(pred_pear_thr))
test_v_0 <- as.vector(as.matrix(test))
idx1 <- which(is.na(test_v_0)==T)

pred_pear_thr_v <- as.vector(pred_pear_thr)
idx2 <- which(is.na(pred_pear_thr_v)==T)
idx <- union(idx1,idx2)
pred_pear_thr_v <- pred_pear_thr_v[setdiff(1:length(test_v_0),idx)]
test_v <- test_v_0[setdiff(1:length(test_v_0),idx)]
roc_pear_thr <- roc(test_v,as.numeric(pred_pear_thr_v))
roc_pear_thr$auc
plot(roc_pear_thr)

pred_vec_thr_v <- as.vector(pred_vec_thr)
idx2 <- which(is.na(pred_vec_thr_v)==T)
idx <- union(idx1,idx2)
pred_vec_thr_v <- pred_vec_thr_v[setdiff(1:length(test_v_0),idx)]
test_v <- test_v_0[setdiff(1:length(test_v_0),idx)]
roc_vec_thr <- roc(test_v,as.numeric(pred_vec_thr_v))
roc_vec_thr$auc
plot(roc_vec_thr)