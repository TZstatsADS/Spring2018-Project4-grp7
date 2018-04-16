## evaluation

options(warn = -1)

# load data
setwd("~/GitHub/Spring2018-Project4-grp7/data")
test <- read.csv("movie_test.csv")
test <- test[,-1]
test2 <- test[1:100,]

setwd("~/GitHub/Spring2018-Project4-grp7/output/memory_based_predict/movie")
load("movie_pearson_threshold.Rdata")
pred_pear_thr <- movie_pearson_threshold
load("movie_vector_threshold.Rdata")
pred_vec_thr <- movie_vector_threshold
load("movie_simrank_threshold.Rdata")
pred_sim_thr <- movie_simrank_threshold

load("movie_pearson_bestn.Rdata")
pred_pear_bn <- movie_pearson_bestn
load("movie_vector_bestn.Rdata")
pred_vec_bn <- movie_vector_bestn
load("movie_simrank_bestn.Rdata")
pred_sim_bn <- movie_simrank_bestn

load("movie_pearson_comb.Rdata")
pred_pear_cb <- movie_pearson_comb
load("movie_vector_comb.Rdata")
pred_vec_cb <- movie_vector_comb
load("movie_simrank_comb.Rdata")
pred_sim_cb <- movie_simrank_comb


## MAE

#function
mae <- function(pred, test){
  mae <- mean(abs(pred - test), na.rm = T)
  return(mae)
}

#output
mae(pred_pear_thr, as.matrix(test))
mae(pred_vec_thr, as.matrix(test))
mae(pred_sim_thr, as.matrix(test2))
mae(pred_pear_bn, as.matrix(test))
mae(pred_vec_bn, as.matrix(test))
mae(pred_sim_bn, as.matrix(test2))
mae(pred_pear_cb, as.matrix(test))
mae(pred_vec_cb, as.matrix(test))
mae(pred_sim_cb, as.matrix(test2))


## ROC

library("pROC")

#function
# remove NA value
test_v_0 <- as.vector(as.matrix(test))
test_v_1 <- as.vector(as.matrix(test2))
idx0 <- which(is.na(test_v_0)==T)
idx1 <- which(is.na(test_v_1)==T)

auc <- function(Pred,Test,Idx){
  pred_v <- as.vector(Pred)
  idx2 <- which(is.na(pred_v)==T)
  idx <- union(Idx,idx2)
  pred_v <- pred_v[setdiff(1:length(Test),idx)]
  test_v <- Test[setdiff(1:length(Test),idx)]
  Roc <- roc(test_v,pred_v)
  return(Roc$auc)
}

curve <- function(Pred,Test,Idx){
  pred_v <- as.vector(Pred)
  idx2 <- which(is.na(pred_v)==T)
  idx <- union(Idx,idx2)
  pred_v <- pred_v[setdiff(1:length(Test),idx)]
  test_v <- Test[setdiff(1:length(Test),idx)]
  Roc <- roc(test_v,pred_v)
  curve <- plot(Roc) 
  return(curve)
}


#output
 
auc(pred_pear_thr,test_v_0,idx0)
curve(pred_pear_thr,test_v_0,idx0)
auc(pred_vec_thr,test_v_0,idx0)
curve(pred_vec_thr,test_v_0,idx0)
auc(pred_sim_thr,test_v_1,idx1)
curve(pred_sim_thr,test_v_1,idx1) 

auc(pred_pear_bn,test_v_0,idx0)
curve(pred_pear_bn,test_v_0,idx0)
auc(pred_vec_bn,test_v_0,idx0)
curve(pred_vec_bn,test_v_0,idx0)
auc(pred_sim_bn,test_v_1,idx1)
curve(pred_sim_bn,test_v_1,idx1) 

auc(pred_pear_cb,test_v_0,idx0)
curve(pred_pear_cb,test_v_0,idx0)
auc(pred_vec_cb,test_v_0,idx0)
curve(pred_vec_cb,test_v_0,idx0)
auc(pred_sim_cb,test_v_1,idx1)
curve(pred_sim_cb,test_v_1,idx1)
