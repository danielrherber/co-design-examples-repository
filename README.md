## README (co-design-examples-repository)

[![GitHub release](https://img.shields.io/github/release/danielrherber/co-design-examples-repository.svg)](https://github.com/danielrherber/co-design-examples-repository/releases/latest)
[![](https://img.shields.io/badge/language-matlab-EF963C.svg)](https://www.mathworks.com/products/matlab.html)
[![](https://img.shields.io/github/issues-raw/danielrherber/co-design-examples-repository.svg)](https://github.com/danielrherber/co-design-examples-repository/issues)
[![GitHub contributors](https://img.shields.io/github/contributors/danielrherber/co-design-examples-repository.svg)](https://github.com/danielrherber/co-design-examples-repository/graphs/contributors)

[![license](https://img.shields.io/github/license/danielrherber/co-design-examples-repository.svg)](https://github.com/danielrherber/co-design-examples-repository/blob/master/License)

This repository contains a number of general combined plant and controller design or *co-design* test problems.
![readme_image.svg](http://www.danielherber.com/img/projects/co-design-examples-repository/readme_image.svg)

---
### Install
- Download the [project files](https://github.com/danielrherber/co-design-examples-repository/archive/master.zip)
- Run [INSTALL_Codesign_Examples.m](INSTALL_Codesign_Examples.m) in the MATLAB Command Window *(automatically adds project files to your MATLAB path, downloads the required files, and opens an example)*
```matlab
INSTALL_Codesign_Examples
```
- See [TP2_ClosedFormEquations.m](examples/TP002.co-design_transfer/TP2_ClosedFormEquations.m) and [DETC2017_67676_figure6.m](examples/TP002.co-design_transfer/DETC2017_67676/DETC2017_67676_figure6.m) for one of the test problems (TP2: Co-Design Transfer)
```matlab
open TP2_ClosedFormEquations
open DETC2017_67676_figure6
```
- See the references below for some theory and results

### List of Included Test Problems
- [TP1: Scalar Plant, Scalar Control](examples/TP001.scalar_plant_scalar_control)
- [TP2: Co-Design Transfer](examples/TP002.co-design_transfer)
- [TP3: Simple SASA](examples/TP003.simple_SASA)

### Publications
The test problems (TPs) in this repository can be found in the following publications:
- **TP[1,2,3]** DR Herber, JT Allison. *Nested and Simultaneous Solution Strategies for General Combined Plant and Controller Design Problems.* In ASME 2017 International Design Engineering Technical Conferences, DETC2017-67688, Cleveland, OH, USA, Aug 2017. [[bibtex]](http://systemdesign.illinois.edu/~systemdesign/bibtexbrowser.php?key=Herber2017b&bib=esdl_refs.bib) [[pdf]](http://systemdesign.illinois.edu/publications/Her17b.pdf)
- **TP[2,3]** DR Herber, JT Allison. *Unified Scaling of Dynamic Optimization Design Formulations.* In ASME 2017 International Design Engineering Technical Conferences, DETC2017-67676, Cleveland, OH, USA, Aug 2017. [[bibtex]](http://systemdesign.illinois.edu/~systemdesign/bibtexbrowser.php?key=Herber2017c&bib=esdl_refs.bib) [[pdf]](http://systemdesign.illinois.edu/publications/Her17c.pdf)

### External Includes
See [INSTALL_Codesign_Examples.m](INSTALL_Codesign_Examples.m) for more information.
- MATLAB File Exchange Submission IDs (**23629, 40397, 51986**)

---
### General Information

#### Contributors
- [Daniel R. Herber](https://github.com/danielrherber) (primary)
- James T. Allison

#### Project Links
- [https://github.com/danielrherber/co-design-examples-repository](https://github.com/danielrherber/co-design-examples-repository)
- MATLAB File Exchange link coming soon