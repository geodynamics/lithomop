#!/usr/bin/env python
# 
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#                             Charles A. Williams
#                       Rensselaer Polytechnic Institute
#             Copyright (C) 2006 Rensselaer Polytechnic Institute
#
# 
#       Permission is hereby granted, free of charge, to any person
#       obtaining a copy of this software and associated documentation
#       files (the "Software"), to deal in the Software without
#       restriction, including without limitation the rights to use,
#       copy, modify, merge, publish, distribute, sublicense, and/or
#       sell copies of the Software, and to permit persons to whom the
#       Software is furnished to do so, subject to the following
#       conditions:
# 
#       The above copyright notice and this permission notice shall be
#       included in all copies or substantial portions of the Software.
# 
#       THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#       EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
#       OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
#       NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
#       HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
#       WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
#       FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
#       OTHER DEALINGS IN THE SOFTWARE.
#         
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 

from pyre.simulations.Solver import Solver as SolverBase


class SolverQS(SolverBase):
"""Quasi-static solver based on Pyre Solver class."""

  class Inventory(SolverQS.Inventory):
    """Inventory for SolverQS class."""

    def initialize(self, app):
        self._loopInfo.log("initializing solver '%s'" % self.name)
        return


    def launch(self, app):
        self._loopInfo.log("launching solver '%s'" % self.name)
        return


    def newStep(self, t, step):
        self.t = t
        self.step = step
        self._loopInfo.log(
            "%s: step %d: starting with t = %s" % (self.name, self.step, self.t))
        return


    def applyBoundaryConditions(self):
        self._loopInfo.log(
            "%s: step %d: applying boundary conditions" % (self.name, self.step))
        return


    def stableTimestep(self, dt):
        self._loopInfo.log(
            "%s: step %d: stable timestep dt = %s" % (self.name, self.step, dt))
        return dt


    def advance(self, dt):
        self._loopInfo.log(
            "%s: step %d: advancing the solution by dt = %s" % (self.name, self.step, dt))
        return


    def publishState(self, directory):
        self._monitorInfo.log(
            "%s: step %d: publishing monitoring information at t = %s in '%s'" % 
            (self.name, self.step, self.t, directory))
        return


    def plotFile(self, directory):
        self._loopInfo.log(
            "%s: step %d: visualization information at t = %s in '%s'" % 
            (self.name, self.step, self.t, directory))
        return


    def checkpoint(self, filename):
        self._loopInfo.log(
            "%s: step %d: checkpoint at t = %s in '%s'" % (self.name, self.step, self.t, filename))
        return


    def endTimestep(self, t):
        self._loopInfo.log(
            "%s: step %d: end of timestep at t = %s" % (self.name, self.step, t))
        return


    def endSimulation(self, steps, t):
        self._loopInfo.log(
            "%s: end of timeloop: %d timesteps, t = %s" % (self.name, steps, t))
        return


    def __init__(self, name, facility=None):
        if facility is None:
            facility = "solver"
            
        Component.__init__(self, name, facility)
        
        import journal
        self._loopInfo = journal.debug("%s.timeloop" % name)
        self._monitorInfo = journal.debug("%s.monitoring" % name)

        from pyre.units.time import second
        self.t = 0.0 * second

        self.step = 0

        return


# version
__id__ = "$Id: SolverQS.py,v 1.1.1.1 2005/03/08 16:13:46 aivazis Exp $"

#
# End of file