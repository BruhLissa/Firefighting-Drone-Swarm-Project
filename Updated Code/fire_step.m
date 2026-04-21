function fire = fire_step(fire, params)
% FIRE_STEP
% The existing fire will spread to othogonal neighbors, newly ignited 
% shouln't spread and the only older fire cells decay with old fire. The
% intensity values are kept between 0 and 1 (from the clamp function).

oldIntensity = fire.intensity;
newIntensity = oldIntensity;

rows = size(oldIntensity, 1);
cols = size(oldIntensity, 2);

% Thisi keeps track of cells that become new fire 
newJustSpawned = zeros(rows, cols);

% Fire Spread (from existing burning cells)
for r = 1:rows
    for c = 1:cols

        if oldIntensity(r, c) > 0
            spreadAmount = params.spread_orth * oldIntensity(r, c);

            % North
            if r > 1
                if oldIntensity(r-1, c) == 0
                    newJustSpawned(r-1, c) = 1;
                end
                newIntensity(r-1, c) = newIntensity(r-1, c) + spreadAmount;
            end

            % South
            if r < rows
                if oldIntensity(r+1, c) == 0
                    newJustSpawned(r+1, c) = 1;
                end
                newIntensity(r+1, c) = newIntensity(r+1, c) + spreadAmount;
            end

            % West
            if c > 1
                if oldIntensity(r, c-1) == 0
                    newJustSpawned(r, c-1) = 1;
                end
                newIntensity(r, c - 1) = newIntensity(r, c -1) + spreadAmount;
            end

            % East
            if c < cols
                if oldIntensity(r, c + 1) == 0
                    newJustSpawned(r, c + 1) = 1;
                end
                newIntensity(r, c + 1) = newIntensity(r, c+1) + spreadAmount;
            end
        end

    end
end

% Fire Decay (only cells that were already old fire)
for r = 1:rows
    for c = 1:cols

        if newIntensity(r, c) > 0 && fire.justSpawned(r, c) == 0 && newJustSpawned(r, c) == 0
            newIntensity(r, c) = newIntensity(r, c) - params.decay;
        end
        
        %clamp
        newIntensity(r, c) = Clamp(newIntensity(r, c), 0, 1);
    end
end

fire.intensity = newIntensity;

fire.justSpawned = newJustSpawned;
end