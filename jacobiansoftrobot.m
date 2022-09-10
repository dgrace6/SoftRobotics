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
    X(:,i)=Trans{i}*[0;0;1];
end
XX=X(1:2,2);
J=jacobian(XX, [teta1,teta2]);
T=1;
dt=.05;
t=.2:dt:T;
x=t;
y=ones(size(x));
Xd=[x',y'];
Qd=[1;1];
for i=1:length(t)
    E=1;
    while E>1e-5
        Qd=(eval(subs(J,{teta1,teta2},Qd'))^-1)*(Xd(i,:)'-eval(subs(XX, {teta1,teta2},Qd')))+Qd;
        X1=eval(subs(XX,{teta1,teta2},Qd'));
        E=norm(abs(Xd(i,:)'-X1));
    end
    Q(i,:)=Qd;
end
figure(2)
plot(t,180*Q(:,1)/pi,t,180*Q(:,2)/pi)
figure(1)
for i=1:length(Q)
    horizontalLine([Q(i,1),Q(i,2)])   
end

T=6;
dt=.5;
t=0:dt:T;
x=.2*cos(2*pi*t/T)+1;
y=.2*sin(2*pi*t/T)+1.2;
Xd=[x',y'];
Qd=[1;1];
for i=1:length(t)
    E=1;
    while E>1e-5
        Qd=(eval(subs(J,{teta1,teta2},Qd'))^-1)*(Xd(i,:)'-eval(subs(XX, {teta1,teta2},Qd')))+Qd;
        X1=eval(subs(XX,{teta1,teta2},Qd'));
        E=norm(abs(Xd(i,:)'-X1));
    end
    Q(i,:)=Qd;
  
end
for i=1:length(Q)
    ellipse([Q(i,1),Q(i,2)])   
end
