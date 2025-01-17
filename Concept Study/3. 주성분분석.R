##국어, 영어,수학,과학
#16명의 국어점수
x1<-c(26,46,57,36,57,26,58,37,36,56,78,95,88,90,52,56)
x2<-c(35,74,73,73,62,22,67,34,22,42,65,88,90,85,46,66)
x3<-c(35,76,38,69,25,25,87,79,36,26,22,36,58,36,25,44)
x4<-c(45,89,54,55,33,45,67,89,47,36,40,56,68,45,37,56)

score <- cbind(x1,x2,x3,x4)
colnames(score) <- c("국어","영어","수학","과학")
rownames(score) <- 1:16

# 주성분분석(PCA)
result <- prcomp(score)
result
# 여기에 나온 값이 w 가중치 들!
# 즉, 어떤 변수의 해당하는 가중치가 높아야 그 변수를 식별하기 용이함!

# standard deviation : 표준편차 => 높은 수록 분산이 큼
# cumulative proportion : 누적비율 => 전체 데이터 중 해당 퍼센트만큼 설명 가능
# 따라서, PC2의 0.9317는 전체 데이터의 약 93퍼센트를 설명 가능하므로 PC2 주성분까지 채택 (보통 70~80프로면 채택)

biplot(result) # 빨간색 선이 원데이터의 축
screeplot(result,npcs=4,type="lines",main="Score")