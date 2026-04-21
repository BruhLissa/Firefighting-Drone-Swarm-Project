function fire = fire_step(fire, params)
% FIRE_STEP
% 1. Existing fire spreads to orthogonal neighbors
% 2. Newly ignited cells are marked as justSpawned
% 3. Only older fire cells decay this step
% 4. Clamp values between 0 and 1

oldIntensity = fire.intensity;
newIntensity = oldIntensity;

rows = size(oldIntensity, 1);
cols = size(oldIntensity, 2);

% keep track of cells that become new fire this step
newJustSpawned = zeros(rows, cols);

% spread fire from existing burning cells
for r = 1:rows
    for c = 1:cols

        if oldIntensity(r, c) > 0
            spreadAmount = params.spread_orth * oldIntensity(r, c);

            % up
            if r > 1
                if oldIntensity(r-1, c) == 0
                    newJustSpawned(r-1, c) = 1;
                end
                newIntensity(r-1, c) = newIntensity(r-1, c) + spreadAmount;
            end

            % down
            if r < rows
                if oldIntensity(r+1, c) == 0
                    newJustSpawned(r+1, c) = 1;
                end
                newIntensity(r+1, c) = newIntensity(r+1, c) + spreadAmount;
            end

            % left
            if c > 1
                if oldIntensity(r, c-1) == 0
                    newJustSpawned(r, c-1) = 1;
                end
                newIntensity(r, c-1) = newIntensity(r, c-1) + spreadAmount;
            end

            % right
            if c < cols
                if oldIntensity(r, c+1) == 0
                    newJustSpawned(r, c+1) = 1;
                end
                newIntensity(r, c+1) = newIntensity(r, c+1) + spreadAmount;
            end
        end

    end
end

% decay only cells that were already old fire
for r = 1:rows
    for c = 1:cols

        if newIntensity(r, c) > 0 && fire.justSpawned(r, c) == 0 && newJustSpawned(r, c) == 0
            newIntensity(r, c) = newIntensity(r, c) - params.decay;
        end

        % clamp to [0,1]
        if newIntensity(r, c) < 0
            newIntensity(r, c) = 0;
        elseif newIntensity(r, c) > 1
            newIntensity(r, c) = 1;
        end

    end
end

fire.intensity = newIntensity;

fire.justSpawned = newJustSpawned;
end