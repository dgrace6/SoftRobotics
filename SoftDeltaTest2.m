function out = SoftDeltaTest2(in)
x_in=in;
syms teta1 teta2 teta3 x1 x2 x3

X=[x1;x2;x3];
p=X;
teta=[teta1;teta2;teta3];
sb=30;
wb = sb*3^.5/6;
ub=sb*3.5/3;
Lb=20; %Different
Lp=30;
B(:,1)=[0;-wb;0];
B(:,2)=[wb*3^.5/2;wb/2;0];
B(:,3)=[-wb*3^.5/2;wb/2;0];
b(:,1)=[sb/2;-wb;0];
b(:,2)=[0;ub;0];
b(:,3)=[-sb/2;-wb;0];

L(:,1)=Lb*[0;-cos(teta(1)); sin(teta(1))];
L(:,2)=Lb*[cos(teta(2))*3^.5/2;cos(teta(2))/2; sin(teta(2))];
L(:,3)=Lb*[-cos(teta(3))*3^.5/2;cos(teta(3))/2; sin(teta(3))];

sp=10; 
wp=sp*3^.5/6;
up=sp*3^.5/3;
P(:,1)=[0;-up;0];
P(:,2)=[sp/2;wp;0];
P(:,3)=[-sp/2;wp;0];
x0=1;

for i=1:3
    PP(:,i)=p+P(:,i);
    f(:,i)=PP(:,i)-B(:,i)-L(:,i);
    ff(i)=f(:,i)'*f(:,i)-Lb^2;
end

teta0=[1,1,1];
eqn=eval(subs(ff,[x1,x2,x3],x_in))==0;
a=vpasolve(eqn,teta,teta0);
out=[a.teta1, a.teta2, a.teta3];
PP=eval(subs(PP,[x1,x2,x3],x_in));
figure(1)
hold on
plot3(b(1,1:3),b(2,1:3),b(3,1:3),'r-')
plot3(b(1,[3,1]),b(2,[3,1]),b(3,[3,1]),'r-')
plot3(B(1,1:3),B(2,1:3),B(3,1:3),'*r')
plot3(PP(1,1:3),PP(2,1:3),PP(3,1:3),'*b-')
plot3(PP(1,[3,1]),PP(2,[3,1]),PP(3,[3,1]),'*b-')

for i=1:3
    LL(:,i)=subs(L(:,i),teta(i),out(i))+B(:,i);
    plot3([B(1,i),LL(1,i)],[B(2,i),LL(2,i)],[B(3,i),LL(3,i)],'*g-');
    plot3([LL(1,i),PP(1,i)],[LL(2,i),PP(2,i)],[LL(3,i),PP(3,i)],'*k-');
    l(i)=eval(((PP( :,i)-LL(:,i))'*(PP(:,i)-LL(:,i)))^.5);
end
axis equal

grid on
figure(2)
bar(1,.5)

axis([0 4 0 20]);
grid on
end


