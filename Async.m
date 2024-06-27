% Параметры модели
Ls = 0.2; % Индуктивность статора
Lm = 0.2; % Взаимная индуктивность
Rs = 0.01; % Сопротивление статора
Rr = 0.01; % Сопротивление ротора
Tr = 0.1; % Время роторной цепи
KRP = 1.5; % Константа для электромагнитного момента

% Начальные условия
Isd = 0; % Ток статора по d-оси
Isq = 0; % Ток статора по q-оси
PsiSq = 0; % Поток ротора по q-оси

% Входные сигналы (примерные значения, заменить на реальные)
Usd = 230; % Напряжение на статоре по d-оси
Usq = 230; % Напряжение на статоре по q-оси
omega_e = 50; % Электрическая угловая скорость
omega_R = 48; % Угловая скорость ротора

% Временные параметры
T = 10; % Время моделирования
dt = 0.001; % Шаг интегрирования
N = T / dt; % Количество шагов

% Массивы для хранения результатов
time = (0:dt:T-dt)';
Isd_array = zeros(N, 1);
Isq_array = zeros(N, 1);
PsiSq_array = zeros(N, 1);
M_array = zeros(N, 1);

% Численное интегрирование методом Эйлера
for k = 1:N
    % Текущее время
    t = (k-1) * dt;
    
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
    Isd_array(k) = Isd;
    Isq_array(k) = Isq;
    PsiSq_array(k) = PsiSq;
    M_array(k) = M;
end

% Построение графиков
figure;
subplot(3,1,1);
plot(time, Isd_array);
title('Ток статора по d-оси');
xlabel('Время (с)');
ylabel('I_{sd} (A)');

subplot(3,1,2);
plot(time, Isq_array);
title('Ток статора по q-оси');
xlabel('Время (с)');
ylabel('I_{sq} (A)');

subplot(3,1,3);
plot(time, PsiSq_array);
title('Поток ротора по q-оси');
xlabel('Время (с)');
ylabel('Ψ_{sq} (Wb)');

figure;
plot(time, M_array);
title('Электромагнитный момент');
xlabel('Время (с)');
ylabel('M (Nm)');
