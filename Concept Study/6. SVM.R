# SVM 머신러닝

install.packages("kernlab")
library(kernlab) # 가우시안 커널 기본 사용

m = ksvm(Species~., data=iris)
# 얼마나 훈련이 잘됬냐 예측

head(predict(m,newdata=iris))

# 특별한 변환 없이 내적 계산
ksvm(Species~. , data=iris, kernel="vanilladot")

# ploydot => 다항커널 / degree=3 => 3차원
ksvm(Species ~., data=iris, kernel="polydot", kpar=list(degree=3))



# 파라미터(gamma, cost) 값 정하기 - tune()
install.packages("e1071")
library(e1071)

# 그리드 탐색을 사용한 파라미터 튜닝
result <- tune.svm(Species~., data=iris, gamma = 2^(-1:1), cost=2^(2:4))
attributes(result) # 속성 확인
result$best.parameters # 최적 파라미터
result$best.parameters["gamma"] # 최적 파라미터 - gamma
result$best.parameters["cost"] # 최적 파라미터 - cost



# SVM 머신러닝 적용
library(caret)
idx <- createDataPartition(iris$Species, p=0.7, list=F)
iris_train <- iris[idx,] # 인덱스 중 70% 학습용 데이터 세트 추출
iris_test <- iris[-idx,] # 인덱스 중 30% 평가용 데이터 세트 추출

table(iris_train$Species)
table(iris_test$Species)

svm.result <- ksvm(Species~., iris_train, kernel="rbfdot") # 훈련데이터 통한 SVM 모형적합
svm.pred <- predict(svm.result, iris_test, type="response") # 테스트 데이터 평가
table(svm.pred, iris_test$Species) # 분류결과 도출
confusionMatrix(svm.pred, iris_test$Species)
# Senstivity : 맞는 것 중에 맞다고 판별하는 경우
# Specificity : 아닌 것 중에 아니라고 판별하는 경우

# 파마미터 넣고 다시 실행
svm.result2 <- ksvm(Species~., iris_train, kernel="rbfdot", kpar=list(sigma=0.5),C=4,prob.model=TRUE) # 훈련데이터 통한 SVM 모형적합
svm.pred2 <- predict(svm.result2, iris_test, type="response") # 테스트 데이터 평가
table(svm.pred2, iris_test$Species) # 분류결과 도출
confusionMatrix(svm.pred2, iris_test$Species)
