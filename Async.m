clear all;
clc;
close all;

% Параметры модели
Ls = 0.4723; % индуктивность на статоре
Lm = 0.086; % индуктивность намагничивания двигателя
Rs = 0.258; % сопротивление статора
Rr = 0.145; % Сопротивление ротора
ZP = 1;
Lr = 0.5151;
KR = Lm/Lr; % коэффицент ротора
Tr = Lr/Rr;
% Входные сигналы (примерные значения, заменить на реальные)
Usd = 220; % Напряжение на статоре по d-оси
Usq = 220; % Напряжение на статоре по q-оси
% Временные параметры
T = 20; % Время моделирования
dt = 0.01; % Шаг интегрирования
N = T / dt; % Количество шагов


Isd(1) = 0; % Ток статора по d-оси
Isq(1) = 0; % Ток статора по q-оси
PsiR(1) = 1; % Поток ротора по q-оси
omega_e(1) = 0; % Электрическая угловая скорость
Mem(1) = 0;

omega_R(1) = 0; % угловая скорость ротора

Usd = 0.9;
Usq = 0.9;
J=0.1; % Момент инерции

kc = 0.001; % Коэффициент момента сопротивления
for i = 1:N
    omega_R(i+1) = omega_R(i)+dt*((Mem(i) - kc*omega_R(i))/J);   
    Isd(i+1) =  Isd(i) + dt*(1/(Ls-Lm*KR) * (Usd - Isd(i)*Rs  - KR*(((1/Tr) * (Lm*Isd(i) - PsiR(i))))) + omega_e(i)*Isq(i));
    Isq(i+1) = Isq(i) + dt*(1/(Ls-Lm*KR) * (Usq -  Isq(i)*Rs - KR*omega_e(i)*PsiR(i))- omega_e(i)*Isd(i));
    PsiR(i+1) = PsiR(i) + dt*((1/Tr) * (Lm*Isd(i) - PsiR(i)));
    omega_e(i+1) = ZP*omega_R(i) + (Lm/(PsiR(i)*Tr))*Isq(i);
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
plot(omega_e);
title('omega_e');

