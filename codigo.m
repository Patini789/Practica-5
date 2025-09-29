a1 = 5000;
a0 = 100e6;
b0 = 250e6;

% PWM
amplitud = 5;
periodo = 0.00625;
ciclo = 50; 

t_final = 0.05;
t_in = 0:(t_final/5000):t_final;

tiempo_encendido = periodo * (ciclo / 100);

onda_logica = (mod(t_in, periodo) < tiempo_encendido);

Vin_in = amplitud * onda_logica;

entrada_func = @(t) interp1(t_in, Vin_in, t, 'previous');

ode_system = @(t, x) [x(2); -a0*x(1) - a1*x(2) + b0*entrada_func(t)];

[t_out, x_out] = ode45(ode_system, [0, t_final], [0; 0]);

Vo_out = x_out(:, 1);

figure;
hold on;
plot(t_in, Vin_in, '--', 'DisplayName', 'Entrada (Vin)', 'LineWidth', 1.5);
plot(t_out, Vo_out, '-', 'DisplayName', 'Salida (Vo)', 'LineWidth', 2);
hold off;
title('Respuesta del Sistema (calculada con ode45)');
xlabel('Tiempo (segundos)');
ylabel('Amplitud (Voltios)');
legend;
grid on;
axis([0 t_final -0.5 7.5]);