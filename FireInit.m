function fire = FireInit(param)
%FIREINIT will initiate the fire. Starting from the grid size. We'll have a
%fire_start that will initial start with 3 cells of fire randomally
%generated into the grid. These 3 cells will be populated with a randomly
%generated intensity value between 0 and 1.

    % Get grid size
    rows = param.grid_size(1)
    cols = param.grid_size(2)
    
    % Create empty grid
    fire.intensity = zeros(rows, cols)
    
    % Number of initial fires
    fire_start = 3
    
    for ii = 1:fire_start
        
        % Pick random location in grid
        r = randi(rows)
        c = randi(cols)
        
        % Assign random intensity between 0 and 1
        fire.intensity(r, c) = rand()
    
    end

end