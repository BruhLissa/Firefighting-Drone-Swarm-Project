%parameters
params.gridSize = [30,30];
params.dt = 0.1;
params.numDrones = 3;
params.decayRate = 0.3;
params.time = 0;
params.maxTime = 180;
params.stop = 0;

time = params.time;
while time < params.maxtime && firestat > params.stop

time = time + params.dt;
end