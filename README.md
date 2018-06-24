## README (co-design-examples-repository)

<!-- [![GitHub release](https://img.shields.io/github/release/danielrherber/co-design-examples-repository.svg)](https://github.com/danielrherber/co-design-examples-repository/releases/latest) -->
[![](https://img.shields.io/badge/language-matlab-EF963C.svg)](https://www.mathworks.com/products/matlab.html)
[![](https://img.shields.io/github/issues-raw/danielrherber/co-design-examples-repository.svg)](https://github.com/danielrherber/co-design-examples-repository/issues)
[![GitHub contributors](https://img.shields.io/github/contributors/danielrherber/co-design-examples-repository.svg)](https://github.com/danielrherber/co-design-examples-repository/graphs/contributors)

[![license](https://img.shields.io/github/license/danielrherber/co-design-examples-repository.svg)](https://github.com/danielrherber/co-design-examples-repository/blob/master/License)

This repository contains a number of combined plant and control design or *co-design* test problems.

![readme_image.svg](http://www.danielherber.com/img/projects/co-design-examples-repository/readme_image.svg)

---
### Install
- Download the [project files](https://github.com/danielrherber/co-design-examples-repository/archive/master.zip)
- Run [INSTALL_Codesign_Examples.m](INSTALL_Codesign_Examples.m) in the MATLAB Command Window *(automatically adds project files to your MATLAB path, downloads the required files, and opens an example)*
```matlab
INSTALL_Codesign_Examples
```
- See [md_18_1066_figure4m](examples/TP003.simple_SASA/md-18-1066/md_18_1066_figure4.m) and [TP3_RunAll.m](examples/TP003.simple_SASA/TP3_RunAll.m) for one of the test problems (TP3: Simple SASA)
```matlab
open md_18_1066_figure4
open TP3_ClosedFormEquations
open TP3_RunAll
```
- See the references below for some theory and results

### List of Included Test Problems
- [TP1: Scalar Plant, Scalar Control](examples/TP001.scalar_plant_scalar_control)
- [TP2: Co-Design Transfer](examples/TP002.co-design_transfer)
- [TP3: Simple SASA](examples/TP003.simple_SASA)

### Publications
The test problems (TPs) in this repository can be found in the following publications:
- **TP[1,2,3]** DR Herber, JT Allison. *Nested and Simultaneous Solution Strategies for General Combined Plant and Control Design Problems.* ASME Journal of Mechanical Design (to appear), MD-18-1066, 2018. [[bibtex]](http://systemdesign.illinois.edu/~systemdesign/bibtexbrowser.php?key=HerberX2&bib=esdl_refs.bib)
- **TP[2,3]** DR Herber, JT Allison. *Unified Scaling of Dynamic Optimization Design Formulations.* In ASME 2017 International Design Engineering Technical Conferences, DETC2017-67676, Cleveland, OH, USA, Aug 2017. [[bibtex]](http://systemdesign.illinois.edu/~systemdesign/bibtexbrowser.php?key=Herber2017c&bib=esdl_refs.bib) [[pdf]](http://systemdesign.illinois.edu/publications/Her17c.pdf)

### External Includes
See [INSTALL_Codesign_Examples.m](INSTALL_Codesign_Examples.m) for more information.
- MATLAB File Exchange Submission IDs (**23629**, **40397**, **51986**)

---
### General Information

#### Contributors
- [Daniel R. Herber](https://github.com/danielrherber) (primary)
- James T. Allison

#### Project Links
- [https://github.com/danielrherber/co-design-examples-repository](https://github.com/danielrherber/co-design-examples-repository)
- [https://www.mathworks.com/matlabcentral/fileexchange/63902](https://www.mathworks.com/matlabcentral/fileexchange/63902)