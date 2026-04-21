function fire = FireInit(params)
% FIREINIT creates the initial fire grid with random starting fires

rows = params.grid_size(1);
cols = params.grid_size(2);

fire.intensity = zeros(rows, cols);
fire.justSpawned = zeros(rows, cols);
fire.time = 0;

placed = 0;
while placed < params.start_fires
    r = randi(rows);
    c = randi(cols);

    if fire.intensity(r, c) == 0
        fire.intensity(r, c) = params.seed_low + ...
            (params.seed_high - params.seed_low) * rand();

        fire.justSpawned(r, c) = 1;
        placed = placed + 1;
    end
end
end