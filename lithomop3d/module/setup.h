// -*- C++ -*-
// 
//  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
//  Lithomop3d by Charles A. Williams
//  Copyright (c) 2003-2005 Rensselaer Polytechnic Institute
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE  SOFTWARE IS  PROVIDED  "AS  IS", WITHOUT  WARRANTY  OF ANY  KIND,
//  EXPRESS OR  IMPLIED, INCLUDING  BUT NOT LIMITED  TO THE  WARRANTIES OF
//  MERCHANTABILITY,    FITNESS    FOR    A   PARTICULAR    PURPOSE    AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE,  ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// 

#if !defined(pylithomop3d_setup_h)
#define pylithomop3d_setup_h

// Initialize PETSc
extern char pylithomop3d_petsc_initialize__doc__[];
extern char pylithomop3d_petsc_initialize__name__[];
extern "C"
PyObject * pylithomop3d_petsc_initialize(PyObject *, PyObject *);

// Finalize PETSc
extern char pylithomop3d_petsc_finalize__doc__[];
extern char pylithomop3d_petsc_finalize__name__[];
extern "C"
PyObject * pylithomop3d_petsc_finalize(PyObject *, PyObject *);

// Setup PETSc Logging
extern char pylithomop3d_setup_petsc_logging__doc__[];
extern char pylithomop3d_setup_petsc_logging__name__[];
extern "C"
PyObject * pylithomop3d_setup_petsc_logging(PyObject *, PyObject *);

// Initialize material model info
extern char pylithomop3d_matmod_def__name__[];
extern char pylithomop3d_matmod_def__doc__[];
extern "C"
PyObject * pylithomop3d_matmod_def(PyObject *, PyObject *);

// Precompute shape function info
extern char pylithomop3d_preshape__name__[];
extern char pylithomop3d_preshape__doc__[];
extern "C"
PyObject * pylithomop3d_preshape(PyObject *, PyObject *);

#endif

// version
// $Id: setup.h,v 1.3 2005/03/31 23:27:58 willic3 Exp $

// End of file
