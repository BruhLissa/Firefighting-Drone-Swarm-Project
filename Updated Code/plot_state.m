function plot_state(fire, drones, step)
% PLOT_STATE displays fire heatmap and drone positions

imagesc(fire.intensity, [0 1]);
colormap(hot);
colorbar;
axis equal;
axis tight;
hold on;

for i = 1:length(drones)
    x = drones(i).position(2); % column
    y = drones(i).position(1); % row

    plot(x, y, 'co', 'MarkerFaceColor', 'c', 'MarkerSize', 8);
    text(x + 0.3, y, sprintf('D%d', i), 'Color', 'w', 'FontWeight', 'bold');
end

title(['Firefighting Drone Simulation - Step ', num2str(step)]);
xlabel('Column');
ylabel('Row');

hold off;
drawnow;
end