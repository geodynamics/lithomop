#!/usr/bin/env python
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#  Lithomop3d by Charles A. Williams
#  Copyright (c) 2003-2005 Rensselaer Polytechnic Institute
#
#  Permission is hereby granted, free of charge, to any person obtaining
#  a copy of this software and associated documentation files (the
#  "Software"), to deal in the Software without restriction, including
#  without limitation the rights to use, copy, modify, merge, publish,
#  distribute, sublicense, and/or sell copies of the Software, and to
#  permit persons to whom the Software is furnished to do so, subject to
#  the following conditions:
#
#  The above copyright notice and this permission notice shall be
#  included in all copies or substantial portions of the Software.
#
#  THE  SOFTWARE IS  PROVIDED  "AS  IS", WITHOUT  WARRANTY  OF ANY  KIND,
#  EXPRESS OR  IMPLIED, INCLUDING  BUT NOT LIMITED  TO THE  WARRANTIES OF
#  MERCHANTABILITY,    FITNESS    FOR    A   PARTICULAR    PURPOSE    AND
#  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
#  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
#  OF CONTRACT, TORT OR OTHERWISE,  ARISING FROM, OUT OF OR IN CONNECTION
#  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#

from lithomop3d.MaterialModel.MaterialModel import MaterialModel

class IsotropicLinearMaxwellViscoelastic(MaterialModel):

    def __init__(self):
        # print "Hello from IsotropicLinearMaxwellViscoelastic.__init__!"
        # print ""
        self.materialModel = 5
        self.numberProperties = 4
        self.propertyDict = {'density': None,
                             'youngsModulus': None,
                             'poissonsRatio': None,
                             'viscosity': None}
        self.propertyPosition = ['density',
                                 'youngsModulus',
                                 'poissonsRatio',
                                 'viscosity']
        self.propertyList = [0.0,
                             0.0,
                             0.0,
                             0.0]
        return

# version
# $Id: IsotropicLinearMaxwellViscoelastic.py,v 1.2 2004/08/12 16:49:07 willic3 Exp $

# End of file 
