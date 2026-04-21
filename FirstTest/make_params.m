function params = make_params()
    % MAKE_PARAMS  Create simulation settings
    
    params.grid_size = [30, 30];
    params.dt = 1;
    params.max_steps = 150;
    
    params.num_drones = 5;
    params.start_fires = 5;
    params.rng_seed = 7;
    
    params.spread_orth = 0.12;      % orthogonal spread coefficient
    params.decay = 0.03;            % global decay for burning cells
    params.fire_stop_threshold = 0.10;
    
    params.seed_low = 0.5;          % initial fire seed intensity min
    params.seed_high = 1.0;         % initial fire seed intensity max
    
    params.water_radius = 0;        % 0 = only current cell
    params.plot_pause = 0.05;
    
    params.output_dir = pwd;

    params.time = 0;
    params.maxTime = 180;
    params.stop = 0;
end