# 일원 분산분석
## 예1. 편의점 만족도

### 방법1) 식을 이용해서 계산

x <- rep(c("A","B","C"), c(7,8,9))
x
ya <- c(1,4,3,3,3,3,3)
yb <- c(4,4,5,4,4,5,4,4)
yc <- c(4,3,4,3,4,4,3,3,3)
y <- c(ya, yb, yc)

ma <- mean(ya); mb <- mean(yb); mc <- mean(yc)
my <- mean(y)
na <- length(ya); nb <- length(yb); nc <- length(yc)

r.df <- 2
e.df <- (na+nb+nc)-3

SSR <- sum((ma-my)^2)*na + sum((mb-my)^2)*nb + sum((mc-my)^2)*nc
SSE <- sum((ya-my)^2) + sum((yb-my)^2) + sum((yc-my)^2)

MSR <- SSR/r.df
MSE <- SSE/e.df

f.stat <- MSR/MSE

alpha <- 0.05
SSR
SSE
MSE
MSR
f.stat
pf(f.stat, r.df, e.df, lower.tail = F)

### 방법2) aov() 함수를 이용하여 분석
x
x<-factor(x)

help(aov)
summary(aov(y~x))

## 데이터 프레임으로 데이터를 만든 후 aov() 함수 사용
store <- data.frame(x,y)
store$x <- factor(store$x)
str(store)

summary(aov(y~x, data=store))

## 예2.
y <- c(681, 728, 917, 898, 620,
       643, 655, 742, 513, 525,
       469, 727, 525, 454, 459,
       384, 656, 602, 687, 360)
x <- rep(c('소형','준중형','중형','대형'), c(5,5,5,5))
x <- factor(x)
y
x
aov.result <- aov(y~x)
summary(aov.result)

## 예3. mtcars 데이터의 실린더에 따른 연비 비교
mtcars$cyl <- factor(mtcars$cyl)

aovm <- aov(mpg ~ cyl, data=mtcars)
summary(aovm) # aov는 summary()를 해줘야 분산분석 결과 확인 가능

attach(mtcars)
aggregate(mpg, by=list(cyl), FUN=mean)
detach(mtcars)

plotmeans(mpg~cyl, data=mtcars, xlab='Treatment', ylab='Response',
          main='Mena Plot with 95% CI')

############################################################
### 예4. multcomp::cholesterol 데이터 이용한 분산분석
install.packages('multcomp')
library(multcomp)

attach(cholesterol)
table(trt)
aggregate(response, by=list(trt), FUN=mean)
aggregate(response, by=list(trt), FUN=sd)

fit <- aov(response~trt)
summary(fit)


## mean plot

install.packages('gplots')
library(gplots)
plotmeans(response~trt, xlab='Treatment', ylab='Response', 
          main='Mean Plot witdh 95% CI')
detach(cholesterol)
###################################################################
## 사후검정 : 다중비교

## TukeyHSD comparison
TukeyHSD(fit)
par(las=2) # 축 라벨 회전
par(mar=c(5,8,4,2)) # 왼쪽 마진을 넓힘
plot(TukeyHSD(fit))

# install.packages('multcomp')
library(multcomp)
par(mar=c(5,4,6,2))
tuk<-glht(fit, linfct=mcp(trt='Tukey'))
tuk
plot(cld(tuk,level=.05),col='lightgray')

#############################################
## 가정 평가하기

## 1. 정규성
install.packages('car')
library(car)
par(las=1) # 축 라벨 회전
par(mar=c(5,4,4,2))
qqPlot(lm(response ~ trt, data=cholesterol),  simulate=T, main='Q-Q Plot', labels=F)

## 2. 등분산성
# bartlett test
bartlett.test(response~trt, data=cholesterol)

# levene test
# install.packages('lawstat')
library(lawstat)
levene.test(cholesterol$response, cholesterol$trt, location='mean', correction.method='zero.correction')

# fligner.test()
# HH:hov()

### 이상치 검토
library(car); outlierTest(fit)

## 결론 : 정규성, 등분산성을 만족, 이상치가 없어 자료는 
##        분산분선 모델에 잘 적합하여 신뢰할 수 있음



#######################################################
# One-way ANCOVA

data(litter, package='multcomp')

attach(litter)
table(dose)

aggregate(weight, by=list(dose=dose), FUN=mean)
aggregate(weight, by=list(dose=dose), FUN=sd)

fit <- aov(weight~gesttime+dose)
summary(fit)

# 공변량 요인(gesttime)을 제거한 주요인(dose)의 처리 수준별 평균 계산
install.packages('effects')
library(effects)

effect('dose',fit)

# Multiple comparisons employing user-supplied contrasts
library(multcomp)
contrast <- rbind('no drug vs. drug'=c(3,-1,-1,-1))
summary(glht(fit, linfct=mcp(dose=contrast)))

# 모형에 대한 가정 평가 : 정규성, 등분산성, 독립성
library(multcomp)
fit2 <- aov(weight~gesttime*dose, data=litter)
summary(fit2)

install.packages('HH')
library(HH)
ancova(weight~gesttime+dose, data=litter)

detach(litter)

#######################################################
# Two-way ANCOVA

# y <- c(700, 820, 710, 830, 540, 680,... )
# fac1 <- gl(n=3,k=3,length=27,labels = c('StoreA','StoreB','StoreC')) 
# n:레벨수, k:n을 반복할 횟수
# fac2 <- gl(n=3,k=3,labels = c('loc1','loc2','loc3'))
# gl() : 

y1 <- c(1,4,1,2,2,3,2,3,2,4,4,3,3,2,3,4,2,3,4,3,4,4,3,3,2,4,4)
store <- gl(n=3,k=9, length=27, labels=c('StoreA','StoreB','StoreC'))
loc <- gl(n=3,k=3, length=27, labels=c('강남','홍대','종로'))
survey1 <- data.frame(store, loc, y1)

fit <- aov(y1~store+loc, data=survey1)
summary(fit)

y2 <- c(1,4,1,2,2,3,2,3,2,4,4,3,3,2,3,4,2,3,4,3,4,4,3,3,2,4,4)
store2 <- gl(n=3,k=3, length=27, labels=c('StoreA','StoreB','StoreC'))
loc2 <- gl(n=3,k=9, length=27, labels=c('강남','홍대','종로'))

survey2 <- data.frame(store2, loc2, y2)
fit2 <- aov(y2 ~ store2+loc2, data=survey2)
summary(fit2)

### 예.

View(ToothGrowth)
str(ToothGrowth)
attach(ToothGrowth)

dose <- factor(dose)
table(supp, dose)

aggregate(len, by=list(supp, dose), FUN=mean)

aggregate(len, by=list(supp, dose), FUN=sd)

fit <- aov(len ~ supp*dose)
summary(fit)

interaction.plot(dose, supp, len, type="b",
                 col=c("red","blue"), pch=c(16, 18),
                 main = "Interaction between Dose and Supplement Type")

library(gplots)
plotmeans(len ~ interaction(supp, dose, sep=" "),
          connect=list(c(1,3,5),c(2,4,6)),
          col=c("red", "darkgreen"),
          main = "Interaction Plot with 95% CIs",
          xlab="Treatment and Dose Combination")

library(HH)
interaction2wt(len~supp*dose)
detach(ToothGrowth)


##########################################
## MANOVA

View(UScereal)
library(MASS)
attach(UScereal)
shelf <- factor(shelf)
y <- cbind(calories, fat, sugars)
aggregate(y, by=list(shelf), FUN=mean)
cov(y)
cor(y)
fit <- manova(y ~ shelf)
summary(fit)
summary.aov(fit)
detach(UScereal)
center <- colMeans(y)
n <- nrow(y)
p <- ncol(y)
cov <- cov(y)
d <- mahalanobis(y,center,cov)
coord <- qqplot(qchisq(ppoints(n),df=p),
                d, main="Q-Q Plot Assessing Multivariate Normality",
                ylab="Mahalanobis D2")
abline(a=0,b=1)
identify(coord$x, coord$y, labels=row.names(UScereal))

############################################
## Repeated Measure ANOVA

View(CO2)
str(CO2)
CO2$conc <- factor(CO2$conc)
w1b1 <- subset(CO2, Treatment=='chilled')
attach(CO2)
fit <- aov(uptake ~ conc*Type + Error(Plant/(conc)), w1b1)
summary(fit)
detach(CO2)
par(las=2)
par(mar=c(10,4,4,2))
with(w1b1, interaction.plot(conc,Type,uptake,
                            type="b", col=c("red","blue"),
                            pch=c(16,18),
                            main="Interaction Plot for Plant Type and Concentration"))
boxplot(uptake ~ Type*conc, data=w1b1, col=(c("gold", "green")),
        main="Chilled Quebec and Mississippi Plants",
        ylab="Carbon dioxide uptake rate (umol/m^2 sec)")
detach(CO2)

