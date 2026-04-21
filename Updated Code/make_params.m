function params = make_params()
% MAKE_PARAMS creates all the parameters used in other functions

params.grid_size = [30, 30];     % [rows, cols]
params.dt = 1;                   % time step
params.max_steps = 200;          % maximum number of simulation steps

params.n_drones = 4;             % number of drones
params.start_fires = 5;          % number of initial fire cells
params.rng_seed = 5;             % random seed for reproducibility

params.spread_orth = 0.11;       % fire spread amount to orthogonal neighbors
params.decay = 0.03;             % fire decay each step
params.fire_stop_threshold = 0.10; % stop when all fire intensities are below this

params.seed_low = 0.3;           % minimum initial fire intensity
params.seed_high = 0.7;          % maximum initial fire intensity

params.plot_pause = 0.05;        % pause between frames for animation
end

