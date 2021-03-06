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

#if !defined(pylithomop3d_sorting_h)
#define pylithomop3d_sorting_h

// sort elements into element families
extern char pylithomop3d_sort_elements__name__[];
extern char pylithomop3d_sort_elements__doc__[];
extern "C"
PyObject * pylithomop3d_sort_elements(PyObject *, PyObject *);

// Sort slippery nodes according to reordered elements
extern char pylithomop3d_sort_slip_nodes__name__[];
extern char pylithomop3d_sort_slip_nodes__doc__[];
extern "C"
PyObject * pylithomop3d_sort_slip_nodes(PyObject *, PyObject *);

// Sort split nodes according to reordered elements
extern char pylithomop3d_sort_split_nodes__name__[];
extern char pylithomop3d_sort_split_nodes__doc__[];
extern "C"
PyObject * pylithomop3d_sort_split_nodes(PyObject *, PyObject *);

#endif

// version
// $Id: sorting.h,v 1.2 2005/04/21 23:20:18 willic3 Exp $

// End of file
