clear all; close all; clc
t=0:.1:2;

x=17*sin(2*pi*t);
y=17*cos(2*pi*t);
z=24*ones(size(t));

x=zeros(size(t));
y=zeros(size(t));
z=linspace(15,30,length(t));

for i=1:length(t)
    beta(:,i)=SoftDeltaTest1([x(i), y(i), z(i)]);
end
figure(1)
hold on
plot3(x,y,z,'*r')
figure(2)
hold on
plot(t,beta(1,:),t,beta(2,:),t,beta(3,:))
