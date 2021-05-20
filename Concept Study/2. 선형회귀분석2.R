# cars 데이터 회귀분석
data(cars)
m <- lm(dist~speed, data=cars)

coef(m) # 추론된 계수
fitted(m)[1:4] # 1~4 데이터에 대한 적합된 값
residuals(m)[1:4] # 1~4 데이터에 대한 잔차

fitted(m)[1:4] + residuals(m)[1:4] # 추론된 적합된 값 + 잔차 = 원래 데이터 값
cars$dist[1:4]

summary(m)

# t검정 하는 이유 => '계수가 있을 떄와 없을때의 차이가 없다'를 기각이 차이가 있음을 증명하기 위해!
# => 계수가 있을 때와 없을 때의 오차의 평균을 검정 하기 위해 => '차이가 있다'를 결론을 얻고 추론된 계수값이 유의미한 것을 증명
# => p-vaule < 0.05 이면 됨
# => 즉, 각 계수의 유의미함을 검증하기 위해 t검정 함

# F검정 하는 이유 => '계수가 있을 때(추론된 회귀식)와 없을 때(y=1)의 회귀식이 같다'를 기각해 다름을 증명하기 위해!
# => 계수가 있을 때와 없을때 각 집단의 평균 오차의 성향이 다름을 증명
# => 즉, 추론회귀식의 모양(성향)이 유의미함을 검증하기 위해 F검정함

# 일반적으로 'Multiple R-squared'를 보면되고 변랑이 여러개 일때 'Adjusted R-squared' 보면됨
# => '1'에 가까울 수록 해당 회귀식이 설명력 있음


# 잔차의 산점도 시각화
par(mfrow=c(2,2),mar=c(3,3,3,3)) # plot아래에 finger의 설정으로 그래프 한번에 (2,2) 2행2열로 4개 출력하도록 설정
plot(m) # 잔차의 산점도
  
# Normal Q-Q 그래프 => 잔찰가 정규분포를 따르는지
# Leverage 그래프 => 영향력 여부 그래프

plot(cars$speed, cars$dist) # 선형적인 그래프 => 회귀분석 해도댐
abline(coef(m)) # 추정된 회귀식 그리기 - plot위에 정보 얹기!



# iris 데이터 회귀분석
# 각 w의 값이 클수록 y(종속변인)에 영향력이 크다
# Residuals - median 0에 가까울수록 굉장히 선형적이다!
# 다중 선형 회귀식
m2 <- lm(Sepal.Length~Sepal.Width+Petal.Length+Petal.Width, data=iris) 
m3 <- lm(Sepal.Length~.,data=iris) # . : 종속변인 외 나머지를 독립변인으로

# Species => factor형
# factor 형의 경우 : 벡터라이징 하기위해 한 변량을 기준으로 나머지 변량들을 추가해 벡터화



# BostonHousing 데이터 회귀분석
install.packages("mlbench")
library(mlbench)

data("BostonHousing") # 전역에 올려서 데이터셋을 사용할수 있게 해줌

m <- lm(medv~., data=BostonHousing)

# 전체를 다 넣고 회귀분석했는데 의미 없는 값이 있다고 빼면 안됨!! 여기서만 그럴뿐임 의미있는 값일지 아무도 모름!

m2 <- step(m, direction = "both") # 단계적으로 확인해서 필요한 변수 추출
# AIC가 해당 값이 유의미성을 가지는지 알려주는 지표 => 작은게 더 좋음! (변수가 적을수록 작게 나옴!)