function [drone, fire] = updateDrones(drone, fire, params, allDrones)
% updateDrone updates a single drone for one time step
%
% Inputs:
%   drone      - current drone
%   fire       - fire struct
%   params     - simulation parameters
%   allDrones  - all drones (for collision checking)
%
% Outputs:
%   drone - updated drone
%   fire  - updated fire

% Assign target
drone = assignTarget(drone, fire, allDrones);

if isempty(drone.target)
    return;
end

current = drone.position;
target = drone.target;

dx = sign(target(1) - current(1));
dy = sign(target(2) - current(2));

proposed = current + [dx, dy];

% keep inside grid using Clamp
proposed(1) = Clamp(proposed(1), 1, params.grid_size(1));
proposed(2) = Clamp(proposed(2), 1, params.grid_size(2));

% avoid collisions
for j = 1:length(allDrones)
    if allDrones(j).id ~= drone.id
        if isequal(proposed, allDrones(j).position)
            proposed = current;
            break;
        end
    end
end

drone.position = proposed;

moveDist = abs(proposed(1) - current(1)) + abs(proposed(2) - current(2));
drone.distanceTraveled = drone.distanceTraveled + moveDist;
drone.timeActive = drone.timeActive + params.dt;
drone.path = [drone.path; proposed];

% extinguish a 3x3 area
r = proposed(1);
c = proposed(2);

r1 = Clamp(r-1, 1, params.grid_size(1));
r2 = Clamp(r+1, 1, params.grid_size(1));
c1 = Clamp(c-1, 1, params.grid_size(2));
c2 = Clamp(c+1, 1, params.grid_size(2));

for rr = r1:r2
    for cc = c1:c2
        fire.intensity(rr, cc) = 0;
        fire.justSpawned(rr, cc) = 0;
    end
end

drone.waterDrops = drone.waterDrops + 1;
end