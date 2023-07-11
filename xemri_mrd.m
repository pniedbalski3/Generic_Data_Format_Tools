function xemri_mrd()

Subj_ID = inputdlg('Participant ID','Input Participant ID',[1 50]); % Prompt User for Participant ID
Subj_ID = Subj_ID{1};

vent2mrd(Subj_ID);
diff2mrd(Subj_ID);
gx2mrd(Subj_ID);