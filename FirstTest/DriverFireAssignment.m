clear, clc, close all;
params = make_params;

%parameters
% params.gridSize = [30,30];
% params.dt = 0.1;
% params.numDrones = 3;
% params.decayRate = 0.3;
% params.time = 0;
% params.maxTime = 180;
% params.stop = 0;

fire = FireInit(params);
drones = initializeDrones(params);

time = params.time;

while time < params.maxtime && firestat > params.stop
    fire = fire_step(fire, params);
    
    for ii = 1:length(drones)
    [drones(ii), fire] = update_drone(drones(ii), fire, params, drones);
    end
   
    time = time + params.dt;
end