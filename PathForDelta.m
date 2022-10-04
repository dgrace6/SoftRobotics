clear all; close all; clc
t=0:.1:2;


% ctrl+shift+r to uncomment
% ctrl+r to comment
% x=17*sin(2*pi*t);
% y=17*cos(2*pi*t);
% z=24*ones(size(t));


% ctrl+r to uncomment
% ctrl+r to comment
T=2;
dt=.2;
t=.2;
t=0:dt:T;
n=length(t);
x=0*ones(size(t));
y=0*ones(size(t));
z=linspace(10,25,n);


for i=1:length(t)
    beta(:,i)=SoftDelta([x(i), y(i), z(i)]);
end
figure(1)
hold on
plot3(x,y,z,'*r')
figure(2)
hold on
plot(t,beta(1,:),t,beta(2,:),t,beta(3,:))
axis equal