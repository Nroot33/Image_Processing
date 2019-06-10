function img = my_connected(img)
% Find connected level using DFS for 4-direction
% img       : binary image
% Set Limit of recursion 3000
% Set 1 to -1
% recursive find 1 value
%set(0, 'RecursionLimit', 3000)

img = -img;

[h, w] = size(img);
pad_img = zeros(h+2, w+2);
pad_img(2:h+1, 2:w+1) = img(1:h, 1:w);

color = 1;

for x = 2 : h+1
    for y = 2 : w+1
        if  pad_img(x, y) < 0
            pad_img(x, y) = color;
            pad_img = my_recursive_label(pad_img,y,x,h,w,color);
            color = color+1;
        end
    end
end

img = pad_img(2 : h+1, 2 : w+1);
s = 255 / c;
img = uint8(img * s);

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

        
if  img(x - 1, y) < 0
    img(x - 1, y) = c;
    img = my_recursive_label(img, y, x - 1, height, width, c);
end
        
if img(x, y - 1) < 0
    img(x, y - 1) = c;
    img = my_recursive_label(img, y - 1, x, height, width, c);
end
        
if img(x, y + 1) < 0
    img(x, y + 1) = c;
    img = my_recursive_label(img, y + 1, x, height, width, c);
end
        
if img(x + 1, y) < 0
    img(x + 1, y) = c;
    img = my_recursive_label(img, y, x + 1, height, width, c);
end
        
end