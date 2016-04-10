
function imcomp3()
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
Z = [2,5,10,20];
a = input('\N enter an extra value k, 0 to quit ->');
while a ~= 0
    Z= [Z,a];
    a = input('\N enter an extra value k, 0 to quit ->');
end
for x = Z 

[Ar, S, K, ~] = svdNfo(matIn, x, 1);
[Ag, S, K, ~] = svdNfo(matIn, x, 2);
[Ab, S, K, ~] = svdNfo(matIn, x, 3);

figure;
imdata = uint8(Ar);
RC = imdata(:,:,1);
imdata = uint8(Ag);
GC = imdata(:,:,1);
imdata = uint8(Ab);
BC = imdata(:,:,1);
f = cat(3,RC, GC, BC);
imshow(f);
text(20, 20,['k =' num2str(x) ' \sigma_1 = ' num2str(S) ', \sigma_k = ' num2str(K)]...
    ,'EdgeColor','red','BackgroundColor','white');
imwrite(x, num2str(x), filetype);
end
end


function [Ak, sig1, sigk, sigk1] = svdNfo(A, k, i)

[U, S, V] = svds(double((A(:,:,i))), k);

Ak = U*S*V'; %rank k approximation
sigs = diag(S); 
sig1 = sigs(1); %sigma_1
sigk = sigs(k); %sigma_k

Ak1 = svds(double((A(:,:,i))), k+1);
sigk1 = Ak1(end); %sigma_(k+1)
end