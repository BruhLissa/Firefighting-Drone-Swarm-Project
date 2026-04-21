function [drone, fire] = updateDrones(drone, fire, params, allDrones)
% UPDATEDRONES updates one drone for one step

% Assign target
drone = assignTarget(drone, fire, allDrones);

% If no fire exists, do nothing
if isempty(drone.target)
    return;
end

current = drone.position;
target = drone.target;

dx = sign(target(1) - current(1));
dy = sign(target(2) - current(2));

% Move one step toward target
proposed = current + [dx, dy];

% Keep inside grid
proposed(1) = max(1, min(params.grid_size(1), proposed(1)));
proposed(2) = max(1, min(params.grid_size(2), proposed(2)));

% Prevent drones from moving into same cell
for j = 1:length(allDrones)
    if allDrones(j).id ~= drone.id
        if isequal(proposed, allDrones(j).position)
            proposed = current;
            break;
        end
    end
end

% Update position
drone.position = proposed;

% Update logs
moveDist = abs(proposed(1) - current(1)) + abs(proposed(2) - current(2));
drone.distanceTraveled = drone.distanceTraveled + moveDist;
drone.timeActive = drone.timeActive + params.dt;
drone.path = [drone.path; proposed];

% Extinguish fire in current cell and neighbors
r = proposed(1);
c = proposed(2);

for rr = max(1, r-1):min(params.grid_size(1), r+1)
    for cc = max(1, c-1):min(params.grid_size(2), c+1)
        fire.intensity(rr, cc) = 0;
    end
end

drone.waterDrops = drone.waterDrops + 1;
end