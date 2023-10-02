%% given value
m = 1800;
roll_coeff = 0.02;
drag_coeff = 0.4;
air_density = 1.202;
area = 2;
force =  -2000;
gravity = 9.806;

%% Simulation time
ti = 0;
tf = 15;
sampling_time = 0.01;

%% initialization
t = ti:sampling_time:tf;
n = length(t);
vel_i = 50 * 1000 / 3600;
dist_i = 0;
vel = zeros(n,1);
vel(1) = vel_i;
dist = zeros(n,1);

%% simulation
roll = roll_coeff * m * gravity;
for i = 2:n
    air_drag = air_density * area * drag_coeff * vel_i^2 / 2;
    net_force = force - roll - air_drag;
    acc = net_force / m;
    vel_i = vel_i + acc * sampling_time;
    dist_i = vel_i * sampling_time;
    if vel_i < 0
        vel(i:end) = 0;
        dist(i:end) = dist(i-1);
        break;
    end
    vel(i) = vel_i;
    dist(i) = dist(i-1) + dist_i;
end
vel = vel * 3600/1000;

figure(1);
title('Acceleration Problem 2'); grid on;
subplot(121);
plot(t, vel);
xlabel('time[s]'); ylabel('velocity[km/h]');
subplot(122);
plot(t, dist);
xlabel('time[s]'); ylabel('stopping distance [m]');