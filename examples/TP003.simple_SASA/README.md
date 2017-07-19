# Test Problem 3: Simple SASA

### Formulation
![formulation](media/TP003_Formulation.png)

---
### Contents
The optimal solution can be calculated with high-precision (see [TP3_ClosedFormEquations](TP3_ClosedFormEquations.m)). The control-only, inner-loop solution (i.e., the optimal control for any given k) can be solved using a linear program created with a direct transcription method (see [TP3_Inner](TP3_Inner.m)). The codes to replicate the results in two DETC papers below are also available.

---
### References
* **Section 3.1** of DR Herber, JT Allison. *Unified Scaling of Dynamic Optimization Design Formulations.* In ASME 2017 International Design Engineering Technical Conferences, DETC2017-67676, Cleveland, OH, USA, Aug 2017. [[bibtex]](http://systemdesign.illinois.edu/~systemdesign/bibtexbrowser.php?key=Herber2017c&bib=esdl_refs.bib) [[pdf]](http://systemdesign.illinois.edu/publications/Her17c.pdf)

* **Section 5.3** of DR Herber, JT Allison. *Nested and Simultaneous Solution Strategies for General Combined Plant and Controller Design Problems.* In ASME 2017 International Design Engineering Technical Conferences, DETC2017-67688, Cleveland, OH, USA, Aug 2017. [[bibtex]](http://systemdesign.illinois.edu/~systemdesign/bibtexbrowser.php?key=Herber2017b&bib=esdl_refs.bib) [[pdf]](http://systemdesign.illinois.edu/publications/Her17b.pdf)