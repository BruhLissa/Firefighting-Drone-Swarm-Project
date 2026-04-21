function drones = initializeDrones(params)
% initializeDrones initializes all drone agents
% Inputs:
%   params.numDrones  - number of drones
%   params.gridSize   - size of grid (NxN)
% Output:
%   drones - struct array of drone agents

    numDrones = params.numDrones;
    gridSize = params.gridSize;

    %preallocate struct array (good practice)
    drones(numDrones) = struct();
    %keep track of used positions (for collision-free start)
    usedPositions = [];

    for i = 1:numDrones
        valid = false;
        %make sure no two drones start in same cell
        while ~valid
            x = randi(gridSize);
            y = randi(gridSize);

            pos = [x, y];

            if isempty(usedPositions) || ~ismember(pos, usedPositions, 'rows')
                valid = true;
                usedPositions = [usedPositions; pos];
            end
        end

        %initialize drone fields
        drones(i).position = pos;          % [x, y]
        drones(i).target = [];             % no target yet
        drones(i).path = pos;              % start path with initial position
        drones(i).timeActive = 0;
        drones(i).waterDrops = 0;
        drones(i).distanceTraveled = 0;
        drones(i).id = i;

    end

end