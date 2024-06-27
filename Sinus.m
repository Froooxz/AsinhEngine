clc; clear all; close all;

T = 0.05; dt = 0.0001; N = T / dt; 

Um = 220; % Амплитуда напряжения
f = 50; % Частота (Гц)
omega = 2 * pi * f; % Угловая частота (рад/с)
phase1 = -2*pi/3;  phase2 = 0;  phase3 = 2*pi/3; % Начальная фаза (рад)

% Инициализация массивов
U1 = zeros(1, N+1); U2 = zeros(1, N+1); U3 = zeros(1, N+1);
t = zeros(1, N+1);

% Начальные условия
U1(1) = Um * sin(phase1); U2(1) = Um * sin(phase2); U3(1) = Um * sin(phase3);
t(1) = 0;

for i = 1:N
    t(i+1) = t(i) + dt;
    U1(i+1) = Um * sin(omega * t(i+1) + phase1);
    U2(i+1) = Um * sin(omega * t(i+1) + phase2);
    U3(i+1) = Um * sin(omega * t(i+1) + phase3);
end

plot(t, U1, t, U2, t, U3);
xlabel('Время (с)'); ylabel('Напряжение (В)');
grid on;