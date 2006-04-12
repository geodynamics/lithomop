# -*- Autoconf -*-


## ---------------------------- ##
## Autoconf macros for Fortran. ##
## ---------------------------- ##


# CIT_FC_OPEN_APPEND
# ------------------
AC_DEFUN([CIT_FC_OPEN_APPEND], [
AC_LANG_PUSH(Fortran)
cit_fc_append=no
AC_MSG_CHECKING([whether $FC supports OPEN control item 'position="append"'])
AC_COMPILE_IFELSE([
    AC_LANG_PROGRAM([], [[      open(10,file="foo",status="old",position="append")]])
], [
    AC_MSG_RESULT(yes)
    FCFLAGS="-DFORTRAN_POSITION_APPEND $FCFLAGS"; export FCFLAGS
    cit_fc_append=yes
], [
    AC_MSG_RESULT(no)
])
AC_MSG_CHECKING([whether $FC supports OPEN control item 'access="append"'])
AC_COMPILE_IFELSE([
    AC_LANG_PROGRAM([], [[      open(10,file="foo",status="old",access="append")]])
], [
    AC_MSG_RESULT(yes)
    FCFLAGS="-DFORTRAN_ACCESS_APPEND $FCFLAGS"; export FCFLAGS
    cit_fc_append=yes
], [
    AC_MSG_RESULT(no)
])
AS_IF([test $cit_fc_append = yes], [], [
    AC_MSG_FAILURE([cannot determine method for appending to Fortran files])
])
AC_LANG_POP(Fortran)
])dnl CIT_FC_OPEN_APPEND


# CIT_FC_STREAM_IO
# ----------------
AC_DEFUN([CIT_FC_STREAM_IO], [
AC_LANG_PUSH(Fortran)
AC_MSG_CHECKING([whether $FC supports stream i/o])
AC_COMPILE_IFELSE([
    AC_LANG_PROGRAM([], [[      open(10,file="foo",status="new",access="stream",
     & form="unformatted")
      write(10,pos=1) 1,2,3.0d0]])
], [
    AC_MSG_RESULT(yes)
    FCFLAGS="-DFORTRAN_STREAM_IO $FCFLAGS"; export FCFLAGS
], [
        AC_MSG_RESULT(no)
        AC_MSG_CHECKING([whether $FC supports f77-style binary direct-access i/o])
        AC_COMPILE_IFELSE([
            AC_LANG_PROGRAM([], [[      open(10,file="foo",status="new",access="direct",recl=1,
     & form="unformatted")
      write(10,rec=1) 1,2,3.0d0]])
    ], [
        AC_MSG_RESULT(yes)
        FCFLAGS="-DFORTRAN_F77_IO $FCFLAGS"; export FCFLAGS
        AC_MSG_CHECKING([whether $FC supports I/O specifiers 'advance' and 'eor'])
        AC_COMPILE_IFELSE([
            AC_LANG_PROGRAM([], [[      open(10,file="foo",status="new",access="direct",recl=1,
     & form="unformatted")
      write(10,rec=1,advance='yes',eor=10) 1,2,3.0d0
 10   continue]])
        ], [
            AC_MSG_RESULT(yes)
            FCFLAGS="-DFORTRAN_EOR $FCFLAGS"; export FCFLAGS
        ], [
            AC_MSG_RESULT(no)
        ])
    ], [
        AC_MSG_RESULT(no)
        AC_MSG_WARN([cannot determine how to produce binary direct-access files with variable record length])
        FCFLAGS="-DFORTRAN_NO_BINARY $FCFLAGS"; export FCFLAGS
    ])
])
AC_LANG_POP(Fortran)
])dnl CIT_FC_STREAM_IO


dnl end of file
