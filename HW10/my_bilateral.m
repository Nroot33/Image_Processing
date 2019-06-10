function filter_img = my_bilateral(img, filter_size, sigma, sigma2)
% Apply bilateral filter
% img        : GrayScale Image
% filter_img : bilateral filtered image 

[X,Y] = meshgrid(-filter_size:filter_size,-filter_size:filter_size);
G = exp(-(X.^2+Y.^2)/(2*sigma^2));

dim = size(img);
B = zeros(dim);
for i = 1:dim(1)
   for j = 1:dim(2)
       
       
         iMin = max(i-filter_size,1);
         iMax = min(i+filter_size,dim(1));
         jMin = max(j-filter_size,1);
         jMax = min(j+filter_size,dim(2));
         I = A(iMin:iMax,jMin:jMax);
        
         H = exp(-(I-A(i,j)).^2/(2*sigma2^2));
      
         F = H.*G((iMin:iMax)-i+filter_size+1,(jMin:jMax)-j+filter_size+1);
         B(i,j) = sum(F(:).*I(:))/sum(F(:));               
   end
end

filter_img = uint8(filter_img/s);
end

