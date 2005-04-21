# -*- Makefile -*-
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#                             Charles A. Williams
#                       Rensselaer Polytechnic Institute
#                        (C) 2005  All Rights Reserved
#
#  All worldwide rights reserved.  A license to use, copy, modify and
#  distribute this software for non-commercial research purposes only
#  is hereby granted, provided that this copyright notice and
#  accompanying disclaimer is not modified or removed from the software.
#
#  DISCLAIMER:  The software is distributed "AS IS" without any express
#  or implied warranty, including but not limited to, any implied
#  warranties of merchantability or fitness for a particular purpose
#  or any warranty of non-infringement of any current or pending patent
#  rights.  The authors of the software make no representations about
#  the suitability of this software for any particular purpose.  The
#  entire risk as to the quality and performance of the software is with
#  the user.  Should the software prove defective, the user assumes the
#  cost of all necessary servicing, repair or correction.  In
#  particular, neither Rensselaer Polytechnic Institute, nor the authors
#  of the software are liable for any indirect, special, consequential,
#  or incidental damages related to the software, to the maximum extent
#  the law permits.
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#

PROJECT = lithomop3d
PACKAGE = lithomop3dmodule
MODULE = lithomop3d

include std-pythonmodule.def
include petsc/default.def
# include local.def

PROJ_CXX_SRCLIB = -ljournal -llithomop3d
PROJ_LIBRARIES += $(LCXX_FORTRAN)

PROJ_SRCS = \
	array.cc \
	autoprestr.cc \
	bindings.cc \
	elastc.cc \
	exceptionhandler.cc \
	exceptions.cc \
	misc.cc \
	numbering.cc \
	parser.cc \
	scanner.cc \
	setup.cc \
	sorting.cc \
	sparse.cc \
	viscos.cc \
	write_modelinfo.cc


# version
# $Id: Make.mm,v 1.9 2005/04/20 23:08:02 willic3 Exp $

# Generated automatically by MakeMill on Tue Mar  2 17:05:23 2004

# End of file 
