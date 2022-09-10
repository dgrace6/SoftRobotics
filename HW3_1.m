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
end
beta1=0:.1:pi/2;
beta2=0:.1:pi;
r1=L(1)/beta1(end);
r2=L(2)/beta2(end);
x1=r1*sin(beta1);
y1=r1*(ones(size(beta1))-cos(beta1));
x2=r2*sin(beta2);
y2=r2*(ones(size(beta2))-cos(beta2));
for i=1:length(beta1)
X2(i,:)=eval(subs(Trans{1,1},{teta1},beta1(end)))*[x2(i);y2(i);1];
% X2=eval(subs(Trans{1,2},{teta1,teta2},[beta1(end),beta2(end)]))*[x2(i);y2(i);1];
end
hold on
plot(X2(:,1),X2(:,2))
plot(x1,y1)

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