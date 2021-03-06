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
      subroutine plinpyr(sh,gauss,nen,ngauss,intord)
c
c... Subroutine to compute shape functions in natural coordinates,
c    integration points, and weights for a linear pyramid.
c
      include "implicit.inc"
c
c...  parameter definitions
c
      include "ndimens.inc"
      include "nshape.inc"
      include "nconsts.inc"
      include "rconsts.inc"
c
c...  subroutine arguments
c
      integer nen,ngauss,intord
      double precision sh(nsd+1,nen,ngauss)
      double precision gauss(nsd+1,ngauss)
c
c...  local constants
c
      double precision c1,c2,c3,c4,c5,c6
      parameter(c1 = 128.0d0,
     &          c2 =  27.0d0,
     &          c3 =  15.0d0,
     &          c4 =  81.0d0,
     &          c5 = 100.0d0,
     &          c6 = 125.0d0)
c
      double precision r(5),s(5),t(5)
      data r/-1d0, 1d0, 1d0,-1d0, 0d0/
      data s/-1d0,-1d0, 1d0, 1d0, 0d0/
      data t/-1d0,-1d0,-1d0,-1d0, 1d0/
c
c...  intrinsic functions
c
      intrinsic sqrt
c
c...  user-defined functions
c
c
c...  local variables
c
      integer i,l,nshsize,ngssize
      double precision rr,ss,tt,g1,w1
c
c...  definitions
c
      nshsize=(nsd+1)*nen*ngauss
      ngssize=(nsd+1)*ngauss
c
c...  Linear wedge definition
c
      gauss(1,1)=zero
      gauss(2,1)=zero
      gauss(3,1)=-half
      gauss(4,1)=c1/c2
      if(intord.ne.2) then
        g1=eight*sqrt(two/c3)/five
        w1=c4/c5
        do l=1,ngauss
          gauss(1,l)=r(l)*g1
          gauss(2,l)=s(l)*g1
          gauss(3,l)=-(two*third)
          gauss(4,l)=w1
        end do
        gauss(3,5)=two/five
        gauss(4,5)=c6/c2
      end if
c
      do l=1,ngauss
        do i=1,nen
          rr=half*(one+r(i)*gauss(1,l))
          ss=half*(one+s(i)*gauss(2,l))
          tt=half*(one-t(i)*gauss(3,l))
          sh(4,i,l)=rr*ss*tt
          sh(1,i,l)=r(i)*ss*tt
          sh(2,i,l)=s(i)*rr*tt
          sh(3,i,l)=t(i)*rr*ss
        end do
      end do
c
      return
      end
c
c version
c $Id: plinpyr.f,v 1.4 2005/03/22 04:45:54 willic3 Exp $
c
c Generated automatically by Fortran77Mill on Wed May 21 14:15:03 2003
c
c End of file 
