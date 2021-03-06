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
      subroutine shapql(r,x,det,sh,ien,nen,nsd,infin,iopt,n,idout,kto,
     & kw)
c
c...program to compute shape functions for a trilinear hexahedron
c
c        r,s,t                         = natural coordinates
c        sh(1,nen),sh(2,nen),sh(3,nen) = x,y,and z derivatives
c                                          of shape functions
c        sht(nsd)                      = intermediate storage for sh
c        sh(4,nen)                     = shape functions
c*       shi(nsd+1,nen)                = infinite element shape
c*                                       functions and derivatives
c        xs(nsd,nsd)                   = jacobian matrix
c        det                           = jacobian matrix
c        x(nsd,nen)                    = local nodal coordinates
c
c         ** note: Collapse of nodes is no longer supported.
c
      include "implicit.inc"
      integer nen,nsd,infin,iopt,n,idout,kto,kw
      integer ien(nen)
      real*8 r(nsd+1),x(nsd,nen),det,sh(4,8)
c
      integer izero,ione,ifour,i
      integer idiv(3),io(3)
      real*8 zero,one,rr,ss,tt,drr,dss,dtt
      real*8 a11,a12,a13,a21,a22,a23,a31,a32,a33,detinv
      real*8 xs(3,3),sht(3),ra(8),sa(8),ta(8),shi(4,8)
c
cdebug      integer idb,jdb
c
      data izero,ione,ifour/0,1,4/
      data idiv/1,10,100/
      data zero,one/0.0,1.0/
      data ra/-1.0, 1.0, 1.0,-1.0,-1.0, 1.0, 1.0,-1.0/
      data sa/-1.0,-1.0, 1.0, 1.0,-1.0,-1.0, 1.0, 1.0/
      data ta/ 1.0, 1.0, 1.0, 1.0,-1.0,-1.0,-1.0,-1.0/
c
c...compute shape functions and their derivatives in natural
c   coordinates for a brick
c
cdebug      write(6,*) "Hello from shapql_f!"
cdebug      write(6,*) "nen,nsd,infin,iopt,n,idout,kto,kw: ",nen,nsd,infin,
cdebug     & iopt,n,idout,kto,kw
cdebug      write(6,*) "r: ",(r(idb),idb=1,nsd+1)
cdebug      write(6,*) "x: ",((x(idb,jdb),idb=1,nsd),jdb=1,nen)
cdebug      write(6,*) "ien: ",(ien(idb),idb=1,nen)
      do i=1,nen
        rr=one+ra(i)*r(1)
        ss=one+sa(i)*r(2)
        tt=one+ta(i)*r(3)
        sh(4,i)=0.125*rr*ss*tt
        sh(1,i)=0.125*ra(i)*ss*tt
        sh(2,i)=0.125*sa(i)*rr*tt
        sh(3,i)=0.125*ta(i)*rr*ss
      end do
      call dcopy(nen*(nsd+1),sh,ione,shi,ione)
cdebug      write(6,*) "shi: ",((shi(idb,jdb),idb=1,nsd+1),jdb=1,nen)
c
c...if element is an infinite domain element, compute alternate shape
c   functions
c
      if(infin.ne.izero) then
        call fill(shi,zero,nen*(nsd+1))
        io(3)=infin/idiv(3)
        io(2)=(infin-io(3)*idiv(3))/idiv(2)
        io(1)=infin-io(3)*idiv(3)-io(2)*idiv(2)
        do i=1,nen
          call infel(r(1),ra(i),rr,drr,io(1))
          call infel(r(2),sa(i),ss,dss,io(2))
          call infel(r(3),ta(i),tt,dtt,io(3))
          shi(4,i)=rr*ss*tt
          shi(1,i)=drr*ss*tt
          shi(2,i)=dss*rr*tt
          shi(3,i)=dtt*rr*ss
        end do
      end if
c
c...calculate jacobian matrix for (x,y,z) to (r,s,t) transformation
c
      call dgemm("n","t",nsd,nsd,nen,one,shi,ifour,x,nsd,zero,xs,nsd)
cdebug      write(6,*) "xs: ",((xs(idb,jdb),idb=1,nsd),jdb=1,nsd)
c
c...form determinant of jacobian matrix and check for error condition
c   return if derivatives aren't needed
c
      det=xs(1,1)*xs(2,2)*xs(3,3)+xs(1,2)*xs(2,3)*xs(3,1)+xs(1,3)
     & *xs(2,1)*xs(3,2)-xs(1,3)*xs(2,2)*xs(3,1)-xs(1,2)*xs(2,1)
     & *xs(3,3)-xs(1,1)*xs(2,3)*xs(3,2)
      if(det.le.zero) goto 1000
      if(iopt.eq.1) return
c
c...transform natural derivatives to (x,y,z) derivatives using an
c   explicit 3x3 matrix inversion routine
c
      a11 = (xs(2,2)*xs(3,3))-(xs(2,3)*xs(3,2))
      a12 =-(xs(1,2)*xs(3,3))+(xs(1,3)*xs(3,2))
      a13 = (xs(1,2)*xs(2,3))-(xs(1,3)*xs(2,2))
      a21 =-(xs(2,1)*xs(3,3))+(xs(2,3)*xs(3,1))
      a22 = (xs(1,1)*xs(3,3))-(xs(1,3)*xs(3,1))
      a23 =-(xs(1,1)*xs(2,3))+(xs(1,3)*xs(2,1))
      a31 = (xs(2,1)*xs(3,2))-(xs(2,2)*xs(3,1))
      a32 =-(xs(1,1)*xs(3,2))+(xs(1,2)*xs(3,1))
      a33 = (xs(1,1)*xs(2,2))-(xs(1,2)*xs(2,1))
      detinv=one/det
      do i=1,nen
        sht(1)=sh(1,i)*detinv
        sht(2)=sh(2,i)*detinv
        sht(3)=sh(3,i)*detinv
        sh(1,i)=a11*sht(1)+a12*sht(2)+a13*sht(3)
        sh(2,i)=a21*sht(1)+a22*sht(2)+a23*sht(3)
        sh(3,i)=a31*sht(1)+a32*sht(2)+a33*sht(3)
      end do
c
      return
 1000 if(idout.gt.1) write(kw,2000) det,n
      write(kto,2000) det,n
 2000 format(///' shape function fails!   determinant is ',1pe20.4,
     & '  in element # ',i7)
      stop
      end
c
c version
c $Id: shapql.f,v 1.1 2004/06/15 20:03:35 willic3 Exp $
c
c Generated automatically by Fortran77Mill on Wed May 21 14:15:03 2003
c
c End of file 
