# k-meams 실습
setwd("C:\\myRwork\\MLData")

academy <- read.csv("academy.csv")
academy <- academy[,-1]

# 계층형군집
library(cluster)
hc1 <- hclust(dist(academy)^2, method = "single")
plot(hc1, hang = -1, xlab = "strudent", ylab = "distance")

# k-meas 군집
library(graphics)
kms <- kmeans(academy,5)
plot(academy, col = kms$cluster)

# Elbow point 구하기
wss <- 0

# k를 1~10까지 변화시키며서 각 withinss 값을 wss에 저장
for (i in 1:10)
  wss[i] <- sum(kmeans(academy, centers = i)$withinss)

# withinss 값을 그래프로 그리기, 기울기가 급격하게 완만해지는 부분이 보통 Elbow point!!
plot(1:10, wss, type = "b", xlab = "Number of Clusters", ylab = "Within group sum of squares") 

# 결과
# 6개로 군집화 하는 것이 가장 좋은 방법!
# kms$withinss는 군집내의 분산!