function erosion = my_erosion(img, filter)
% Apply erosion of binary image
% img     : binary image
% filter  : filter for erosion
% erosion : result of erosion

[x, y] = size(img);
[filter_x, filter_y] = size(filter);
pad_x = floor(filter_x/2);
pad_y = floor(filter_y/2);
erosion = zeros(row, col);

% Apply erosion
for i = 1+pad_x : x-pad_x
    for j = 1+pad_y : y-pad_y
        flag = 0;
        for m = 1 : filter_x
            for n = 1 : filter_y
                if filter(m, n) == img(i - pad_x + m - 1, j - pad_y + n - 1)
                    flag = flag + 1;
                end
            end
        end
        if flag == filter_x * filter_y
            erosion(i, j) = 1;
        end
    end
end
end