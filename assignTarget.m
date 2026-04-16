function drone = assignTarget(drone, fire)
% ASSIGN_TARGET selects the highest intensity fire cell
% Inputs:
%   drone - single drone struct
%   fire  - fire struct with intensity matrix
% Output:
%   drone - updated drone with target

    %find max fire intensity
    [maxVal, index] = max(fire.intensity(:));

    %if no fire exists
    if maxVal == 0
        drone.target = [];
        return;
    end

    %convert index to (row, col)
    [row, col] = ind2sub(size(fire.intensity), index);
    %assign target
    drone.target = [row, col];
end