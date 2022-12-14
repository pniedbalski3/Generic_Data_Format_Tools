# Generic_Data_Format_Tools
 Tools to write out Siemens dissolved data to MRD format
everything runs from the function "dissolved_to_ismrmd"

Built off of code written by Andrew Hahn for GE data.

I have functionality for 4 sequence versions (all that I've used at KUMC)
1) Basic 1-point Dixon using John Mugler's sequence
2) Basic 1-point Dixon + appended dissolved spectroscopy using John Mugler's sequence 
3) Spiral/Radial 1-point Dixon (Niedbalski Sequence)
4) Spiral/Radial 1-point Dixon + appended dissolved spectroscopy (Niedbalski Sequence)


(1) and (2) are currently differentiated using the sequence name stored in the twix file, as (2) is from a later version of John's code from (1). But, I suspect it may not properly read all files generically, so I'll have to go in and fix.
