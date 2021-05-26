# 비지도학습 - 군집화

library(ggplot2)
data(diamonds)
head(diamonds)
str(diamonds)

# 랜덤하게 1000개 뽑아서 test 만들기
t<-sample(1:nrow(diamonds),1000) 
test<-diamonds[t,]
dim(test)

mydia<-test[c("price","carat","depth","table")]


###### 계층적 클러스터 ######
dist(mydia) # 실제 거리 값 구하기
result<-hclust(dist(mydia),method="ave") #거리값을 이용핚 계층적 군집화

# hclust : dist()를 이용해서 실제 거리값을 구해서 적용시켜야함! 스스로 안해
# method="ave" 평균값으로 구해라
# !!!!!해야할것!!!! => hclust로 대략적은 k의 값을 찾아야함!!!!! 
# => k means 클러스터링 하기 위해!!

# 계층군집화 그래프 확인
plot(result, hang = -1)




###### 비계층적 클러스터 ######
result2 <- kmeans(mydia,3) # 군집수 = 3
names(result2)
str(result2)
# withinss : 군집 내 분산값 => 작을수록 좋다
# betweenss : 군집 간 분산값 => 클수록 좋다

# 군집별 통계
# subset : 행추출
g1 <- subset(mydia, result2$cluster==1)
g2 <- subset(mydia, result2$cluster==2)
g3 <- subset(mydia, result2$cluster==3)

summary(g1)
summary(g2)
summary(g3)

# 비계층적 모델
mydia$cluster <- result2$cluster
cor(mydia[,-5], method = "pearson")

# 그래프로 분포 확인
plot(mydia[,-5])

# 상관관계 있는 변수 찾음 : price, carat
# => 해당 변수로 군집별 분포 확인
plot(mydia$carat, mydia$price, col=mydia$cluster)


mydia.out.withness <-c() # 군집 내 분산
mydia.out.between <-c() # 군집 간 분산

#군집수를 k=2~7까지 변화시켜가며 클러스터링 시행
for (i in 2:7){ 
  set.seed(1) 
  mydia.out<-kmeans(mydia[,-5], centers=i)
  mydia.out.withness[i-1]<-mydia.out$tot.withinss #군집 내 제곱합의 합 
  mydia.out.between[i-1]<-mydia.out$betweenss #군집 각 제곱합의 합 
}

# 이중 폭을 많이 줄어들게 많드는 cluster 개수를 선택!
data.frame(mydia.out.withness, mydia.out.between) # 주의! data.frame 번호와 cluster 번호 다름