This README aims to explain how to use the code \([Quickstart](#quickstart)\), then how it works.

# Quickstart

## Installation

- If you have setup the whole mondrians project (unavailable), you could go to [Use](##use).

### Modules
Clone this remote and [personalized_tools](https://github.com/tourfl/personalized_tools), that you may store in the same directory.

```
git clone git@github.com:tourfl/mondrian_factory.git  
git clone git@github.com:tourfl/personalized_tools.git
```

### Toolboxes

Then you clone the [HDR Toolbox](https://github.com/banterle/HDR_Toolbox), on your local Matlab folder (assuming this is **~/Documents/MATLAB/**), with the following command:

```
git clone https://github.com/banterle/HDR_Toolbox.git ~/Documents/MATLAB/HDR_Toolbox
```

### Pathes
Next, you copy the **startup.m** file (it assumes you have put the two repository in your Matlab folder) to your Matlab folder. It will automaticaly add the good folders to your Matlab path.

It is now installed! :camel:

## Use

All you need to modify is the **main.m** file. The parameters are the following.

- [space](##space): RGB, LMS or HDR
- [shape](##shape): Land
- [solution](##illumination): 1 to 5
- figs_on: true or false
- save_on: true or false

# Explanations

## Required toolboxes

- **HDR\_Toolbox**, I/O on PFM images, required for using PFM images

## Folders

- **data**: mainly .mat files with color matching functions, shape description, munsell colors reflectances, illuminants powerness

## Parameters

[ ] **TODO**

### Space

### Shape

### Illumination

## Coding design

This is Matlab code in an object-oriented fashion. See the UML class diagram below.

