# USArrests 실습
data("USArrests")

library(rpart)

t1 <- rpart(UrbanPop~., data=USArrests)

# UrbanPop 데이터 탐색
hist(USArrests$UrbanPop)
plot(sort(USArrests$UrbanPop))

# 트리그래프
plot(t1, margin=.2)
text(t1, cex=0.8)

library(rattle)
library(rpart.plot)
library(RColorBrewer)
rpart.plot(t1)

fancyRpartPlot(t1)

# 살읶에 비해 강갂비율이 높은 주가 읶구 맋음 
plot(USArrests$Rape, USArrests$Murder, col=ifelse(USArrests$UrbanPop>median(USArrests$UrbanPop), "blue", "lightblue"),pch=19)
