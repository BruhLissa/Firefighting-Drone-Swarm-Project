function drone = assignTarget(drone, fire, allDrones)
% ASSIGN_TARGET selects the highest intensity fire cell
% Inputs:
%   drone - single drone struct
%   fire  - fire struct with intensity matrix
% Output:
%   drone - updated drone with target

[rows, cols] = size(fire.intensity);

bestScore = -inf;
bestTarget = [];

for r = 1:rows
    for c = 1:cols

        intensity = fire.intensity(r, c);

        % only consider cells that are actually burning
        if intensity > 0.1

            candidate = [r, c];

            % distance from this drone to candidate cell
            dist = abs(candidate(1) - drone.position(1)) + abs(candidate(2) - drone.position(2));

            % penalty if another drone already targets this cell
            takenPenalty = 0;
            for j = 1:length(allDrones)
                if allDrones(j).id ~= drone.id && ~isempty(allDrones(j).target)
                    if isequal(candidate, allDrones(j).target)
                        takenPenalty = takenPenalty + 2;
                    end
                end
            end

            % score: high intensity is good, far distance and taken targets are bad
            score = intensity - 0.03 * dist - takenPenalty;

            if score > bestScore
                bestScore = score;
                bestTarget = candidate;
            end
        end
    end
end

drone.target = bestTarget;
end