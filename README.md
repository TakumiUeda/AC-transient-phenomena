# 過渡現象って？
過渡現象とは定常状態から次の定常状態に移るその過程を指します。
ここで定常状態とは時間的に一定して変わらない状態のことを言います。
電気回路においては特徴的な過渡現象が発生し、簡単な回路であれば解析も容易なのでシミュレーションしてみました。

# 目的
今回の目的はシミュレーションを通して進み位相、遅れ位相の状態を可視化しその概念を理解することです。

# 対象とする回路と回路方程式
## 電源
電源には正弦波を用います。瞬時式は

```math
v(t)=V_{m} \sin(\omega t \pm \phi)
```

$V_{m}$は最大値で、実効値との関係は

```math
V= \frac{V_{m}}{\sqrt{2}}
```

角周波数$\omega$は

```math
\omega = 2 \pi f
```

今回使用する入力は

```math
v(t)= 100 \sqrt{2} \sin 60 \pi t
```

![untitled.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/138730/817d98a4-d5ad-ee96-17a1-c12f02bd9d07.jpeg)

※のちのグラフは青が電圧、赤が電流を示しています。


## Rのみの回路
抵抗のみの回路方程式は

```math
i(t)= \frac{V_{m}}{R} \sin (\omega t \pm \phi)
```

## RL直列回路
抵抗とコイルの回路方程式は

```math
L\frac{di(t)}{dt}+Ri(t)=V_{m}\sin\omega t
```
ラプラス変換すると

```math
sLI(s)-Li(0)+RI(s)=\frac{\omega V_{m}}{s^{2}+\omega^{2}}
```

より

```math
i(t)=\frac{V_{m}}{\sqrt{R^{2}+\left(\omega L\right)^2}}\left\{e^{-\frac{R}{L}t}\sin\phi+\sin\left(\omega t-\phi\right)\right\}
```

ただし

$$\phi= \tan^{-1}\frac{\omega L}{R}$$


## RC直列回路
抵抗とコンデンサの回路方程式は
$$ Ri(t)+\frac{1}{C}\int{i(t) dt}=V_{m} \sin \omega t $$

同様にラプラス変換して

```math
RI(s)+\frac{I(s)}{sC}+\frac{1}{sC} \int{i(t) dt}=\frac{\omega V_m}{s^2+\omega^2}
```

より

```math
i(t)=\frac{\omega CV_m}{\sqrt{1+\left(\omega CR\right)^2}}\left\{\cos\left(\omega t-\phi\right)-e^{-\frac{t}{CR}}\cos\phi\right\}
```

ただし

$$\phi= \tan^{-1} \omega CR $$

#結果
## Rのみの回路
同相（グラフが重なっている）

![untitled.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/138730/e0ae53d3-e319-8a1f-d099-3632ff3d969b.jpeg)

## RL直列回路
遅れ位相


![untitled.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/138730/a4ae8699-6976-1f8f-ef78-d49e4f538558.jpeg)

## RC直列回路
進み位相

![untitled.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/138730/eb256d00-034b-bb0f-9024-18c28da9b10e.jpeg)

# ソース全体

```matlab
clear 
close all

%%
e=exp(1);

%% source
t=0:0.0001:0.1;
f=60;
V=100;

v=sqrt(2)*V*sin(2*pi*f*t);

figure
plot(t,v);
xlabel('Time[s]');
ylabel('Voltage[V]');
%% resister
R=30;
ir=v/R;

figure
yyaxis right
plot(t,ir);
ylabel('Current[A]');
hold on
yyaxis left
plot(t,v);
xlabel('Time[s]');
ylabel('Voltage[V]');
hold on
%% inductor
R2=30;
L=10*10^3;
omegaL=2*pi*f*L;
phi=atan(omegaL/R);

il=(sqrt(2)*V)/(sqrt(R2^2+omegaL^2))*(e^(-R/L)*sin(phi)+sin(2*pi*f*t-phi));

figure
yyaxis right
plot(t,il);
ylabel('Current[A]');
hold on
yyaxis left
xlabel('Time[s]');
ylabel('Voltage[V]');
plot(t,v);

%% capacitor
R2=10;
C=0.1*10^-6;

omegaC=2*pi*f*C;
phi=atan(omegaC*R2);

ic=(omegaC*sqrt(2)*V)/(sqrt(1+(omegaC*R2)^2)).*(cos(2*pi*f.*t-phi)-e.^(-t/(C*R2)).*cos(phi));

figure
yyaxis right
plot(t,ic);
ylabel('Current[A]');
hold on
yyaxis left
xlabel('Time[s]');
ylabel('Voltage[V]');
plot(t,v);
```

# github
https://github.com/rein-chihaya/AC-transient-phenomena
