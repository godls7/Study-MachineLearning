install.packages("C50")
library("C50")

# 모든 데에터 전처리 완료 후, 데이터 분할
# 데이터 분할?을 위한 패키지
install.packages("caret")
install.packages("caret", dependencies=TRUE, repos='http://cran.rstudio.com/')

library("caret")
# set.seed(1) # 난수 생성 값 고정
idx <- createDataPartition(iris$Species, p=0.7, list=F)

# train, test 데이터에 몇 개씩 분포 되어있나 확인하기위해!
iris_train <- iris[idx, ] #생성된 인덱스를 이용, 70%의 비율로 학습용 데이터 세트 추출
iris_test <- iris[-idx, ] #생성된 인덱스를 이용, 30%의 비율로 평가용 데이터 세트 추출 
table(iris_train$Species) # 범주형(분류형)은 table로 확인!
table(iris_test$Species)

# 분석 -> fitting / 머신러닝 -> training
#의사결정트리 기법을 사용하기 위핚 rpart 패키지 로딩
library(rpart) 
#훈련데이터 통합 모형 적합
rpart.result <- rpart(Species~., iris_train) # rpart(영향을 받는 것 ~ .(나머지))
rpart.result # 객체지향 object형으로 저장!

# 1) root 105 70 setosa (0.33333333 0.33333333 0.33333333)
# => setosa를 기준으로 불순이 70개!!
# => 105개중 setosa가 35개임!

# 2) Petal.Length< 2.6 35  0 setosa (1.00000000 0.00000000 0.00000000) *
# => *: leaf node
# => 35개 setosa 중에 불순도 0 => 모두 setosa 아주 perfect

#  6) Petal.Width< 1.65 37  2 versicolor (0.00000000 0.94594595 0.05405405) *
# => 37개 versicolor 중에 불순도 2 => 2개의 virginica가 포함 되어 있다는 얘기!

# 트리 그래프로 확인
plot(rpart.result,margin=0.2)
text(rpart.result,cex=0.8)

install.packages("rattle")
library(rattle)
library(rpart.plot)
library(RColorBrewer)

# 트리 플롯 그리기기
rpart.plot(rpart.result)

# 테스트 데이터 이용 평가
rpart.pred <- predict(rpart.result, iris_test, type="class")
# 분류 결과도출
table(rpart.pred, iris_test$Species)

install.packages("e1071")
library("e1071")
confusionMatrix(rpart.pred, iris_test$Species)

