function gx2mrd(xe_file,cal_file,ute_file,Subj_ID)

if nargin < 4
    [xe_file,xe_path] = uigetfile('*.dat','Select Gas Exchange Raw Data file');
    [cal_file,cal_path] = uigetfile('*.dat','Select Calibration Raw Data file');
    [ute_file,ute_path] = uigetfile('*.dat','Select Anatomic Raw Data file');
    Subj_ID = inputdlg('Subject ID','Input Subject ID',[1 50]); % Or maybe better to prompt user to type in Subject ID?
    Subj_ID = Subj_ID{1};
end
    
dissolved_to_ismrmrd(fullfile(xe_path,xe_file),Subj_ID,fullfile(xe_path,[Subj_ID '_dixon.h5']));
calibration_to_ismrmrd(fullfile(cal_path,cal_file),Subj_ID,fullfile(xe_path,[Subj_ID '_cali.h5']));
ute_to_ismrmrd(fullfile(ute_path,ute_file),Subj_ID,fullfile(xe_path,[Subj_ID '_ute.h5']));