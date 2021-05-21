library(aod)
library(ggplot2)

mydata <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")

sapply(mydata, sd)
xtabs(~admit+rank, data=mydata)

mydata$rank <- factor(mydata$rank)

mylogit <- glm(admit~gre+gpa+rank, data = mydata, family = "binomial")
summary(mylogit)

exp(coef(mylogit))
# 이 값이 1 이면 성공확률/실패확률 = 1 이란 소리
# => 해당 값은 성공,실패 확률이 똑같으므로 해당 변수는 성공,실패에 큰 영향이 없다
# 이 값이 2 이면 성공확률/실패확률 = 2이란 소리
# => 즉, 해당 변수의 값은 성공할 확률이 실패할 확률보다 2배 높다
# 이 값이 1 보다 작으면 실패확률이 더 높단 소리