# Specifications for the Generation of Xenon MRI MRD Files
## Image Acquisition
MRD conversion is intended to be used for images acquired according to 129Xe MRI Clinical Trials Consortium Recommendations: https://onlinelibrary.wiley.com/doi/full/10.1002/mrm.28985
## Naming Conventions
For each conversion, the user is prompted to enter the participant ID. Based on this participant ID, files are generated in the format:
- ParticipantID_Suffix.h5
  
The suffixes used are as follows:
- Ventilation Image: **vent**
- Anatomic Image for Ventilation: **ventanat**
- Diffusion Image: **diff**
- Calibration Image: **calibration**
- Gas Exchange Image: **dixon**
- Anatomic Image for Gas Exchange: **proton**
## Scan date information
Scan Date should be included in files. A separate script (deid_mrd.m) can be used to remove scan date in order to have fully deidentified raw data files.
## Metadata common to all files
In order to facilitate reconstruction and analysis of images, the following metadata is included in the header of all generated MRD files:
- **Nominal Field strength (in units of 1H resonance frequency)**: header.experimentalConditions.H1resonanceFrequency_Hz
- **Actual Field strength (in units of T)**: header.acquisitionSystemInformation.systemFieldStrength_T
- **Number of receive Channels**: header.acquisitionSystemInformation.receiverChannels (typically 1 for ventilation imaging)
- **Scanner Information: vendor**: header.acquisitionSystemInformation.systemVendor
- **Scanner Information: Model**: header.acquisitionSystemInformation.systemModel
- **Location (Site) of data acquisition**: header.acquisitionSystemInformation.institutionName
- **Study date**: header.studyInformation.studyDate
- **Participant ID**: header.subjectInformation.patientID
- **Encoded k-space, trajectory type (Cartesian for ventilation)**: header.encoding.trajectory
- **Encoded k-space, FOV in x direction**: header.encoding.encodedSpace.fieldOfView_mm.x
- **Encoded k-space, FOV in y direction**: header.encoding.encodedSpace.fieldOfView_mm.y
- **Encoded k-space, FOV in z direction**: header.encoding.encodedSpace.fieldOfView_mm.z
- **Encoded k-space, Matrix Size in x direction**: header.encoding.encodedSpace.matrixSize.x
- **Encoded k-space, Matrix Size in y direction**: header.encoding.encodedSpace.matrixSize.y
- **Encoded k-space, Matrix Size in z direction**: header.encoding.encodedSpace.matrixSize.z
- **Reconstructed k-space, FOV in x direction**: header.encoding.reconSpace.fieldOfView_mm.x
- **Reconstructed k-space, FOV in y direction**: header.encoding.reconSpace.fieldOfView_mm.y
- **Reconstructed k-space, FOV in z direction**: header.encoding.reconSpace.fieldOfView_mm.z
- **Limits of encoding, k-space points acquired per line, minimum value**: header.encoding.encodingLimits.kspace_encoding_step_0.minimum
- **Limits of encoding, k-space points acquired per line, maximum value**: header.encoding.encodingLimits.kspace_encoding_step_0.maximum
- **Limits of encoding, k-space points acquired per line, center value**: header.encoding.encodingLimits.kspace_encoding_step_0.center
- **Limits of encoding, lines acquired, minimum value**: header.encoding.encodingLimits.kspace_encoding_step_1.minimum
- **Limits of encoding, lines acquired, maximum value**: header.encoding.encodingLimits.kspace_encoding_step_1.maximum
- **Limits of encoding, lines acquired, center value**: header.encoding.encodingLimits.kspace_encoding_step_1.center
- **Limits of encoding, slices acquired, minimum value**: header.encoding.encodingLimits.slice.minimum
- **Limits of encoding, slices acquired, maximum value**: header.encoding.encodingLimits.slice.maximum
- **Limits of encoding, slices acquired, center value**: header.encoding.encodingLimits.slice.center
- **Limits of encoding, contrasts acquired, minimum value**: header.encoding.encodingLimits.contrast.minimum (not typically used for ventilation imaging) 
- **Limits of encoding, contrasts acquired, maximum value**: header.encoding.encodingLimits.contrast.maximum (not typically used for ventilation imaging) 
- **Limits of encoding, contrasts acquired, center value**: header.encoding.encodingLimits.contrast.center (not typically used for ventilation imaging) 
- **Limits of encoding, repetitions acquired, minimum value**: header.encoding.encodingLimits.repetition.minimum (not typically used for ventilation imaging) 
- **Limits of encoding, repetitions acquired, maximum value**: header.encoding.encodingLimits.repetition.maximum (not typically used for ventilation imaging) 
- **Limits of encoding, repetitions acquired, center value**: header.encoding.encodingLimits.repetition.center (not typically used for ventilation imaging)

## File Contents
### Ventilation (ParticipantID_vent.h5)
Ventilation images require only k-space data and looping variables to be stored in the file:
- **acquired line** is stored in the looping variable kspace_encode_step_1
- **acquired partition** (for 3D acquisition) is stored in the looping variable kspace_encode_step_2
- **acquired slice** is stored in the looping variable slice
- **Average** is stored in average (not used for standard ventilation imaging)
- **Phase** is stored in phase (not used for standard ventilation imaging)
- **Set** is stored in set (not used for standard ventilation imaging)
- **Segment** is stored in segment (not used for standard ventilation imaging)
- **Repetition** is stored in repetition (not used for standard ventilation imaging)
- **Contrast** is stored in contrast (not used for standard ventilation imaging)

**Other Flags:**
- The first acquisition in each slice, encode_step_1, repetition should be flagged
- The last acquisition in each slice, encode_step_1, repetition should be flagged

### Ventilation Anatomic Image (ParticipantID_ventanat.h5)
This file is generated and has the same looping and metadata information as the ventilation file.

### Diffusion (ParticipantID_diff.h5)
This file is generated and has the same looping and metadata information as ventilation, with the following exceptions:
- bvalue looping is stored under contrast
- the bvalue for each acquired line is stored in acqblock.head.user_float(1,line)

### Calibration and Gas Exchange Specifications can be found at the 129Xe MRI Clinical Trials Consortium Page:
https://github.com/Xe-MRI-CTC/xemrd-specification


