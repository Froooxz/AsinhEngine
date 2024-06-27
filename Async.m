clear all;
clc;
close all;

% Параметры модели
Ls = 0.4723; % индуктивность на статоре
Lm = 0.984; % индуктивность намагничивания двигателя
Rs = 0.1545; % сопротивление статора
Rr = 0.067; % Сопротивление ротора
KR = 0.1301; % коэффицент ротора
ZP = 1;
Lr = 0.5151;
Tr = Lr/Rr;
% Входные сигналы (примерные значения, заменить на реальные)
Usd = -220; % Напряжение на статоре по d-оси
Usq = -220; % Напряжение на статоре по q-оси
omega_e = 0; % Электрическая угловая скорость
omega_R = 0.01; % угловая скорость ротора
omega_R = 0.01; % угловая скорость ротора
% Временные параметры
T = 100; % Время моделирования
dt = 0.01; % Шаг интегрирования
N = T / dt; % Количество шагов

Isd(1) = 1; % Ток статора по d-оси
Isq(1) = 1; % Ток статора по q-оси
PsiR(1) = 1; % Поток ротора по q-оси
Mem(1) = 1;


for i = 1:N
    Isd(i+1) =  Isd(i) + dt*(1/(Ls-Lm*KR) * (Usd - Isd(i)*Rs  - KR*PsiR(i)) + omega_e*Isq(i));
    Isq(i+1) = Isq(i) + dt*(1/(Ls-Lm*KR) * (Usq -  Isq(i)*Rs - KR*omega_R*PsiR(i))- omega_e*Isd(i));
    PsiR(i+1) = PsiR(i) + dt*((1/Tr) * (Lm*Isd(i) - PsiR(i)));
    omega_e = ZP*omega_R + (Lm/(PsiR(i)*Tr))*Isq(i);
    Mem(i+1) = ((3*ZP*KR)/2)*PsiR(i)*Isq(i);
end

% Построение графиков
figure;
subplot(3,1,1);
plot(Isd);
title('Ток статора по d-оси');
xlabel('Время (с)');
ylabel('I_{sd} (A)');

subplot(3,1,2);
plot(Isq);
title('Ток статора по q-оси');
xlabel('Время (с)');
ylabel('I_{sq} (A)');

subplot(3,1,3);
plot(PsiR);
title('Поток ротора по q-оси');
xlabel('Время (с)');
ylabel('Ψ_{sq} (Wb)');

figure;
plot(Mem);
title('Электромагнитный момент');
xlabel('Время (с)');
ylabel('M (Nm)');
