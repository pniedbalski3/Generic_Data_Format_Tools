function vent2mrd(xe_file,anat_file,Subj_ID)

if nargin < 3
    [xe_file,xe_path] = uigetfile('*.dat','Select Ventilation Raw Data file');
    [anat_file,anat_path] = uigetfile('*.dat','Select Ventilation Anatomic Raw Data file');
    Subj_ID = inputdlg('Subject ID','Input Subject ID',[1 50]); % Or maybe better to prompt user to type in Subject ID?
    Subj_ID = Subj_ID{1};
end
    
gre_to_ismrmrd(fullfile(xe_path,xe_file),Subj_ID,fullfile(xe_path,[Subj_ID '_vent.h5']));
gre_to_ismrmrd(fullfile(anat_path,anat_file),Subj_ID,fullfile(anat_path,[Subj_ID '_ventanat.h5']));
