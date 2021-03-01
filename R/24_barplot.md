# barplot

```R
barplot(table(diamonds$cut), horiz = T)
```

<img src="C:%5CUsers%5Ckimih%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5Cimage-20210301232928198.png" alt="image-20210301232928198" style="zoom:33%;" />

- col : 색상
- legend : 오른쪽 상단에 범례
- beside : T로 지정하면 각각 값마다 막대를 그림

```R
cnt <- table(diamonds$cut, diamonds$color)
barplot(cnt, col=rainbow(5),
        legend=T, beside = T) 
```

<img src="C:%5CUsers%5Ckimih%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5Cimage-20210301233201832.png" alt="image-20210301233201832" style="zoom:33%;" />



- par(mfrow|mfcol=c(x축방향 분할 수, y축 방향 분할 수)) : 한 화면에 여러 그래프를 넣고 싶을 때 사용하는 함수

```R
par(mfrow=c(1,2)) # 1행 2열로 그래프 보여주기
barplot(table(diamonds$cut), horiz = T)
barplot(cnt, col=rainbow(5),
        legend=T, beside = T) 	
```

<img src="C:%5CUsers%5Ckimih%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5Cimage-20210301234010743.png" alt="image-20210301234010743" style="zoom:33%;" />