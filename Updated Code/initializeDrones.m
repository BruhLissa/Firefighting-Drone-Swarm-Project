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

    drones(i).position = pos;          % [row, col]
    drones(i).target = [];             % no target yet
    drones(i).path = pos;              % start path log
    drones(i).timeActive = 0;
    drones(i).waterDrops = 0;
    drones(i).distanceTraveled = 0;
    drones(i).id = i;
end
end