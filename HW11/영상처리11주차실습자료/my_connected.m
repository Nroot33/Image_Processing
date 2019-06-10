function img = my_connected(img)
% Find connected level using DFS for 4-direction
% img       : binary image

% Set Limit of recursion 3000
set(0, 'RecursionLimit', 3000)

% Set 1 to -1

% recursive find 1 value


end

function img = my_recursive_label(img, y, x, height, width, c)
% Recursively Find 1
% img    : binary image
% y      : y index
% x      : x index
% height : height of image
% width  : width of image
% c      : value for labeling 

% Recursively find -1 and ignore 0
% Recursion in matlab should receive result of 'call by value'

end