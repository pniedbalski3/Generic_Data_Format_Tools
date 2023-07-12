function diff2mrd(Subj_ID,xe_file)

if nargin < 1
    [xe_file_a,xe_path] = uigetfile('*.dat','Select Diffusion Raw Data file');
    xe_file = fullfile(xe_path,xe_file_a);
    Subj_ID = inputdlg('Subject ID','Input Subject ID',[1 50]); % Or maybe better to prompt user to type in Subject ID?
    Subj_ID = Subj_ID{1};
elseif nargin < 2
    [xe_file_a,xe_path] = uigetfile('*.dat','Select Diffusion Raw Data file');
    xe_file = fullfile(xe_path,xe_file_a);
end

[~,~,fileext] = fileparts(xe_file);
if strcmp(fileext,'.dat')
    Siemens.diff_to_ismrmrd(xe_file,Subj_ID,fullfile(xe_path,[Subj_ID '_diff.h5']));
else
end
