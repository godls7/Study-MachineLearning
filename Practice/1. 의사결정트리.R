setwd("C:\\myRwork\\MLData")
skin <- read.csv("skin.csv", header=T)
skin <- skin[-1]

library(rpart)
tree1 <- rpart(쿠폰반응여부~., data=skin, control=rpart.control(minsplit = 2))

plot(tree1, compress=T, uniform = T, margin = 0.1)
text(tree1, use.n = T, col="blue")

library(rattle)
library(rpart.plot)
library(RColorBrewer)

rpart.plot(tree1)
fancyRpartPlot(tree1)

a <- xtabs(~결혼여부+쿠폰반응여부, data=skin)
chisq.test(a) 5#카이제곱 검정
# 카이제곱 =>0 독립성검사
# p-vaule <= 
# 즉, 결혼여부와 쿠폰반응여부 사이에 연관관계가 있다

# 쿠폰반응여부의 지니계수
first_gini <- info_gini(skin[,"쿠폰반응여부부"])
