function summaryTbl = Summarize_results(drones, fire, params)
% SUMMARIZE_RESULTS creates a summary table and saves outputs

n = length(drones);

DroneID = zeros(n,1);
CellsExtinguished = zeros(n,1);
DistanceTraveled = zeros(n,1);
TimeActive = zeros(n,1);
NearMissCount = zeros(n,1);

for i = 1:n
    DroneID(i) = drones(i).id;
    CellsExtinguished(i) = drones(i).cellsExtinguished;
    DistanceTraveled(i) = drones(i).distanceTraveled;
    TimeActive(i) = drones(i).timeActive;
    NearMissCount(i) = drones(i).nearMissCount;
end

summaryTbl = table(DroneID, CellsExtinguished, DistanceTraveled, ...
                   TimeActive, NearMissCount);

disp('Drone Summary Table:');
disp(summaryTbl);

writetable(summaryTbl, 'summary.csv');
save('results.mat', 'fire', 'drones', 'params', 'summaryTbl');
end