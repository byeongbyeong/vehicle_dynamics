%% given value
m = 1800;
roll_coeff = 0.02;
drag_coeff = 0.4;
air_density = 1.202;
area = 2;
force =  -2000;
gravity = 9.806;

%% initialization
sampling_force = 0.01;
vel = 50 * 1000 / 3600;
dist = inf;

%% find force to make stopping distance lower than 20m
while (dist > 20)
    dist = get_stopping_distance(force, vel, m, roll_coeff, drag_coeff, air_density, area);
    force = force - sampling_force;
end

friction_coeff = abs(force)/(m * gravity);
fprintf('Deceleration problem 2\n');
fprintf('required minimum braking force: %g [N]\n', abs(force));
fprintf('required minimum friction coefficient: %g\n', friction_coeff);


function dist = get_stopping_distance(force, vel, m, roll_coeff, drag_coeff, air_density, area)


    gravity = 9.806;
    dist = 0;
    roll = roll_coeff * m * gravity;
    sampling_time = 0.01;

    while (1)
        air_drag = air_density * area * drag_coeff * vel^2/2;
        net_force = force - roll - air_drag;
        acc = net_force/m;
        dist = dist + vel * sampling_time;
        vel = vel + acc * sampling_time;
        if vel < 0
            break;
        end
    end
end