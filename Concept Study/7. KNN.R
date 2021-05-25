# KNN

# 산점도 데이터
library(ggvis)
# ~ : 앞에 있는 데이터에 모두
iris %>% ggvis(~Sepal.Length, ~Sepal.Width, fill = ~factor(Species)) %>% layer_points()


## train, test set 만들기 1
library(caret)
idx <- createDataPartition(iris$Species, p=0.7, list=F)

iris_train <- iris[idx,] # 생성된 인덱스를 이용, 70% 비율로
iris_test <- iris[-idx,] # 생성된 인덱스를 이용, 30% 비율로

table(iris_train$Species)
table(iris_test$Species)

install.packages("class")
library(class)

ml <- knn(train=iris_train[,-5], test = iris_test[,-5],
          cl=iris_train[,5],k=3)
# trian : Species 만 빼고 넣기
# cl : Species 만 넣기



## train, test set 만들기 2
set.seed(1234)
knn_1 <- knn(train=train_x, test=valid_x, cl= train_y, k=1)
set.seed(1234)

idx <- sample(1:NROW(iris), 0.7*NROW(iris))
iris.train <- iris[idx,] # 생성된 인덱스를 이용, 70% 비율로
iris.test <- iris[-idx,] # 생성된 인덱스를 이용, 30% 비율로

iris_model <- knn(train=iris.train[,-5], test=iris.test[,-5],
                  cl=iris.train$Species, k=3)

summary(iris_model)
table(iris_model, iris.test$Species)


### train 산점도 그리기
par(mar=c(2,2,2,2))

plot(Sepal.Length~Sepal.Width, 
     data=iris.train, 
     col=c("purple","blue","green")[iris.train$Species], 
     main="KNN(k=3)")

# knn 예측치 결과 표시하기
points(Sepal.Length~Sepal.Width, 
       data=iris.train, 
       pch=17, 
       cex=1.2,
       col=c("purple","blue","green")[iris_model])
