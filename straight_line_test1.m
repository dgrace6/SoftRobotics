clc; clear all; close all;
T=2;
dt=.2;
t=.2;
t=0:dt:T;
n=length(t);
x=0*ones(size(t));
y=0*ones(size(t));
z=linspace(10,25,n);
for i=1:n
    SoftDeltaTest2([x(i), y(i), z(i)]);
    hold on
end
