function [drone, fire] = updateDrones(drone, fire, params, allDrones)
% updateDrones updates a single drone for one time step

% Assign target
drone = assignTarget(drone, fire, allDrones);

if isempty(drone.target)
    drone.events{end+1} = sprintf('Time %.1f: no fire target available', drone.timeActive);
    return;
end

current = drone.position;
target = drone.target;

dx = sign(target(1) - current(1));
dy = sign(target(2) - current(2));

proposed = current + [dx, dy];

% Keep inside grid using Clamp
proposed(1) = Clamp(proposed(1), 1, params.grid_size(1));
proposed(2) = Clamp(proposed(2), 1, params.grid_size(2));

% Collision check
collisionHappened = false;
for j = 1:length(allDrones)
    if allDrones(j).id ~= drone.id
        if isequal(proposed, allDrones(j).position)
            drone.nearMissCount = drone.nearMissCount + 1;
            proposed = current;
            collisionHappened = true;
            break;
        end
    end
end

drone.position = proposed;

moveDist = abs(proposed(1) - current(1)) + abs(proposed(2) - current(2));
drone.distanceTraveled = drone.distanceTraveled + moveDist;
drone.timeActive = drone.timeActive + params.dt;
drone.path = [drone.path; proposed];

% Extinguish nearby fire
r = proposed(1);
c = proposed(2);

cellsPutOut = 0;

for rr = max(1, r-1):min(params.grid_size(1), r+1)
    for cc = max(1, c-1):min(params.grid_size(2), c+1)
        if fire.intensity(rr, cc) > 0
            fire.intensity(rr, cc) = 0;
            cellsPutOut = cellsPutOut + 1;
        end
    end
end

drone.waterDrops = drone.waterDrops + 1;
drone.cellsExtinguished = drone.cellsExtinguished + cellsPutOut;

% Log event
if collisionHappened
    drone.events{end+1} = sprintf('Time %.1f: near miss, stayed at (%d,%d)', ...
        drone.timeActive, proposed(1), proposed(2));
elseif cellsPutOut > 0
    drone.events{end+1} = sprintf('Time %.1f: moved to (%d,%d), extinguished %d cells', ...
        drone.timeActive, proposed(1), proposed(2), cellsPutOut);
else
    drone.events{end+1} = sprintf('Time %.1f: moved to (%d,%d), no fire extinguished', ...
        drone.timeActive, proposed(1), proposed(2));
end
end