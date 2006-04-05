## Process this file with automake to produce Makefile.in
# $Id: Makefile.am 2370 2005-09-09 19:49:10Z leif $

SUBDIRS =  examples liblithomop3d module

bin_PROGRAMS = 
if COND_EMBEDDING
    bin_PROGRAMS += pylithomop3d
    INTERPRETER = $(bindir)/pylithomop3d
else
    INTERPRETER = $(PYTHON)
endif

# lithomop3d
nobase_pyexec_PYTHON = \
	lithomop3d/Application.py \
	lithomop3d/ElementTypeDef.py \
	lithomop3d/__init__.py \
	lithomop3d/KeywordValueParse.py \
	lithomop3d/Lithomop3d_run.py \
	lithomop3d/Lithomop3d_scan.py \
	lithomop3d/Lithomop3d_setup.py \
	lithomop3d/MaterialModel/__init__.py \
	lithomop3d/MaterialModel/IsotropicLinearElastic.py \
	lithomop3d/MaterialModel/IsotropicLinearMaxwellViscoelastic.py \
	lithomop3d/MaterialModel/MaterialModel.py \
	lithomop3d/Materials.py

# pylithomop3d (liblithomop3d + lithomop3dmodule + embedded Python interpreter)
INCLUDES = -I$(top_srcdir)/lithomop3d/module -I$(PYTHON_INCDIR)
pylithomop3d_SOURCES = pylithomop3d.cc
pylithomop3d_LDADD = \
	$(top_builddir)/lithomop3d/module/liblithomop3dmodule.a \
	$(top_builddir)/lithomop3d/liblithomop3d/liblithomop3d.a
pylithomop3d$(EXEEXT): $(pylithomop3d_OBJECTS) $(pylithomop3d_DEPENDENCIES) 
	@rm -f pylithomop3d$(EXEEXT)
	$(CXXLINK) $(PYTHON_LDFLAGS) $(PYTHON_LINKFORSHARED) \
		$(pylithomop3d_LDFLAGS) $(pylithomop3d_OBJECTS) $(pylithomop3d_LDADD) \
		$(PYTHON_BLDLIBRARY) \
		$(PETSC_FORTRAN_LIB) $(PETSC_LIB) $(PETSC_CXX_LIB) \
		$(FCLIBS) \
		-ljournal \
		$(PYTHON_LIBS) $(PYTHON_MODLIBS) $(PYTHON_SYSLIBS) \
		$(LIBS) \
		$(PYTHON_LDLAST)

# applications
nodist_bin_SCRIPTS = lithomop3dapp.py
do_subst = sed \
	-e 's|[@]INTERPRETER[@]|$(INTERPRETER)|g' \
	-e 's|[@]PYTHONPATH[@]|$(PYTHONPATH)|g'
lithomop3dapp.py: $(srcdir)/applications/lithomop3dapp.py
	$(do_subst) < $(srcdir)/applications/lithomop3dapp.py > $@ || (rm -f $@ && exit 1)
	chmod +x $@
CLEANFILES = $(nodist_bin_SCRIPTS)
EXTRA_DIST = applications/lithomop3dapp.py

## end of Makefile.am
