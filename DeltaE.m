function [dE] = DeltaE(image1,image2)
% TFP Felipe Castro 
% Diplomatura de Postgrau en Gestió, Preservació i Difusió d’Arxius Fotogràfics
% La variable "image1" corresponde a la imagen original e "image2" a la imagen deteriorada

fig = uifigure;
uiprogressdlg(fig,'Title','En proceso','Indeterminate','on');
drawnow


% Alineación de las dos imágenes (translación)
[height, width,~] = size(image1);
image3 = imresize(image2, [height, width],'bilinear');
[image_tra] = imregmtb(image3,image1);

% Transformaciones geométricas
tform = imregcorr(image_tra,image1);
image_geo = imwarp(image_tra,tform);
image4 = imresize(image_geo, [height, width],'bilinear');


% Cálculo de DeltaE2000 y configuración del mapa de colores
dE = imcolordiff(image4,image1,"Standard","CIEDE2000");
    
     
figure;

subplot(2, 2, 1);
imshow(image1);
title('Imagem original', 'FontSize', 14);
axis image;

subplot(2, 2, 2);
imshow(image2);
title('Imagem analisada', 'FontSize', 14);
axis image;

subplot(2, 2, [3,4]);
clims = [0 10];  % Estabelece os limites para a visualização do DeltaE 2000
imagesc(dE,clims);
axis image
axis off
var = colorbar;
var.Label.String = 'ΔE2000';

close(fig)

end

