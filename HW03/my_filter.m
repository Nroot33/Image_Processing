function filter_img = my_filter(img, filter_size, type)
%  img: Image.     dimension (X x Y)
%  fil_size: Filter maks(kernel)'s size.  type: (uint8)
%  type: Filter type. {'avr', 'laplacian', 'median', 'sobel', 'unsharp'}
pad_size = floor(filter_size/2);
pad_img = my_padding(img, pad_size, 'zero');
[x, y] = size(img);
filter_img = zeros(x, y);

if strcmp(type, 'avr')
    for i = 1:x
        for j = 1:y
            % fil_size-1까지로 해야 filter size만큼의 mask가 잡힘
            filter_img(i,j) = mean(mean(pad_img(i:i+filter_size-1, j:j+filter_size-1)));
        end
    end
elseif strcmp(type, 'weight')
    % 다른 필터의 마스크를 만들 때에 참고
    mask = [1:pad_size+1 pad_size:-1:1]' * [1:pad_size+1 pad_size:-1:1];
    % 필터의 합이 1이 되게 하기 위해 sum을 미리 구함
    s = sum(sum(mask));
    for i = 1:x
       for j = 1:y
           filter_img(i,j) = sum(sum(double(pad_img(i:i+filter_size-1,j:j+filter_size-1)).*mask))/s; 
       end
    end
elseif strcmp(type, 'laplacian') % Laplacian Filter
    mask = ones(filter_size);
    mask(floor(filter_size/2)+1,floor(filter_size/2)+1) = -1 *(filter_size * filter_size -1);
    for i = 1:x
       for j = 1:y
           filter_img(i,j) = sum(sum(double(pad_img(i:i+filter_size-1,j:j+filter_size-1)).*mask)); 
       end
    end
elseif strcmp(type, 'median') % Median Filter
    % Fill here
    for i = 1:x
        for j = 1:y
            % fil_size-1까지로 해야 filter size만큼의 mask가 잡힘
            filter_img(i,j) = median(median(pad_img(i:i+filter_size-1, j:j+filter_size-1)));
        end
    end
elseif strcmp(type, 'sobel') % Sobel Filter
    % Fill it
    v_img = zeros(x, y);
    h_img = zeros(x, y);
    
    mask_v = [1:pad_size+1 pad_size:-1:1]'*[-pad_size*pad_size];
    
    mask_h = mask_v';
     
    for i = 1:x
        for j = 1:y
            % fil_size-1까지로 해야 filter size만큼의 mask가 잡힘
            filter_img(i,j) = sum(sum(double(pad_img(i:i+filter_size-1,j:j+filter_size-1)).*mask_v)); 
            
            filter_img(i,j) = sum(sum(double(pad_img(i:i+filter_size-1,j:j+filter_size-1)).*mask_h)); 
            filter_img(i,j) = v_img +h_img;
        end
    end
    
    % Sobel에서 만들어지는 이미지 비교
    figure
    subplot(1, 1500, 1:490), imshow(v_img), title('v mask image');
    subplot(1, 1500, 501:990), imshow(h_img), title('h mask image');
    subplot(1, 1500, 1001:1490), imshow(filter_img), title('sobel image');
elseif strcmp(type, 'unsharp')
    % k는 조정해도 괜찮음 (0 <= k <= 1)
    k = 0.5;
    mask = zeros(filter_size);
    mask(ceil(filter_size/2),ceil(filter_size/2)) = 1;
    A = 1/9*ones(filter_size);
    mask = (1/(1-k))*mask - (k/(1-k))*A;
    for i = 1:x
        for j = 1:y
            filter_img(i,j) = sum(sum(double(pad_img(i:i+filter_size-1,j:j+filter_size-1)).*mask)); 
        end
    end
filter_img = uint8(filter_img);
end