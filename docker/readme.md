This is a work-in-progress Dockerfile for Lithomop.

This readme should serve as a guide to the work I've done so far, which should make it easier to build on this work in the future.

I've made some progress towards getting Lithomop to compile, but so far I have not been able to successfully compile Lithomop. If you find any errors here, or if you know how to get Lithomop to compile, please contact me at github.com/JarettBakerDunn.
---------------------
Here is a summary and explanation of the work done on the Dockerfile:

1. Use aptitude to install some required libraries. -NOTE- as far as I know, not all of the libraries required by Lithomop are available in package managers, or at least the versions available are too recent to work with Lithomop.

2. Create a user with the password set to "password", so that sudo can be used in the Dockerfile and in the container – this is needed for some other steps

3. manually install pip2.7. pip2.7 is needed to install python2.7's ez_setup utility, which is used by Lithomop

4. Set a number of environment variables needed by Lithomop

5. Manually download and install mpich2-1.0.5, which is required by PETSC, which is in turn required by Lithomop.

6. Manually download and install PETSC 2.3.3, which is required by lithomop.

7. Download, install pythia

8. Clone lithomop, along with steuptools 2.7.

9. move cit_python.m4 and ez_setup.py from /docker into the places Lithomop expects them

The files ez_setup.py and cit_python.m4 are included in the /docker directory, because they are needed to compile Lithomop but are not readily available or included in the Lithomop directory at the moment.