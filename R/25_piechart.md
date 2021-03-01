# piechart

```R
feq<-table(diamonds$cut)
lbl <- paste(names(feq),feq, sep='\n') # paste : 복사
pie(feq, clockwise=T, radius=0.7, labels=lbl) 
# clockwise : 시작 위치
# labels : 해당 요소의 값을 나타내줌
```

<img src="C:%5CUsers%5Ckimih%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5Cimage-20210301235805248.png" alt="image-20210301235805248" style="zoom:33%;" />

- piechart를 3D로 출력

```R
# plotrix 패키지 설치
install.packages('plotrix') 
library(plotrix)

pie3D(feq, labels=lbl, explode = 0.05)
```

<img src="C:%5CUsers%5Ckimih%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5Cimage-20210302000040460.png" alt="image-20210302000040460" style="zoom:33%;" />

- 부채꼴 모양 piechart

```R
fan.plot(feq, labels=lbl)
```

<img src="C:%5CUsers%5Ckimih%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5Cimage-20210302000053734.png" alt="image-20210302000053734" style="zoom:33%;" />

