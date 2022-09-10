function out=elipse(in)
syms teta1 teta2 TT
teta=[teta1;teta2];
alpha1=in(1);
alpha2=in(2);
L=[1,1];
R=[L(1)/teta1,L(2)/teta2];
R=eval(subs(R,{teta1,teta2},[alpha1,alpha2]));
TT=eye(3);
hold on
for i=1:2
    T(i,:,:)=[cos(teta(i)) -sin(teta(i)) R(i)*sin(teta(i))
    sin(teta(i)) cos(teta(i)) R(i)*(1-cos(teta(i)))
    0 0 1];
    TT=TT*squeeze(T(i,:,:));
    Trans{i}=TT;
    X(i,:)=Trans{i}*[0;0;1];
end
beta1=linspace(.001,alpha1,15);
beta2=linspace(.001,alpha2,15);
for i=1:15
    X1(i,:)=eval(subs(X(1,:),{teta1,teta2},[beta1(i),beta2(end)]));
    X2(i,:)=eval(subs(X(2,:),{teta1,teta2},[beta1(end),beta2(i)]));
end
hold on
plot(X1(:,1),X1(:,2),'r')
plot(X2(:,1),X2(:,2),'b')
plot(X2(end,1),X2(end,2),'*')
axis equal


alpha1=linspace(.1,pi/3,10);
alpha2=linspace(.1,pi/6,10);
k=1;
for i=1:length(alpha1)
    for j=1:length(alpha1)
        data1(k,:)=[[X2(end,1),X2(end,2)],alpha1(i)];
        data2(k,:)=[[X2(end,1),X2(end,2)],alpha2(j)];
        k=k+1;
    end
end
T=3;
dt=.5;
t=0:dt:T;
x=.2*cos(2*pi*t/T)+1;
y=.2*sin(2*pi*t/T)+1.2;
figure(3)
plot(x,y,'k')
end


