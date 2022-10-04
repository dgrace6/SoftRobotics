function out=SoftDeltaTest1(in)
syms teta1 teta2 teta3
p = in';
teta = [teta1; teta2; teta3];
sb = 60;
wb = sb*3^.5/6;
ub=sb*3.5/3;
Lb=20;
Lp=30;
B(:,1)=[0;-wb;0];
B(:,2)=[wb*3^.5/2;wb/2;0];
B(:,3)=[-wb*3^.5/2;wb/2;0];
b(:,1)=[sb/2;-wb;0];
b(:,2)=[0;ub;0];
b(:,3)=[-sb/2;-wb;0];

r(1)=Lb/teta1;
r(2)=Lb/teta2;
r(3)=Lb/teta3;

L(:,1)=r(1)*[0;-(1-cos(teta(1))); sin(teta(1))];
L(:,2)=r(2)*[(1-cos(teta(2)))*3^.5/2;(1-cos(teta(2)))/2; sin(teta(2))];
L(:,3)=r(3)*[-(1-cos(teta(3)))*3^.5/2;(1-cos(teta(3)))/2; sin(teta(3))];

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
fun1=@(teta1)eval(ff(1));
beta(1)=fzero(fun1,x0);
fun2=@(teta2)eval(ff(2));
beta(2)=fzero(fun2,x0);
fun3=@(teta3)eval(ff(3));
beta(3)=fzero(fun3,x0);
for i=1:3
    if beta(i) == 0
        beta(i) = .0001;
    end
end
figure(1)
hold on

viscircles([0 0],wb,'Color','r');
plot3(B(1,1:3),PP(2,1:3),PP(3,1:3),'*r')
plot3(PP(1,1:3),PP(2,1:3), PP(3,1:3),'*b-')
plot3(PP(1,[3,1]),PP(2,[3,1]),PP(3,[3,1]),'*b-')
for i=1:3
    R(i)=subs(r(i),teta(i),beta(i));
    LL(:,i)=subs(L(:,i),teta(i),beta(i))+B(:,i);
    plot3([LL(1,i),PP(1,i)],[LL(2,i)],[LL(3,i),PP(3,i)],'*k-')
    l(i)=eval(((PP(:,i)-LL(:,i))'*(PP(:,i)-LL(:,i)))^.5);
end
L(:,1)=r(1)*[0;-(1-cos(teta(1))); sin(teta(1))];
L(:,2)=r(2)*[(1-cos(teta(2)))*3^.5/2;(1-cos(teta(2)))/2; sin(teta(2))];
L(:,3)=r(3)*[-(1-cos(teta(3)))*3^.5/2;(1-cos(teta(3)))/2; sin(teta(3))];
for i=1:3
    gama(:,i)=linspace(0,beta(i),10);
    for j=1:10
        LL(:,j,i)=subs(L(:,i),teta(i),gama(j,i))+B(:,i);
    end
    plot3([LL(1,:,i)],[LL(2,:,i)],[LL(3,:,i)],'g-')
end
axis equal grid on
out=beta*180/pi;
end



