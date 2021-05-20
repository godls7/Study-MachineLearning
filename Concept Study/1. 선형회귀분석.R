data(cars)

m <- lm(dist~speed, data=cars)
# cofficients(intercept) : -17.579 / speed : 3.392
# dist = 3.932 * speed -17.579 => 최종 회귀식

# Residuals : 잔차(오차) => 오차가 너무 크면...? 회귀분석의 의미가 없음....그래서 검정해야함

# t값은 각 독립변수의 유의성을 판단하기 위한 통계량
# F값은 모형의 유의성을 판단하기 위한 통계량

# coefficients : 계수
# Estimate : 추정계수
# Std. Error : 표본집단 표본평균들의 표준편차 오차 : -17.5791 / 3.9324 => 이 계수가 있을 때의 오차
# 오차의 평균의 차이를 알기위해 t검정 
# (모집단의 coefficieints의 값은 =0)
# 따라서, p-valuse의 값에 따라 0.05보다 작으면 '오차의 차이가 없다'인 귀무가설 기각 => '오차의 차이가 있다' 가 나와야함

# R-squared : 값이 1에 가까울수록 예측을 잘한 회귀분석

# 변랑을 넣은 수식과 아닌 수식 간의 차이가 있음을 알기 위해 (모형의 유의성을 판단하기 위해) => F검정


# iris 데이터
data <- iris
result <- lm(Petal.Length~Petal.Width, data=data)

