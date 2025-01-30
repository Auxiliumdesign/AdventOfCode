clear all;
% Read the input file
% Read the file
data = readlines("Input.txt");
data = char(data);
letters = unique(data);
visited = zeros(length(data),length(data),length(letters));

% Convert grid to numeric for easier processing
numeric_grid = double(data);
grid = numeric_grid
sum = 0
% Start flood fill for a region (e.g., starting at [1,1])
while ~isempty(find(grid,1,'first'))
[row,col] = find(grid,1,'first');
char(grid(row,col))
[area, perimeter,grid] = flood_fill(grid, row,col, numeric_grid(row,col));
area*perimeter
sum = sum + area*perimeter;
end
% Display results
disp(['Area: ', num2str(area)]);
disp(['Perimeter: ', num2str(perimeter)]);


function [area, perimeter, grids] = flood_fill(grid, x, y, plant_type)
    % Dimensions of the grid
    [rows, cols] = size(grid);
    
    % Stack to hold cells to process
    stack = [x, y];
    area = 0;
    perimeter = 0;

    % Directions: up, down, left, right
    directions = [-1 0; 1 0; 0 -1; 0 1];

    % Flood fill
    while ~isempty(stack)
        % Pop a cell
        cell = stack(end, :);
        stack(end, :) = [];
        cx = cell(1);
        cy = cell(2);

        % Skip if already visited
        if grid(cx, cy) ~= plant_type
            continue;
        end

        % Mark as visited
        grid(cx, cy) = -1;

        % Increase area
        area = area + 1;

        % Check neighbors
        for d = 1:size(directions, 1)
            nx = cx + directions(d, 1);
            ny = cy + directions(d, 2);
            
            if nx < 1 || nx > rows || ny < 1 || ny > cols 
                % Boundary edge
                perimeter = perimeter + 1;
            elseif grid(nx, ny) ~= plant_type  && grid(nx, ny) ~= -1
                perimeter = perimeter + 1;
            elseif grid(nx, ny) ~= 0
                % Add neighbor to stack
                stack = [stack; nx, ny]; %#ok<AGROW>
            end
        end
    end
    grid(grid==-1) = 0;
    grids = grid;
end
