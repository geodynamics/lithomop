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
      subroutine formf(
     & b,x,d,dx,skew,histry,                                             ! global
     & ien,lm,lmx,lmf,gauss,                                             ! elemnt
     & mat,infin,prop,dmat,stn,                                          ! stress
     & nfault,dfault,tfault,                                             ! split
     & s,stemp,iddmat,                                                   ! local
     & ngauss,nddmat,ndmat,nprop,numat,nsd,ndof,nstr,nen,nee,neq,numel,  ! dimens
     & numnp,numfn,numslp,numrot,nskdim,ipstrs,nstep,lgdefp,ibbarp,      ! dimens
     & nhist,lastep,idout,kto,kw,ivisc,iplas,imhist)                     ! dimens
c
c      generates forces due to faulted nodes
c
      include "implicit.inc"
c
c...  subroutine arguments
c
      integer ngauss,nddmat,ndmat,nprop,numat,nsd,ndof,nstr,nen,nee,neq
      integer numel,numnp,numfn,numslp,numrot,nskdim,ipstrs,nstep,lgdefp
      integer ibbarp,nhist,lastep,idout,kto,kw,ivisc,iplas,imhist
      integer ien(nen,numel),lm(ndof,nen,numel),lmx(ndof,nen,numel)
      integer lmf(nen,numel),mat(numel),infin(numel),nfault(3,numfn)
      double precision b(neq),x(nsd,numnp),d(ndof,numnp),dx(ndof,numnp)
      double precision skew(nskdim,numnp),histry(nhist,lastep+1)
      double precision gauss(nsd+1,ngauss),prop(nprop,numat)
      double precision dmat(nddmat,ngauss,ndmat),stn(nstr,ngauss,numel)
      double precision dfault(ndof,numfn),tfault(ndof,numfn),s(nee*nee)
      double precision stemp(nee*nee)
c
c...  included dimension and type statements
c
      include "iddmat_dim.inc"
c
c...  defined constants
c
      include "nconsts.inc"
      include "rconsts.inc"
c
c...  local variables
c
cdebug      integer idb,jdb
      integer ldtmp,io1,i,n,m,imat
      double precision p(24),dl(24),ptmp(30)
c
cdebug      write(6,*) "Hello from formf_f!"
cdebug      write(6,*) "neq, b:",neq,(b(idb),idb=1,neq)
cdebug      write(6,*) "From formf_f, ngauss,nsd,gauss: ",ngauss,nsd,
cdebug     & ((gauss(jdb,idb),jdb=1,nsd+1),idb=1,ngauss)
c
      ldtmp=lgdefp
      if(ipstrs.eq.ione.and.nstep.eq.izero) ldtmp=izero
      io1=izero
      if(ldtmp.gt.izero) io1=ione
      do i = 1,numfn
        n=nfault(1,i)
        m=mat(n)
        imat=n
        if((ivisc.eq.izero).and.(iplas.eq.izero)) imat=m
        call mathist(ptmp,prop(1,m),histry,nprop,m,nstep,nhist,lastep,
     &   idout,kto,kw,imhist)
        call formes(x,d,dx,tfault,dmat(1,1,imat),stn(1,1,n),skew,s,
     &   stemp,ptmp,gauss,ien(1,n),lmx(1,1,n),lmf(1,n),iddmat,infin(n),
     &    n,ngauss,nddmat,nprop,nsd,ndof,nstr,nen,nee,numnp,numfn,
     &    numslp,numrot,nskdim,io1,ibbarp,ldtmp,idout,kto,kw)
        call lflteq(dl,dfault(1,i),nfault(1,i),ien(1,n),nen,ndof)
	call dsymv("u",nee,one,s,nee,dl,ione,zero,p,ione)
        call addfor(b,p,lm(1,1,n),lmx(1,1,n),neq,nee)
      end do
cdebug      write(6,*) "form end of formf, b:",(b(idb),idb=1,neq)
      return
      end
c
c version
c $Id: formf.f,v 1.1 2004/06/21 20:59:05 willic3 Exp $
c
c Generated automatically by Fortran77Mill on Wed May 21 14:15:03 2003
c
c End of file 
