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

#if !defined(pylithomop3d_scanner_h)
#define pylithomop3d_scanner_h

// scan boundary condition file
extern char pylithomop3d_scan_bc__name__[];
extern char pylithomop3d_scan_bc__doc__[];
extern "C"
PyObject * pylithomop3d_scan_bc(PyObject *, PyObject *);

// scan connectivity file
extern char pylithomop3d_scan_connect__name__[];
extern char pylithomop3d_scan_connect__doc__[];
extern "C"
PyObject * pylithomop3d_scan_connect(PyObject *, PyObject *);

// scan coordinates file
extern char pylithomop3d_scan_coords__name__[];
extern char pylithomop3d_scan_coords__doc__[];
extern "C"
PyObject * pylithomop3d_scan_coords(PyObject *, PyObject *);

// scan differential forces file
extern char pylithomop3d_scan_diff__name__[];
extern char pylithomop3d_scan_diff__doc__[];
extern "C"
PyObject * pylithomop3d_scan_diff(PyObject *, PyObject *);

// scan time step output info file
extern char pylithomop3d_scan_fuldat__name__[];
extern char pylithomop3d_scan_fuldat__doc__[];
extern "C"
PyObject * pylithomop3d_scan_fuldat(PyObject *, PyObject *);

// scan time history definition file
extern char pylithomop3d_scan_hist__name__[];
extern char pylithomop3d_scan_hist__doc__[];
extern "C"
PyObject * pylithomop3d_scan_hist(PyObject *, PyObject *);

// scan prestress file
// extern char pylithomop3d_scan_prestr__name__[];
// extern char pylithomop3d_scan_prestr__doc__[];
// extern "C"
// PyObject * pylithomop3d_scan_prestr(PyObject *, PyObject *);

// scan local coordinate rotations file
extern char pylithomop3d_scan_skew__name__[];
extern char pylithomop3d_scan_skew__doc__[];
extern "C"
PyObject * pylithomop3d_scan_skew(PyObject *, PyObject *);

// scan slippery node definitions file
extern char pylithomop3d_scan_slip__name__[];
extern char pylithomop3d_scan_slip__doc__[];
extern "C"
PyObject * pylithomop3d_scan_slip(PyObject *, PyObject *);

// scan split node definitions file
extern char pylithomop3d_scan_split__name__[];
extern char pylithomop3d_scan_split__doc__[];
extern "C"
PyObject * pylithomop3d_scan_split(PyObject *, PyObject *);

// scan time step group info file
extern char pylithomop3d_scan_timdat__name__[];
extern char pylithomop3d_scan_timdat__doc__[];
extern "C"
PyObject * pylithomop3d_scan_timdat(PyObject *, PyObject *);

// scan traction boundary conditions file
// extern char pylithomop3d_scan_traction__name__[];
// extern char pylithomop3d_scan_traction__doc__[];
// extern "C"
// PyObject * pylithomop3d_scan_traction(PyObject *, PyObject *);

// scan winkler forces info file
extern char pylithomop3d_scan_wink__name__[];
extern char pylithomop3d_scan_wink__doc__[];
extern "C"
PyObject * pylithomop3d_scan_wink(PyObject *, PyObject *);

// scan winkler forces info file for slippery nodes
extern char pylithomop3d_scan_winkx__name__[];
extern char pylithomop3d_scan_winkx__doc__[];
extern "C"
PyObject * pylithomop3d_scan_winkx(PyObject *, PyObject *);

#endif

// version
// $Id: scanner.h,v 1.3 2005/03/31 23:27:58 willic3 Exp $

// End of file
