clc; clear all; close all;

T = 10; % Время моделирования
dt = 0.001; % Шаг интегрирования
N = T / dt; % Количество шагов

Ls = 0.2; % Индуктивность статора
Lm = 0.2; % Взаимная индуктивность
Rs = 0.01; % Сопротивление статора
Rr = 0.01; % Сопротивление ротора
Tr = 0.1; % Время роторной цепи
KRP = 1.5; % Константа для электромагнитного момента

% Входные сигналы
Usd = 220; % Напряжение на статоре по d-оси
Usq = 220; % Напряжение на статоре по q-оси
omega_e = 50; % Электрическая угловая скорость
omega_R = 48; % Угловая скорость ротора

% Начальные условия
Isd = 0; % Ток статора по d-оси
Isq = 0; % Ток статора по q-оси
PsiSq = 0; % Поток ротора по q-оси

% Массивы для хранения результатов
time = (0:dt:T-dt)';
Isd_array = zeros(N, 1);
Isq_array = zeros(N, 1);
PsiSq_array = zeros(N, 1);
M_array = zeros(N, 1);

for i = 1:N
    % Текущее время
    t = (i-1) * dt;
    
    % Расчет производных
    dIsd = (1/Ls) * (Usd - Rs * Isd + omega_e * Ls * Isq);
    dIsq = (1/Ls) * (Usq - Rs * Isq - (omega_e - omega_R) * Lm * Isd);
    PsiR = Lm * Isd; % Поток ротора по d-оси
    dPsiSq = - (omega_e - omega_R) * PsiR + (1/Tr) * (Isq - (Rr/Lm) * PsiSq);
    
    % Обновление переменных методом Эйлера
    Isd = Isd + dIsd * dt;
    Isq = Isq + dIsq * dt;
    PsiSq = PsiSq + dPsiSq * dt;
    
    % Вычисление электромагнитного момента
    M = (3/2) * KRP * PsiSq * Isd;
    
    % Сохранение результатов
    Isd_array(i) = Isd;
    Isq_array(i) = Isq;
    PsiSq_array(i) = PsiSq;
    M_array(i) = M;
end

figure;
hold on
plot(time, Isd_array);
title('Ток статора по d-оси');
xlabel('Время (с)');
ylabel('I_{sd} (A)');

plot(time, Isq_array);
title('Ток статора по q-оси');
xlabel('Время (с)');
ylabel('I_{sq} (A)');

plot(time, PsiSq_array);
title('Поток ротора по q-оси');
xlabel('Время (с)');
ylabel('Ψ_{sq} (Wb)');
hold off

figure;
plot(time, M_array);
title('Электромагнитный момент');
xlabel('Время (с)');
ylabel('M (Nm)');
