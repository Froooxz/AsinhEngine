clear all; clc; close all;

N = 1000;

J = 0.5; % момент инерции
omega = ones(N,1); % угловая скорость
M = 10; % электромагнитный момент
M_sopr = 2; % электромагнитный момент сопротивления
dt = 0.01;

for i = 2:N
    omega(i) = omega(i-1) + dt*((M/omega(i-1) - M_sopr)/J);

end

plot(omega)