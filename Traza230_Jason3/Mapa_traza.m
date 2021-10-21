clear all
ncfile='JA3_GPSOPR_2PdS145_230_20200124_054252_20200124_071928.nc.nc';
ncdisp(ncfile);
info=ncinfo(ncfile);
names = {info.Variables.Name};

Hs_satelite = ncread(ncfile,'swh_ku');
lat_satelite = ncread(ncfile,'lat');
lon_satelite = ncread(ncfile,'lon');
tiempo_satelite = ncread(ncfile,'time');

T_satelite=datenum(seconds(tiempo_satelite) + datenum('2000-01-01 00:00:00'));
time_satelite=datevec(T_satelite);

%minutos_satelite=time_satelite(1:end,5);


%% Leo datos boya
A=xlsread('Bahia de Valparaíso 2019-2020.xlsx');

Hs_boya=A(13:end,8);
Direccion_boya=A(13:end,7);
Periodo_boya=A(13:end,9);

yyyy_boya=A(13:end,1);
mes_boya=A(13:end,2);
dia_boya=A(13:end,3); 
hora_boya=A(13:end,4);

tiempo_medido_boya=datenum(yyyy_boya,mes_boya,dia_boya,hora_boya,00,00);
fecha_boya=datevec(tiempo_medido_boya);

%% MAPA TRAZA (-32.9872,288.1835)

% figure()
% geoscatter(lat_satelite,lon_satelite,Hs_satelite)
% hold on
% geoscatter(-32.9872,288.1835)

%% Co-localizar
%%  Datos con hasta 30 minutos de diferencia
Fecha_satelite=time_satelite(1:2790,:);
AlturaOla_satelite=Hs_satelite(1:2790,:);
Latitud_satelite=lat_satelite(1:2790,:);
Longitud_satelite=lon_satelite(1:2790,:);

%save('enero24_2020.mat','Fecha_satelite','AlturaOla_satelite','Latitud_satelite','Longitud_satelite')


%% Datos con hasta 50 km de diferencia

latlon1=[-32.9872 288.1835]; %boya
latlon2=[42.8043 253.8520];%[-33.02 288.1]; %satélite

%[d1km_1 d2km_1]=lldistkm(latlon1,latlon2)

latlon3=[Latitud_satelite Longitud_satelite];%satelite

B = ones(2790,2); %matriz de unos
latlon4=B.*latlon1; %boya matriz

for i=length(Latitud_satelite)
    [d1km(i) d2km(i)]=lldistkm(latlon4(i,:),latlon3(i,:))
end

