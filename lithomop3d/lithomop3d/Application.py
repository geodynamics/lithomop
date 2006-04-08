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


from pyre.applications.Script import Script as BaseScript


class Application(BaseScript):


    def main(self, *args, **kwds):
#        from time import clock as now
#        start = now()
        lm3dsetup = self.inventory.setup
        scanner = self.inventory.scanner
        try:
            lm3dsetup.initialize(scanner)
        except scanner.CanNotOpenInputOutputFilesError, error:
            import sys
            print >> sys.stderr
            error.report(sys.stderr)
            print >> sys.stderr
            print >> sys.stderr, "%s: %s" % (error.__class__.__name__, error)
            sys.exit(1)
        lm3dsetup.read()
        lm3dsetup.numberequations()
        lm3dsetup.sortmesh()
        lm3dsetup.sparsesetup()
        lm3dsetup.allocateremaining()
        lm3dsetup.meshwrite()
        lm3drun = self.inventory.solver
        lm3drun.initialize(self.inventory.scanner, self.inventory.setup)
        lm3drun.run()
#        finish = now()
#        usertime = finish - start
#        print "Total user time:  %g" % usertime
        return


    def __init__(self, name="lithomop3d"):
        BaseScript.__init__(self, name)
        return


    class Inventory(BaseScript.Inventory):

        import pyre.inventory
        from Lithomop3d_scan import Lithomop3d_scan
        from Lithomop3d_setup import Lithomop3d_setup
        from Lithomop3d_run import Lithomop3d_run

        scanner = pyre.inventory.facility("scanner", factory=Lithomop3d_scan)
        setup = pyre.inventory.facility("setup", factory=Lithomop3d_setup)
        solver = pyre.inventory.facility("solver", factory=Lithomop3d_run)
        # ksp_monitor = pyre.inventory.str("ksp_monitor",default="1")
        # ksp_view = pyre.inventory.str("ksp_view",default="1")
        # log_summary = pyre.inventory.str("log_summary",default="1")
        # log_info = pyre.inventory.str("log_info",default="0")
        # pc_type = pyre.inventory.str("pc_type",default="1")
        # start_in_debugger = pyre.inventory.str("start_in_debugger",default="0")
        # petsc_solver = pyre.inventory.str("petsc_solver",default="1")


# version
# $Id: Application.py,v 1.5 2005/04/15 00:18:21 willic3 Exp $

# End of file 
