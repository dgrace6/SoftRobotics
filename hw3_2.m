clc;clear all;close all;
syms teta1 teta2 TT
teta=[teta1;teta2];
L=[1,1];
R=[L(1)/teta1,L(2)/teta2];
TT=eye(3);
for i=1:2
    T(i,:,:)=[cos(teta(i)) -sin(teta(i)) R(i)*sin(teta(i))
    sin(teta(i)) cos(teta(i)) R(i)*(1-cos(teta(i)))
    0 0 1];
    TT=TT*squeeze(T(i,:,:));
    Trans{i}=TT;
    X(:,i)=simplify(TT*[0;0;1]);
end
k=1;
alpha=.001:.1:pi/3;
beta=.001:.1:pi/6;
for j=1:length(alpha)
    for i=1:length(beta)
        XX=eval(subs(X,{teta1,teta2},[alpha(j),beta(i)]));
        hold on
        plot(XX(1,end),XX(2,end),"*")
        axis equal
        data1(k,:) = [XX(1,end) XX(2,end) alpha(j)]; % create x-y-theta1 dataset
        data2(k,:) = [XX(1,end) XX(2,end) beta(i)]; % create x-y-theta2 dataset
        k=k+1;
    end
end

opt=anfisOptions;
opt.InitialFIS=7;
opt.EpochNumber=150;
opt.DisplayANFISInformation=0;
opt.DisplayErrorValues;
opt.DisplayStepSize=0;
opt.DisplayFinalResults=0;

anfis1=anfis(data1,opt);
anfis2=anfis(data2,opt);

T=6;
dt=.5;
t=0:dt:T;
x=.2*cos(2*pi*t/T)+1;
y=.2*sin(2*pi*t/T)+1.2;
figure(3)
plot(x,y,'k')

XY = [x',y'];


THETA1P = evalfis(anfis1, XY);
THETA2P = evalfis(anfis2, XY);

figure(2)

plot(t,180*THETA1P/pi,t,180*THETA2P/pi)
figure(3)

for i = 1:length(t)
    xx=eval(subs(X,{teta1,teta2},[THETA1P(i),THETA2P(i)]));
    hold on
    plot([0,xx(1,:)],[0,xx(2,:)],"-*")
    axis equal
end
plot(x,y)

%{
X = X2;
k = 1;

alpha = beta1;
beta = beta2;
figure(2)
for j=1:length(alpha)
for i=1:length(beta)
XX=eval(subs(X,{teta1,teta2},[alpha(j),beta(i)]));
hold on
plot(XX(1,end),XX(2,end),"*")
axis equal
data1(k,:) = [XX(1,end) XX(2,end) alpha(j)]; % create x-y-theta1 dataset
data2(k,:) = [XX(1,end) XX(2,end) beta(i)]; % create x-y-theta2 dataset
k=k+1;
end
end


% line([0 L],[0 0] 

%}