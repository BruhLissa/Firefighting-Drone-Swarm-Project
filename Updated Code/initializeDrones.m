function drones = initializeDrones(params)
% initializeDrones initializes all drone agents
% Inputs:
%   params.numDrones  - number of drones
%   params.gridSize   - size of grid (NxN)
% Output:
%   drones - struct array of drone agents

numDrones = params.n_drones;
rows = params.grid_size(1);
cols = params.grid_size(2);

drones(numDrones) = struct();
usedPositions = [];

for i = 1:numDrones
    valid = false;

    while ~valid
        x = randi(rows);
        y = randi(cols);
        pos = [x, y];

        if isempty(usedPositions) || ~ismember(pos, usedPositions, 'rows')
            valid = true;
            usedPositions = [usedPositions; pos];
        end
    end

    drones(i).position = pos;
    drones(i).target = [];
    drones(i).path = pos;
    drones(i).timeActive = 0;
    drones(i).waterDrops = 0;
    drones(i).distanceTraveled = 0;
    drones(i).nearMissCount = 0;
    drones(i).id = i;
    drones(i).cellsExtinguished = 0;
    drones(i).events = {sprintf('Drone %d initialized at (%d, %d)', i, pos(1), pos(2))};
end
end