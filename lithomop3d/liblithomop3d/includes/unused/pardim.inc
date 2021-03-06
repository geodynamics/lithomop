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
c...  pardim.inc:  A header that describes the data type and dimensions
c     of arrays containing parameters for the program TECTON.  This
c     header should be included for the main calling routines of the
c     code.
c
c...  arrays containing parameters
c
      integer ncodat(2),nconsts(4),ndimens(11),iddmat(6,6),npar(11)
      integer nprint(3),nrdimens(2),nsiter(5),nsysdat(16)
      integer ntimdat(11),nunits(7),nvisdat(7)
      logical ltimdat(4)
      character title*(100),files(21)*(100)
      character labelc(3)*4,labeld(6)*4,labels(6)*4,labelp(30)*4
      character elmlbl*40
      real*8 rconsts(7),gtol(3),gcurr(3),gprev(3),gi(3),rgiter(3)
      real*8 rmult(3),rmin(3),rtimdat(3),cscal(3),wscal(3),wxscal(3)
      real*8 grav(3),tscal,prscal(6)
c
c...  scalar parameters associated with arrays
c
      integer icode,idebug
      integer izero,ione,itwo,ithree
      integer nsd,ndof,nstr,nen,ngem,ngemd,nddmat,nskdim,nsdim,npdim,
     & npdir
      integer numel,numat,ipoint,numpr,nsout,numslp,numfn,ngstn,ndmat,
     & ipstrs,nppts
      integer icontr,idout,idsk
      integer numbc,nsforc
      integer nsol,ipcg,nstore,nstorf,maxcg
      integer iword,mtot,numnp,neq,nnz,nee,nec,numrot,nprestr,numsn,
     & numflt,nprop,nwink,nwinkx,nemax,iskopt
      integer nstep,maxitp,maxitcp,lgdefp,ibbarp,itmaxp,nittot,nrftot,
     & ndtot,ivisc,iplas
      integer kti,kto,kr,kw,kp,kss,ksf
      integer ncycle,nintg,numout,nfout,nxout,lastep,nhist
      logical reform,visc,plas,mhist
      real*8 zero,one,two,three,third,root3,g
      real*8 stol,dtol,epert
      real*8 rmultd,rmultf,rmulte
      real*8 rmind,rminf,rmine
      real*8 deltp,alfap,tpois
      real*8 cscalx,cscaly,cscalz
      real*8 wscalx,wscaly,wscalz
      real*8 wxscalx,wxscaly,wxscalz
      real*8 gravx,gravy,gravz
      real*8 prscalxx,prscalyy,prscalzz,prscalxy,prscalxz,prscalyz
c
c version
c $Id: pardim.inc,v 1.1 2004/07/05 18:35:49 willic3 Exp $
c
c Generated automatically by Fortran77Mill on Wed May 21 21:38:38 2003
c
c End of file 
