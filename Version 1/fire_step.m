function fire = fire_step(fire, params)
% FIRE_STEP  Spread fire to neighbors, decay, clamp to [0,1]

I = fire.intensity;

orthKernel = [0 1 0; 1 0 1; 0 1 0];
incoming = conv2(I, orthKernel, 'same');

% Spread depends on current nearby intensity
Inew = I + params.spread_orth * incoming;

% Decay only burning cells
burningMask = Inew > 0;
Inew(burningMask) = Inew(burningMask) - params.decay;

% Clamp
Inew = max(0, min(1, Inew));

fire.intensity = Inew;
end