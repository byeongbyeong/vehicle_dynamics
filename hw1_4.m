%% given value
m = 1800;
roll_coeff = 0.02;
drag_coeff = 0.4;
air_density = 1.202;
area = 2;
force =  4000;
gravity = 9.806;
max_power = 100e3;
tangent = 0.04;

%% Simulation time
ti = 0;
tf = 200;
sampling_time = 0.01;

%% initialization
t = ti:sampling_time:tf;
n = length(t);
vel_i = 0;
vel = zeros(n,1);
power = zeros(n,1);
power_net = zeros(n,1);
sin_theta = sin(atan(tangent));

%% simulation
roll = roll_coeff * m * gravity;
incline = m * gravity * sin_theta;
for i = 2:n
    if power(i-1) > max_power
        force = max_power/vel_i;
    end
    air_drag = air_density * area * drag_coeff * vel_i^2 / 2;
    net_force = force - roll - air_drag - incline;
    acc = net_force/m;
    vel_i = vel_i + acc * sampling_time;

    power(i) = force * vel_i;
    power_net(i) = net_force * vel_i;
    vel(i) = vel_i;
end
vel = vel * 3600/ 1000;

figure(1);
subplot(121);
title('Acceleration problem 2'); grid on;
plot(t, vel);
xlabel('time[s]'); ylabel('velocity[km/h]');
subplot(122);
hold on;
plot(t, power);
plot(t, power_net);
xlabel('time[s]'); ylabel('power[W]');
hold off;