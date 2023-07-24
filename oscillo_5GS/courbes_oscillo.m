%% Initialisation

clear all 
close all

%Couleur
newcolors = [0 0.4470 0.7410
             0.83 0.14 0.14
             1.00 0.54 0.00
             0.47 0.25 0.80
             0.25 0.80 0.54
             0.3010 0.7450 0.9330];
         
colororder(newcolors)

%% Lecture des fichiers et récupération des données

prompt_all = "Combien de courbes souhaitez-vous tracer ? (enter a number) ";
nombre_courbes = input(prompt_all,"s");

str="%f";
for i=1:nombre_courbes*2
    str=str+" %f";
end

U={};
donnees_brutes={};
pos_max={};

x=linspace(0,10,500);
x2=linspace(0,10,1000);

for i=1:str2double(nombre_courbes)
    [FileName,PathName] = uigetfile('*.txt','sélectionnez le fichier texte');
    fid=fopen(fullfile(PathName,FileName),'r');
    Data = textscan(fid, '%f');
    fclose(fid);
    donnees_brutes(end+1) = {Data{1,1}};
    U_fit = fit(x(:),Data{1,1},'gauss3');
    U_fit_y = gaussienne(U_fit,x2);
    U(end+1)={U_fit_y};
    [x_max,ind_max]=max(U_fit_y);
    pos_max(end+1)={x2(ind_max)};
    U2=Data{1,1};
end

delai1 = pos_max{2}-pos_max{1}
delai2 = pos_max{4}-pos_max{1}


%% Tracé des courbes 



for k=1:str2double(nombre_courbes)
    %f=fit(x{k},visibilite{k},'smoothingspline');
    plot(x,donnees_brutes{k},'Color', 'blue' ,'Marker', 'o');%,'Linestyle','none');
    hold on;
    plot(x2,U{k},'Color', 'red');%,'Linestyle','none');
    hold on;
    %errorbar(x{k},visibilite{k}, incertitudes_visibilite{k}, 'Color', newcolors(k,:) ,'Marker', 'none', 'LineStyle', 'none' );
end

title('');
xlabel('Temps (en ns)');
ylabel('Tension (en mV)');
%legend(name_legend);
grid;


%% Fonctions

%% Fonction sinc

function y = gaussienne(data,x)
a1=data.a1; a2=data.a2; a3=data.a3;
b1=data.b1; b2=data.b2; b3=data.b3;
c1=data.c1; c2=data.c2; c3=data.c3;
y = a1*exp(-((x-b1)/c1).^2) + a2*exp(-((x-b2)/c2).^2) + a3*exp(-((x-b3)/c3).^2);
end

