function fire = FireInit(params)
%FIREINIT will initiate the fire. Starting from the grid size. We'll have a
%fire_start that will initial start with 3 cells of fire randomally
%generated into the grid. These 3 cells will be populated with a randomly
%generated intensity value between 0 and 1.

    rng(params.rng_seed + 10);

    rows = params.grid_size(1);
    cols = params.grid_size(2);
    
    fire.intensity = zeros(rows, cols);
    fire.time = 0;
    
    placed = 0;
    while placed < params.start_fires
        r = randi(rows);
        c = randi(cols);
    
        if fire.intensity(r, c) == 0
            fire.intensity(r, c) = params.seed_low + (params.seed_high - params.seed_low) * rand();
            placed = placed + 1;
        end
    end
end