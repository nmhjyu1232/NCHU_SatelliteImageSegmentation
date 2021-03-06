% Building Dataset
clc;
clear all;
%  Setup Path
%  Path of 登記+未登記標記
Mask_CommonPath = 'E:\allen\mask\src_mask\';

% Mask_Path = {...
%    [Mask_CommonPath, '20161024_Yun\20161024_Yun_NRR2.tif'],...
%    [Mask_CommonPath, '20161214_Chang\20161214_Chang_NRR2.tif'],...
%    [Mask_CommonPath, '20161220_ChungChang\20161220_ChungChang_NRR2.tif'],...
%    [Mask_CommonPath, '20161213_ChangYun\20161213_ChangYun_NRR2.tif'],...
%    [Mask_CommonPath, '20161213_ChangYunChia\20161213_ChangYunChia_NRR2.tif'],...
%    [Mask_CommonPath, '20161213_Yun\20161213_Yun_NRR2.tif']};

%  Path of 登記標記
% Mask_CommonPath = 'F:\allen\data\mask\remark_mask\water_mask\';
% Mask_Path = {...
%    [Mask_CommonPath, '20161024_Yun\20161024_Yun_R.tif'],...
%    [Mask_CommonPath, '20161214_Chang\20161214_Chang_R.tif'],...
%    [Mask_CommonPath, '20161220_ChungChang\20161220_ChungChang_R.tif'],...
%    [Mask_CommonPath, '20161213_ChangYun\20161213_ChangYun_R.tif'],...
%    [Mask_CommonPath, '20161213_ChangYunChia\20161213_ChangYunChia_R.tif'],...
%    [Mask_CommonPath, '20161213_Yun\20161213_Yun_R.tif']};

%  Path of 未登記標記
% Mask_CommonPath = 'F:\allen\data\mask\src_mask\';
Mask_Path = {...
   [Mask_CommonPath, '20161024_Yun\20161024_Yun_NR.tif'],...
   [Mask_CommonPath, '20161214_Chang\20161214_Chang_NR.tif'],...
   [Mask_CommonPath, '20161220_ChungChang\20161220_ChungChang_NR.tif'],...
   [Mask_CommonPath, '20161213_ChangYun\20161213_ChangYun_NR.tif'],...
   [Mask_CommonPath, '20161213_ChangYunChia\20161213_ChangYunChia_NR.tif'],...
   [Mask_CommonPath, '20161213_Yun\20161213_Yun_NR.tif']};

%  Path of  登記標記
Src_CommonPath = 'E:\allen\src\';
Src_Path = {...
   [Src_CommonPath, '20161024_Yun\I0038567.tif'],...
   [Src_CommonPath, '20161214_Chang\I0039049.tif'],...
   [Src_CommonPath, '20161220_ChungChang\I0039042.tif'],...
   [Src_CommonPath, '20161213_ChangYun\I0039047.tif'],...
   [Src_CommonPath, '20161213_ChangYunChia\I0039045.tif'],...
   [Src_CommonPath, '20161213_Yun\I0039046.tif']};

% fprintf('Building_Dataset_V2.\n');
% Mask_CommonPath = 'L:\LAB722\map\data\mask\src_mask\Land_bird_Mask\';
% Mask_Path = {...
%     [Mask_CommonPath, '20161024_Yun_Land_bird_Mask.tif'],...
%     [Mask_CommonPath, '20161214_Chang_Land_bird_Mask.tif'],...
%     [Mask_CommonPath, '20161220_ChungChang_Land_bird_Mask.tif'],...
%     [Mask_CommonPath, '20161213_ChangYun_Land_bird_Mask.tif'],...
%     [Mask_CommonPath, '20161213_ChangYunChia_Land_bird_Mask.tif'],...
%     [Mask_CommonPath, '20161213_Yun_Land_bird_Mask.tif']};

% Src_CommonPath = 'J:\allen\data\src\';
% Src_Path = {...
%     [Src_CommonPath, '20161024_Yun\I0038567.tif'],...
%     [Src_CommonPath, '20161214_Chang\I0039049.tif'],...
%     [Src_CommonPath, '20161220_ChungChang\I0039042.tif'],...
%     [Src_CommonPath, '20161213_ChangYun\I0039047.tif'],...
%     [Src_CommonPath, '20161213_ChangYunChia\I0039045.tif'],...
%     [Src_CommonPath, '20161213_Yun\I0039046.tif']};

% 
% Edge_Path = {...
%     [Mask_CommonPath, '20161024_Yun\20161024_Yun_edge.tif'],...
%     [Mask_CommonPath, '20161214_Chang\20161214_Chang_edge.tif'],...
%     [Mask_CommonPath, '20161220_ChungChang\20161220_ChungChang_edge.tif'],...
%     [Mask_CommonPath, '20161213_ChangYun\20161213_ChangYun_edge.tif'],...
%     [Mask_CommonPath, '20161213_ChangYunChia\20161213_ChangYunChia_edge.tif'],...
%     [Mask_CommonPath, '20161213_Yun\20161213_Yun_edge.tif']};

% Save_CommonPath = 'E:\allen\data\dataset\dataset_NR_256_dir4_r0\';
% Save_CommonPath = 'E:\allen\data\dataset\dataset_NR_256_dir4_r90\';
% Save_CommonPath = 'E:\allen\data\dataset\dataset_NR_256_dir4_r180\';%  ******資料版本調整******
% Save_CommonPath = 'L:\LAB722\map\data\mask\src_mask\dataset_V2.2_Land_bird\';
    
% Setup Parameter
cut_size = 256;
step =256;
File_num = 1;
EPSG = 32650;
count = 0;
skip_counter = 0;
area_ratio = 0.1;  %  ******標記面積門檻值大小調整******

for i = 1:3
    if i == 1
        rotate = 0;
        Save_CommonPath = 'E:\allen\data\dataset\dataset_NR_256_dir4_r0\';
    elseif i == 2
        rotate = 90;
        Save_CommonPath = 'E:\allen\data\dataset\dataset_NR_256_dir4_r90\';
    else
        rotate = 180;
        Save_CommonPath = 'E:\allen\data\dataset\dataset_NR_256_dir4_r180\';
    end
    % Start Processing
    for file = 1:6
    %     if file <6
    %         continue;
    %     end
        % Read File
        fprintf('Read file：\n%s\n%s\n',Src_Path{file}, Mask_Path{file});
        [Mask, Mask_R] = geotiffread(Mask_Path{file});
        [Src, Src_R] = geotiffread(Src_Path{file});
    %     [Edge, Edge_R] = geotiffread(Edge_Path{file});

        % Get geographic information
        fprintf('Get geographic information.\n');
        Geo_info = geotiffinfo(Src_Path{file});

        % Get boundary
        Height = Geo_info.Height;
        Width = Geo_info.Width;

        % Start cut
        fprintf('Start cut.\n');
        % 改變 h / w 在for 的先後次序就能影響移動方向：垂直或者平行
    %方向3
    %     for h = 1:fix(Height / step)
    %         for w = (Width - cut_size):-1:1
    %方向4
        for w = 1:fix(Width / step)
            for h = (Height - cut_size):-1:1
                % 如果存了一張圖，及略過該張圖的區域
                if skip_counter > 0
                    skip_counter = skip_counter - 1;
                    continue;
                end
    %             fprintf("%d.h=%d, w=%d\n", file, h*256, w);

                % Get block first 方向3
    %             low_h = step * (h - 1) + 1;
    %             up_h =  low_h + cut_size - 1;
    %             low_w = w;
    %             up_w = low_w + cut_size - 1;


                % Get block first  方向4
                low_w = step * (w - 1) + 1;
                up_w =  low_w + cut_size - 1;
                low_h = h;
                up_h = low_h + cut_size - 1;

                if up_h > Height || up_w > Width
                    fprintf('Out image range.\n');
                    continue;
                end


                mask_cut = Mask( low_h : up_h, low_w : up_w);
    %             edge_cut = Edge( low_h : up_h, low_w : up_w);
                src_cut = Src( low_h : up_h, low_w : up_w, :);

    %             Check

    %             if sum(sum(sum(src_cut))) == 0
    %                 fprintf('source fail.\n');
    %                 continue;
    %             end

    %             確認邊界無黑框 V1.0
                if ~(sum(src_cut(1, 1, :))&&sum(src_cut(1, cut_size, :))&&sum(src_cut(cut_size, 1, :))&&sum(src_cut(cut_size, cut_size, :)))
    %                 fprintf('%d.source fail.\n', file);
                    continue;
                end

    %             if count == 0
    %                 continue;
    %             end

    %             50% 有禽舍 50% 無禽舍 V2.0
                if sum(sum(mask_cut))
                    ratio = length(find(mask_cut>0)) / (cut_size^2);
                    if ratio < area_ratio
                        continue;
                    end
    %                 確認標記佔全體比例是否超過門檻
                    fprintf('%d.Ratio= %f.\n', file, ratio);
                    count = count + 1;
                    fprintf('Count = %d\n', count);
                elseif sum(sum(mask_cut)) == 0 && count > 0
    %                 if count <= 0
    %                     continue;
    %                 end
                    count = count - 1;
                    fprintf('Count = %d\n', count);
                else
                    continue;
                end



    %             旋轉
                mask_cut = imrotate(mask_cut, rotate, 'bicubic'); % 逆時針為 +
                src_cut = imrotate(src_cut, rotate, 'bicubic'); % 逆時針為 +

                % Save File
                    % Change the information of geo.
                src_r = Src_R;
                src_r.XWorldLimits = [Src_R.XWorldLimits(1) + (low_w-1) * 0.5, Src_R.XWorldLimits(1) + up_w * 0.5];
                src_r.YWorldLimits = [Src_R.YWorldLimits(1) + (low_h-1) * 0.5, Src_R.YWorldLimits(1) + up_h * 0.5];
                src_r.RasterSize = [cut_size, cut_size];
                %src_r.RasterExtentInWorldX = src_r.XWorldLimits(2) - src_r.XWorldLimits(1);
                %src_r.RasterExtentInWorldY = src_r.YWorldLimits(2) - src_r.YWorldLimits(1);
                %src_r.XIntrinsicLimits = [0.5, boundary + 0.5];
                %src_r.YIntrinsicLimits = [0.5, boundary + 0.5];

                % Save the file
                fprintf('%d. Save File：%d\n', file, File_num);
                x_path = [Save_CommonPath, 'x\', int2str(File_num), '.tif'];
                y_path = [Save_CommonPath, 'y\', int2str(File_num), '.tif'];
    %             edge_path = [Save_CommonPath, 'edge\', int2str(File_num), '.tif'];

                geotiffwrite(x_path, src_cut, src_r, 'CoordRefSysCode', EPSG);
                geotiffwrite(y_path, mask_cut, src_r, 'CoordRefSysCode', EPSG);
    %             geotiffwrite(edge_path, edge_cut, src_r, 'CoordRefSysCode', EPSG);
                File_num = File_num + 1;
                skip_counter = step;

            end
        end
    end
end