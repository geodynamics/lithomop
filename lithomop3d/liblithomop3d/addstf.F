c -*- Fortran -*-
c
c~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
c
c  Lithomop3d by Charles A. Williams
c  Copyright (c) 2003-2005 Rensselaer Polytechnic Institute
c
c  Permission is hereby granted, free of charge, to any person obtaining
c  a copy of this software and associated documentation files (the
c  "Software"), to deal in the Software without restriction, including
c  without limitation the rights to use, copy, modify, merge, publish,
c  distribute, sublicense, and/or sell copies of the Software, and to
c  permit persons to whom the Software is furnished to do so, subject to
c  the following conditions:
c
c  The above copyright notice and this permission notice shall be
c  included in all copies or substantial portions of the Software.
c
c  THE  SOFTWARE IS  PROVIDED  "AS  IS", WITHOUT  WARRANTY  OF ANY  KIND,
c  EXPRESS OR  IMPLIED, INCLUDING  BUT NOT LIMITED  TO THE  WARRANTIES OF
c  MERCHANTABILITY,    FITNESS    FOR    A   PARTICULAR    PURPOSE    AND
c  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
c  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
c  OF CONTRACT, TORT OR OTHERWISE,  ARISING FROM, OUT OF OR IN CONNECTION
c  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
c
c~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
c
c
      subroutine addstf(A,s,stemp,lm,lmx,nee,numsn,nnz)
c
c...  subroutine to add local stiffness matrix to global matrix, where
c     the global matrix is stored in modified sparse row (MSR) format.
c
      include "implicit.inc"
c
c     PETSc includes
c
#include "finclude/petsc.h"
#include "finclude/petsclog.h"
#include "finclude/petscvec.h"
#include "finclude/petscmat.h"
      Mat A
c
c...  parameter definitions
c
      include "nshape.inc"
      include "nconsts.inc"
      include "rconsts.inc"
c
c...  subroutine arguments
c
      integer nee,numsn,nnz,ierr
      integer lm(nee),lmx(nee)
      double precision s(nee,nee),stemp(nee,nee)
c
c...  intrinsic functions
c
      intrinsic abs,sign,dble
c
c... local variables
c
      integer i,j
      integer lmp(neemax),lmxpa(neemax)
      double precision signi,signj
      logical slip
c
cdebug      integer idb,jdb
c
cdebug      write(6,*) "Hello from addstf_f!"
c
      slip=.false.
      do i=1,nee
cdebug        write(6,*) "i,lm(i),s(i,i):",i,lm(i),s(i,i)
        if(lmx(i).ne.izero) slip=.true.
        lmp(i) = lm(i) - 1
        lmxpa(i) = abs(lmx(i))-1
      end do
      call MatSetValues(A, nee, lmp, nee, lmp, s, ADD_VALUES, ierr)
      if(slip) then
        do i=1,nee
          signi=sign(one,dble(lmx(i)))
          do j=1,nee
            stemp(i,j) = signi*s(i,j)
          end do
        end do
        call MatSetValues(A, nee,lmp, nee,lmxpa,stemp, ADD_VALUES, ierr)
        do i=1,nee
          do j=1,nee
            signj=sign(one,dble(lmx(j)))
            stemp(i,j) = signj*s(i,j)
          end do
        end do
        call MatSetValues(A, nee,lmxpa, nee,lmp,stemp, ADD_VALUES, ierr)
        do i=1,nee
          signi=sign(one,dble(lmx(i)))
          do j=1,nee
            signj=sign(one,dble(lmx(j)))
            stemp(i,j) = signi*signj*s(i,j)
          end do
        end do
        call MatSetValues(A,nee,lmxpa,nee,lmxpa,stemp, ADD_VALUES, ierr)
      end if
      return
      end
c
c version
c $Id: addstf.F,v 1.6 2005/04/08 00:40:28 willic3 Exp $
c
c Generated automatically by Fortran77Mill on Wed May 21 14:15:03 2003
c
c End of file 
