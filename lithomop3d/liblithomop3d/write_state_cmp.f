c -*- Fortran -*-
c
c ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
c
c                             Charles A. Williams
c                       Rensselaer Polytechnic Institute
c                        (C) 2005  All Rights Reserved
c
c 
c 	  All worldwide rights reserved.  A license to use, copy, modify and
c         distribute this software for non-commercial research purposes only
c         is hereby granted, provided that this copyright notice and
c         accompanying disclaimer is not modified or removed from the software.
c     
c         DISCLAIMER:  The software is distributed "AS IS" without any express
c         or implied warranty, including but not limited to, any implied
c         warranties of merchantability or fitness for a particular purpose
c         or any warranty of non-infringement of any current or pending patent
c         rights.  The authors of the software make no representations about
c         the suitability of this software for any particular purpose.  The
c         entire risk as to the quality and performance of the software is with
c         the user.  Should the software prove defective, the user assumes the
c         cost of all necessary servicing, repair or correction.  In
c         particular, neither Rensselaer Polytechnic Institute, nor the authors
c         of the software are liable for any indirect, special, consequential,
c         or incidental damages related to the software, to the maximum extent
c         the law permits.
c
c ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
c
c
      subroutine write_state_cmp(
     & state,dstate,nelfamily,nstate,ielg,                              ! elemfamily
     & get_state,                                                       ! materl
     & ngauss,                                                          ! eltype
     & delti,nstep,                                                     ! timdat
     & istatout,istatoutc,nstatout,nstatestot,nout,npts,                ! ioopts
     & idout,idsk,iucd,kw,kp,kucd)                                      ! ioinfo
c
c...  computation routine to update state variables within an element family
c
      include "implicit.inc"
c
c...  parameter definitions
c
      include "materials.inc"
      include "nconsts.inc"
      include "rconsts.inc"
c
c...  subroutine arguments
c
      integer nelfamily,nstate,ielg,ngauss,nstep,nstatestot,nout,npts
      integer idout,idsk,iucd,kw,kp,kucd
      integer istatout(nstatesmax,3),istatoutc(nstatestot),nstatout(3)
      double precision state(nstate,ngauss,nelfamily)
      double precision dstate(nstate,ngauss,nelfamily)
      double precision delti
c
c...  external routines
c
      external get_state
c
c...  included dimension and type statements
c
      include "labels_dim.inc"
c
c...  local constants
c
      integer npage
      data npage/50/
c
c...  local variables
c
      integer ielga,ielgp,ielf,j,l
      double precision sout(3*nstatesmax)
c
c...  included variable definitions
c
      include "labels_def.inc"
c
      ielga=ielg
      ielgp=ielg
c
c...  output to human-readable ascii file
c
      if(idout.gt.1) then
        do ielf=1,nelfamily
          do l=1,ngauss
            nout=nout+ione
            call get_state(state,dstate,sout,nstate)
            call daxpy(nstatesmax,delti,sout(nstatesmax+ione),ione,
     &       sout(2*nstatesmax+ione),ione)
            if(nout.eq.1.or.mod(nout,npage).eq.izero) then
              write(kw,700) (labels(istatoutc(j)),j=1,nstatestot)
              write(kw,"(/)")
            end if
            write(kw,710) ielg,l,(sout(istatoutc(j)),j=1,nstatestot)
          end do
          ielga=ielga+ione
        end do
      end if
c
c...  output to ascii plot file
c
      if(idsk.eq.1) then
        do ielf=1,nelfamily
          do l=1,ngauss
            call get_state(state,dstate,sout,nstate)
            call daxpy(nstatesmax,delti,sout(nstatesmax+ione),ione,
     &       sout(2*nstatesmax+ione),ione)
            write(kw,720) ielg,l,(sout(istatoutc(j)),j=1,nstatestot)
          end do
          ielgp=ielgp+ione
        end do
      end if
c
c...  output to binary plot file
c
      if(idsk.eq.2) then
        do ielf=1,nelfamily
          do l=1,ngauss
            call get_state(state,dstate,sout,nstate)
            call daxpy(nstatesmax,delti,sout(nstatesmax+ione),ione,
     &       sout(2*nstatesmax+ione),ione)
            write(kp) (sout(istatoutc(j)),j=1,nstatestot)
          end do
        end do
      end if
c
c...  output to UCD file
c
      if(iucd.ne.0) then
        do ielf=1,nelfamily
          do l=1,ngauss
            npts=npts+ione
            call get_state(state,dstate,sout,nstate)
            call daxpy(nstatesmax,delti,sout(nstatesmax+ione),ione,
     &       sout(2*nstatesmax+ione),ione)
            write(kucd,720) nout,(sout(istatoutc(j)),j=1,nstatestot)
          end do
        end do
      end if
c
 700  format(2x,"elmt",4x,"gspt",100(:5x,a11))
 710  format(2(1x,i7),100(:2x,1pe15.8))
 720  format(i7,100(:2x,1pe15.8))
      return
      end
c
c version
c $Id: write_state_cmp.f,v 1.2 2005/03/23 18:23:33 willic3 Exp $
c
c End of file 