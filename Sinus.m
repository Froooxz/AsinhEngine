clc; clear all; close all;

T = 0.05; h = 0.0001; N = T / h; 

Um = 220; % Амплитуда напряжения
f = 50; % Частота (Гц)
omega = 2 * pi * f; % Угловая частота (рад/с)
phase1 = -2*pi/3;  phase2 = 0;  phase3 = 2*pi/3; % Начальная фаза (рад)

% Инициализация массивов
u1 = zeros(1, N+1); u2 = zeros(1, N+1); u3 = zeros(1, N+1);
t = zeros(1, N+1);

% Начальные условия
u1(1) = Um * sin(phase1); u2(1) = Um * sin(phase2); u3(1) = Um * sin(phase3);
t(1) = 0;

for i = 1:N
    t(i+1) = t(i) + h;
    u1(i+1) = Um * sin(omega * t(i+1) + phase1);
    u2(i+1) = Um * sin(omega * t(i+1) + phase2);
    u3(i+1) = Um * sin(omega * t(i+1) + phase3);
end

plot(t, u1, t, u2, t, u3);
xlabel('Время (с)'); ylabel('Напряжение (В)');
grid on;