c -*- Fortran -*-
c
c~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
c
c                             Charles A. Williams
c                       Rensselaer Polytechnic Institute
c                        (C) 2004  All Rights Reserved
c
c  Copyright 2004 Rensselaer Polytechnic Institute.
c  All worldwide rights reserved.  A license to use, copy, modify and
c  distribute this software for non-commercial research purposes only
c  is hereby granted, provided that this copyright notice and
c  accompanying disclaimer is not modified or removed from the software.
c
c  DISCLAIMER:  The software is distributed "AS IS" without any express
c  or implied warranty, including but not limited to, any implied
c  warranties of merchantability or fitness for a particular purpose
c  or any warranty of non-infringement of any current or pending patent
c  rights.  The authors of the software make no representations about
c  the suitability of this software for any particular purpose.  The
c  entire risk as to the quality and performance of the software is with
c  the user.  Should the software prove defective, the user assumes the
c  cost of all necessary servicing, repair or correction.  In
c  particular, neither Rensselaer Polytechnic Institute, nor the authors
c  of the software are liable for any indirect, special, consequential,
c  or incidental damages related to the software, to the maximum extent
c  the law permits.
c
c~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
c
c
      subroutine getshapn(xl,sh,shj,shd,shbar,det,gauss,vol,iel,nen,
     & ngauss,ierr,errstrng)
c
c...  Subroutine to compute shape functions and derivatives at
c     Gauss points.
c
c     This is a generic routine for any element type, and it uses
c     Bbar selective integration.
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
      integer iel,nen,ngauss,ierr
      character errstrng*(*)
      double precision xl(nsd,nen),sh(nsd+1,nenmax,ngaussmax)
      double precision shj(nsd+1,nenmax,ngaussmax)
      double precision shd(nsd+1,nenmax,ngaussmax),shbar(nsd+1,nenmax)
      double precision det(ngauss),gauss(nsd+1,ngaussmax),vol
c
c...  local variables
c
      integer l
      double precision xs(3,3)
c
c...compute shape function derivatives over number of strain integration
c   points, and then compute average dilatational component.
c
cdebug      write(6,*) "Hello from getshapn_f!"
cdebug      write(6,*) "iel,nen,ngauss:",iel,nen,ngauss
c
      vol=zero
      do l=1,ngauss
        call getjac(xl,xs,det(l),shj(1,1,l),nen,iel,ierr,errstrng)
        if(ierr.ne.izero) return
        call getder(det(l),sh(1,1,l),shd(1,1,l),xs,nen)
        det(l)=gauss(4,l)*det(l)
        vol=vol+det(l)
cdebug        write(6,*) "l,det,vol:",l,det(l),vol
      end do
      return
      end
c
c version
c $Id: getshapn.f,v 1.5 2004/08/12 01:29:17 willic3 Exp $
c
c Generated automatically by Fortran77Mill on Wed May 21 14:15:03 2003
c
c End of file 