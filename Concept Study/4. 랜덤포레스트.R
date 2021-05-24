install.packages("randomForest")

library(randomForest)

data(iris)
# iris 데이터 randomForest 시행
rf <- randomForest(Species~. ,  data=iris)

# 변수 직접 지정해 빠른모뎅일 => 메모리 적게 사용
rf2 <- randomForest(iris[,1:4],iris[,5])

# 변수 중요도 평가 추가
rf3 <- randomForest(Species~., data=iris, importance=TRUE)
importance(rf3)

# 그래프로 확인
varImpPlot(rf3, main="varImplot of iris")