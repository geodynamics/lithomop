#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.
# $Id: configure.ac,v 1.1 2005/08/24 22:45:51 leif Exp $

AC_PREREQ(2.59)
AC_INIT([Lithomop3d], [0.7.3], [cig-short@geodynamics.org])
AC_CONFIG_AUX_DIR([./aux-config])
AC_CONFIG_SRCDIR([lithomop3d/applications/lithomop3dapp.py])
AC_CONFIG_HEADER([portinfo])
AC_CONFIG_MACRO_DIR([m4])
AM_INIT_AUTOMAKE([foreign])

# 'configure' options
AC_ARG_VAR(PYTHON, [Python interpreter])
AC_ARG_VAR(PYTHONPATH, [Python module search path])
AC_ARG_WITH([embedding],
    [AC_HELP_STRING([--with-embedding],
        [embed Python with Lithomop in a single executable @<:@default=yes@:>@])],
    [want_embedding="$withval"],
    [want_embedding=yes])
AM_CONDITIONAL([COND_EMBEDDING], [test "$want_embedding" = yes])

# Check for Python.
AM_PATH_PYTHON([2.3])
CIT_PYTHON_SYSCONFIG

# Check for Python modules and packages.
CIT_PYTHON_EGG_SETUP

# Check for PETSc.
CIT_PATH_PETSC([2.3.3])
CC=$PETSC_CC
if test -z "$FC"; then
    AC_PATH_PROG(FC, $PETSC_FC, $PETSC_FC)
    test -z "$FC" && AC_MSG_FAILURE([Fortran compiler $PETSC_FC (used to configure PETSc) not found in \$PATH])
else
    want_FC=$FC; unset FC
    AC_PATH_PROG(FC, $want_FC, $want_FC)
    test -z "$FC" && AC_MSG_FAILURE([Fortran compiler $want_FC not found in \$PATH])
fi

# Checks for programs.
AC_PROG_CXX
AC_PROG_FC
F77=$FC
FFLAGS=$FCFLAGS
AC_PROVIDE([AC_PROG_F77])
AC_FC_WRAPPERS
AC_PROG_LIBTOOL

# Set the language for the PETSc tests.
AC_LANG(C++)

# Checks for libraries.
CIT_CHECK_LIB_PETSC

# Checks for header files.
CIT_HEADER_PETSC

# Checks for typedefs, structures, and compiler characteristics.
CIT_FC_OPEN_APPEND
CIT_FC_STREAM_IO


# Checks for library functions.

AC_CONFIG_FILES([Makefile
                 lithomop3d/Makefile
                 lithomop3d/examples/Makefile
                 lithomop3d/liblithomop3d/Makefile
                 lithomop3d/module/Makefile])
AC_OUTPUT

dnl end of configure.ac
