function xebids()
%% 

Subj_ID = inputdlg('Participant ID','Input Participant ID',[1 50]); % Prompt User for Participant ID
Subj_ID = Subj_ID{1};

%Default output directory is the present working directory. Strongly
%suggest changing this.
output_dir = pwd;

sub_dir = fullfile(output_dir,['sub-' Subj_ID]);

if ~isfolder(sub_dir)
    mkdir(sub_dir);
end

Contrasts = {'Calibration','Ventilation','Diffusion','Gas Exchange'};

Files_Acquired = listdlg('PromptString',{'What Contrasts were Collected?',...
    'Use Shift-Click to select multiple options'},'ListString',Contrasts);
%%
if ismember(2,Files_Acquired)
    %define BIDS-standard name
    nii_name = ['sub-' Subj_ID '_vent'];
    
    %vent2mrd(Subj_ID);
    vent_dir = fullfile(sub_dir,'xevent');
    if ~isfolder(vent_dir)
        mkdir(vent_dir);
    end
    vent_path = uigetdir('','Select Ventilation DICOM Folder'); 
    
    dicoms = dir(vent_path);
    dicoms(1:2) = [];
    
    %write nii to vent dir
    dicm2nii(vent_path,vent_dir,1);
    vent_conv = dir(vent_dir);
    
    cell_names = struct2cell(vent_conv);
    cell_names = cell_names(1,:);
    ind = find(contains(cell_names,'.nii.gz'));
    
    movefile(fullfile(vent_conv(ind).folder,vent_conv(ind).name),fullfile(vent_dir,[nii_name '.nii.gz']));
    ind2 = find(contains(cell_names,'.json'));
    ind3 = find(contains(cell_names,'.mat'));
    
    try
        delete(fullfile(vent_conv(ind2).folder,vent_conv(ind2).name))
    catch
    end
    try
        delete(fullfile(vent_conv(ind3).folder,vent_conv(ind3).name))
    catch
    end
    json_write(fullfile(dicoms(1).folder,dicoms(1).name),fullfile(vent_dir,nii_name));
end
if ismember(3,Files_Acquired)
    %diff2mrd(Subj_ID);
    %define BIDS-standard name
    nii_name = ['sub-' Subj_ID '_xedwi'];
    
    %vent2mrd(Subj_ID);
    diff_dir = fullfile(sub_dir,'xedwi');
    if ~isfolder(diff_dir)
        mkdir(diff_dir);
    end
    diff_path = uigetdir('','Select Diffusion DICOM Folder'); 
    
    dicoms = dir(diff_path);
    dicoms(1:2) = [];
    
    %write nii to diff dir
    dicm2nii(diff_path,diff_dir,5);
    diff_conv = dir(diff_dir);
    
    cell_names = struct2cell(diff_conv);
    cell_names = cell_names(1,:);
    ind = find(contains(cell_names,'.nii.gz'));
    try
        movefile(fullfile(diff_conv(ind).folder,diff_conv(ind).name),fullfile(diff_dir,[nii_name '.nii.gz']));
    catch
        for i = 1:length(ind)
            movefile(fullfile(diff_conv(ind(i)).folder,diff_conv(ind(i)).name),fullfile(diff_dir,[nii_name '_' num2str(i) '.nii.gz']));
        end
    end
    ind2 = find(contains(cell_names,'.json'));
    ind3 = find(contains(cell_names,'.mat'));
    for i = 1:length(ind2)
        delete(fullfile(diff_conv(ind2(i)).folder,diff_conv(ind2(i)).name))
    end
    for i = 1:length(ind3)
        delete(fullfile(diff_conv(ind3(i)).folder,diff_conv(ind3(i)).name))
    end
    
    bval = [0 12];
    
    fid = fopen(fullfile(diff_dir,[nii_name '.bval']), 'w');
    fprintf(fid, '%.5g ', bval); % one row
    fclose(fid);

    json_write(fullfile(dicoms(1).folder,dicoms(1).name),fullfile(diff_dir,nii_name));
    
end
if ismember(4,Files_Acquired)
    gx2mrd(Subj_ID);
end

