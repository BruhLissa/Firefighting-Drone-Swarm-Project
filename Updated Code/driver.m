clear;
clc;
close all;

params = make_params();
fire = FireInit(params);
drones = initializeDrones(params);

for step = 1:params.max_steps

    % Fire spreads first
    fire = fire_step(fire, params);

    % Then drones respond
    for i = 1:length(drones)
        [drones(i), fire] = updateDrones(drones(i), fire, params, drones);
    end

    figure(1);
    clf;
    plot_state(fire, drones, step);

    pause(params.plot_pause);

    if all(fire.intensity(:) < params.fire_stop_threshold)
        fprintf('Simulation stopped at step %d because the fire was extinguished.\n', step);
        break;
    end
end