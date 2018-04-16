movie_train <- read.csv("movie_train.csv")
movie_test <- read.csv("movie_test.csv")
movie_user_train_simrank <- movie_train[1:100, 2:101]
movie_user_test_simrank <- movie_test[1:100, 2:101]

for (i in 1 : nrow(movie_user_train_simrank)){
  for (j in 1: ncol(movie_user_train_simrank)){
    movie_user_train_simrank[i,j] <- ifelse(movie_user_train_simrank[i,j] >= 4, 1, NA)
  }
}

for (i in 1 : nrow(movie_user_test_simrank)){
  for (j in 1: ncol(movie_user_test_simrank)){
    movie_user_test_simrank[i,j] <- ifelse(movie_user_test_simrank[i,j] >= 4, 1, NA)
  }
}

UserSimRank0 <- matrix(0, nrow = nrow(movie_user_train_simrank), 
                               ncol = nrow(movie_user_train_simrank))

for (i in 1:nrow(movie_user_train_simrank)) {
  for (j in 1:nrow(movie_user_train_simrank)){
    UserSimRank0[i,j] <- Compute_User_SimRank0(i,j,movie_user_train_simrank)
  }
}

MovieSimRank0 <- matrix(0, nrow = ncol(movie_user_train_simrank), 
                       ncol = ncol(movie_user_train_simrank))

for (i in 1:ncol(movie_user_train_simrank)) {
  for (j in 1:ncol(movie_user_train_simrank)){
    MovieSimRank0[i,j] <- Compute_Movie_SimRank0(i,j,t(movie_user_train_simrank))
  }
}

UserSimRank1 <- matrix(0, nrow = nrow(movie_user_train_simrank), 
                       ncol = nrow(movie_user_train_simrank))

for (i in 1:nrow(movie_user_train_simrank)) {
  for (j in 1:nrow(movie_user_train_simrank)){
    UserSimRank1[i,j] <- Compute_User_SimRank1(i,j,movie_user_train_simrank)
  }
}