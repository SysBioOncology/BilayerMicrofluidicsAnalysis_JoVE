# BilayerMicrofluidicsAnalysis_JoVE
Code used to read and analysis the fluorescent plugs data for the paper Yelleswarapu et al., Multilayer PDMS device for combinatorial plug production.

The measurements are recorded using a fluorescence microscope and recording a video of the plugs flowing throw the tube where they are collected which is fixed over the objective lens of a microscope. The analysis is performed in two steps:

1. Frames are extracted from the video and, for each frame, the average fluorescence intensity in a specified region of interest (ROI) is recorded in a csv file. This part of the analysis is performed by the Python code [extract_fluorescence.py](analysis/extract_fluorescence.py)
2. The resulting raw data are processed to distinguish different conditions (each condition is composed by a sequence of plugs from the same population) based on the empty space left by the non-fluorescent barcodind. For each condition peaks corresponding to fluorescent plugs are detected and the corresponging fluorescence is quantified. This part of the analysis is performed by the R code [peaks_analysis.R](analysis/peaks_analysis.R)

The folder also contains the necessary LabVIEW programs for operating the microfluidic device in the paper. 
It also has the CAD files for the designing the device used in the paper.
