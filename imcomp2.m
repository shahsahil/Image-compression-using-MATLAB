
function imcomp2()
imgIn = input('\nEnter full image filename, including filetype, or press return to skip:\n', 's');
[filename, filetype] = strtok(imgIn,'.');
if isempty(filename)
    fprintf('Ok, no image file, moving on...\n');
else
    filetype(1) = [];
    img2Mat = imread(filename, filetype);
end
matIn = img2Mat;

matIn(matIn < 0) = 0; %handles negative vals
matIn(matIn > 255) = 255; %handles colors over 8 bits
[A2r, S2, K2, ~] = svdNfo(matIn, 2, 1);
[A2g, S2, K2, ~] = svdNfo(matIn, 2, 2);
[A2b, S2, K2, ~] = svdNfo(matIn, 2, 3);
[A5r, S5, K5, ~] = svdNfo(matIn, 5, 1);
[A5g, S5, K5, ~] = svdNfo(matIn, 5, 2);
[A5b, S5, K5, ~] = svdNfo(matIn, 5, 3);
[A10r, S10, K10, ~] = svdNfo(matIn, 10, 1);
[A10g, S10, K10, ~] = svdNfo(matIn, 10, 2);
[A10b, S10, K10, ~] = svdNfo(matIn, 10, 3);
[A20r, S20, K20, ~] = svdNfo(matIn, 20,1);
[A20g, S20, K20, ~] = svdNfo(matIn, 20, 2);
[A20b, S20, K20, ~] = svdNfo(matIn, 20, 3);


[A50r, S50, K50, ~] = svdNfo(matIn, 50, 1);
[A50g, S50, K50, ~] = svdNfo(matIn, 50, 2);
[A50b, S50, K50, ~] = svdNfo(matIn, 50, 3);



figure;
imdata = uint8(A2r);
RC = imdata(:,:,1);
imdata = uint8(A2g);
GC = imdata(:,:,1);
imdata = uint8(A2b);
BC = imdata(:,:,1);
f2 = cat(3,RC, GC, BC);
imshow(f2);
text(20, 20,['k = 2, \sigma_1 = ' num2str(S2) ', \sigma_k = ' num2str(K2)]...
    ,'EdgeColor','red','BackgroundColor','white');

figure;
imdata = uint8(A5r);
RC = imdata(:,:,1);
imdata = uint8(A5g);
GC = imdata(:,:,1);
imdata = uint8(A5b);
BC = imdata(:,:,1);
f5 = cat(3,RC, GC, BC);
imshow(f5);
text(20, 20,['k = 5, \sigma_1 = ' num2str(S5) ', \sigma_k = ' num2str(K5)]...
    ,'EdgeColor','red','BackgroundColor','white');

figure;
imdata = uint8(A10r);
RC = imdata(:,:,1);
imdata = uint8(A10g);
GC = imdata(:,:,1);
imdata = uint8(A10b);
BC = imdata(:,:,1);
f10 = cat(3,RC, GC, BC);

imshow(f10);
text(20, 20,['k = 10, \sigma_1 = ' num2str(S10) ', \sigma_k = ' num2str(K10)]...
    ,'EdgeColor','red','BackgroundColor','white');
figure;
imdata = uint8(A20r);
RC = imdata(:,:,1);
imdata = uint8(A20g);
GC = imdata(:,:,1);
imdata = uint8(A20b);
BC = imdata(:,:,1);
f20 = cat(3,RC, GC, BC);
imshow(f20);
text(20, 20,['k = 20, \sigma_1 = ' num2str(S20) ', \sigma_k = ' num2str(K20)]...
    ,'EdgeColor','red','BackgroundColor','white');



figure;
imdata = uint8(A50r);
RC = imdata(:,:,1);
imdata = uint8(A50g);
GC = imdata(:,:,1);
imdata = uint8(A50b);
BC = imdata(:,:,1);
f50 = cat(3,RC, GC, BC);
imshow(f50);
text(20, 20,['k = 50, \sigma_1 = ' num2str(S50) ', \sigma_k = ' num2str(K50)]...
    ,'EdgeColor','red','BackgroundColor','white');



imwrite(f2, '2.jpg', filetype);
imwrite(f5, '5.jpg', filetype);
imwrite(f10, '10.jpg', filetype);
imwrite(f20, '20.jpg', filetype);


imwrite(f50, '50.jpg', filetype);


end

%Returns rank k approximation, sigma_1, sigma_k, and sigma_(k+1)
function [Ak, sig1, sigk, sigk1] = svdNfo(A, k, i)

[U, S, V] = svds(double((A(:,:,i))), k);

Ak = U*S*V'; %rank k approximation
sigs = diag(S); 
sig1 = sigs(1); %sigma_1
sigk = sigs(k); %sigma_k

Ak1 = svds(double((A(:,:,i))), k+1);
sigk1 = Ak1(end); %sigma_(k+1)
end