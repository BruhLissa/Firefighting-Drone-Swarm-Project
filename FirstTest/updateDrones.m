function [drone, fire] = updateDrones(drone, fire, params, allDrones)
% updateDrone updates a single drone for one time step
%
% Inputs:
%   drone      - current drone
%   fire       - fire struct
%   params     - simulation parameters
%   allDrones  - all drones (for collision checking)
%
% Outputs:
%   drone - updated drone
%   fire  - updated fire

    %assigns target
    drone = assign_target(drone, fire);

    %checks for fire
    if isempty(drone.target)
        return;
    end
    %current position
    current = drone.position;
    target = drone.target;

    dx = sign(target(1) - current(1));
    dy = sign(target(2) - current(2));

    %movement
    proposed = current + [dx, dy];

    %checking for collisions
    for j = 1:length(allDrones)
        if allDrones(j).id ~= drone.id
            if isequal(proposed, allDrones(j).position)
                % collision → stay in place
                proposed = current;
                break;
            end
        end
    end

    %updates position
    drone.position = proposed;

    %updating distance traveled (loggin)
    moveDist = abs(dx) + abs(dy);
    drone.distanceTraveled = drone.distanceTraveled + moveDist;

    %update path
    drone.path = [drone.path; proposed];

    %check for fire
    x = proposed(1);
    y = proposed(2);

    if fire.intensity(x, y) > 0
        fire.intensity(x, y) = 0; % extinguish fire
        drone.waterDrops = drone.waterDrops + 1;
    end

end