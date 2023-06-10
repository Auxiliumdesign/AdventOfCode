clear all
S = readlines('7_1.csv');
result = arrayfun(@(x)char(S(x)),1:numel(S),'uni',false);
% Cell array of strings to parse
inputString = arrayfun(@(x)char(S(x)),1:numel(S),'uni',false);
% Initialize root directory
root = Dirs('/', []);
currentDir = root;
% Parse each line
for i = 1:length(inputString)
    line = strtrim(inputString{i});
    % If the line starts with "$", it's a command
    if startsWith(line, '$')
        command = strtrim(extractAfter(line, '$'));
        if startsWith(command, 'cd')
            % Change directory
            dirName = strtrim(extractAfter(command, 'cd'));
            if strcmp(dirName, '..')
                % Go to parent directory
                currentDir = currentDir.parent;
            elseif strcmp(dirName, '/')
                % Go to root directory
                currentDir = root;
            else
                % Go to child directory
                for j = 1:length(currentDir.children)
                    if strcmp(currentDir.children{j}.name, dirName)
                        currentDir = currentDir.children{j};
                        break;
                    end
                end
            end
        end
    else
        % It's a file or directory listing
        parts = strsplit(line, ' ');
        sizeOrDir = strtrim(parts{1});
        name = strtrim(parts{2});
        
        if strcmp(sizeOrDir, 'dir')
            % Directory - create and add to the current directory
            newDir = Dirs(name, currentDir);
            currentDir.addChild(newDir);
        else
            % File - create and add to the current directory
            size = str2double(sizeOrDir);
            newFile = Files(name, size);
            currentDir.addFile(newFile);
        end
    end
end
%%
% Calculate sum of directories with size <= 100000
dirs = getAllDirs(root, {});  % get all directories recursively
totalSize = 0;
for i = 1:length(dirs)
    dirSize = dirs{i}.totalSize();
    if dirSize <= 100000
        totalSize = totalSize + dirSize;
    end
end
part1 = totalSize
%% Part 2
totSpace = 70000000;
reqSpace = 30000000;
currUnusedSpace = totSpace - root.totalSize();
addSpaceNeeded = reqSpace - currUnusedSpace;

% Calculate size of each directory and find the smallest one big enough
dirs = getAllDirs(root, {});  % get all directories recursively
smallestSizeToDelete = Inf;

for i = 1:length(dirs)
    dirSize = dirs{i}.totalSize();
    if dirSize >= addSpaceNeeded && dirSize < smallestSizeToDelete
        smallestSizeToDelete = dirSize;
    end
end
part2 = smallestSizeToDelete


%%
function dirs = getAllDirs(root, dirs)
    dirs{end+1} = root;
    for i = 1:length(root.children)
        dirs = getAllDirs(root.children{i}, dirs);
    end
end

