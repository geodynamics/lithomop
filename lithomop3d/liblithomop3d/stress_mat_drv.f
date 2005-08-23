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
      subroutine stress_mat_drv(
     & alnz,ja,nnz,                                                     ! sparse
     & b,neq,                                                           ! force
     & x,d,iwink,wink,numnp,nwink,                                      ! global
     & dx,iwinkx,winkx,numslp,numsn,nwinkx,                             ! slip
     & tfault,numfn,                                                    ! fault
     & s,stemp,                                                         ! stiff
     & state,dstate,dmat,ien,lm,lmx,lmf,infiel,iddmat,nstatesz,ndmatsz, ! elemnt
     & numelt,nconsz,                                                   ! elemnt
     & prop,mhist,infmat,numat,npropsz,                                 ! materl
     & gauss,sh,shj,infetype,                                           ! eltype
     & histry,rtimdat,rgiter,ntimdat,nhist,lastep,stress_mat_cmp,       ! timdat
     & skew,numrot,                                                     ! skew
     & getshape,bmatrix,                                                ! bbar
     & ierr,errstrng)                                                   ! errcode
c
c...program to compute the total stress and strain for the current
c   iteration and compute the internal force vector.
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
      integer nnz,neq,numnp,nwink,numslp,numsn,nwinkx,numfn,nstatesz
      integer ndmatsz,numelt,nconsz,numat,npropsz,nhist,lastep,numrot
      integer ierr
      integer ja(nnz),iwink(2,nwink),iwinkx(2,nwinkx),ien(nconsz)
      integer lm(ndof,nconsz),lmx(ndof,nconsz),lmf(nconsz)
      integer infiel(6,numelt),iddmat(nstr,nstr),mhist(npropsz)
      integer infmat(6,numat),infetype(4,netypes)
      character errstrng*(*)
      double precision alnz(nnz),b(neq),x(nsd,numnp),d(ndof,numnp)
      double precision wink(nwink),dx(ndof,numnp),winkx(nwinkx)
      double precision tfault(ndof,numfn),s(neemax*neemax)
      double precision stemp(neemax*neemax),state(nstr,nstatesz)
      double precision dstate(nstr,nstatesz),dmat(nddmat,ndmatsz)
      double precision prop(npropsz)
      double precision gauss(nsd+1,ngaussmax,netypes)
      double precision sh(nsd+1,nenmax,ngaussmax,netypes)
      double precision shj(nsd+1,nenmax,ngaussmax,netypes)
      double precision histry(nhist,lastep+1),skew(nskdim,numnp)
c
c...  included dimension and type statements
c
      include "rtimdat_dim.inc"
      include "rgiter_dim.inc"
      include "ntimdat_dim.inc"
c
c...  intrinsic functions
c
c
c...  external routines
c
      include "elas_strs_ext.inc"
      include "td_strs_mat_ext.inc"
      external stress_mat_cmp,getshape,bmatrix
c
c...  local variables
c
      integer matgpt,imat,matmodel,nmatel,nprop,indprop
      logical matchg
      double precision ptmp(100)
c
c...  included variable definitions
c
      include "rtimdat_def.inc"
      include "rgiter_def.inc"
      include "ntimdat_def.inc"
c
cdebug      write(6,*) "Hello from stress_mat_drv_f!"
c
      call fill(b,zero,neq)
      matgpt=1
c
c...  loop over material groups and then select appropriate material model
c     routine
c
      do imat=1,numat
        matmodel=infmat(1,imat)
        nmatel=infmat(2,imat)
        nprop=infmat(5,imat)
        indprop=infmat(6,imat)
        matchg=.false.
        call mathist(ptmp,prop(indprop),mhist(indprop),histry,nprop,
     &   imat,nstep,nhist,lastep,matchg,ierr,errstrng)
        if(ierr.ne.izero) return
        if(matmodel.eq.1) then
          call stress_mat_cmp(
     &     alnz,ja,nnz,                                                 ! sparse
     &     b,neq,                                                       ! force
     &     x,d,numnp,                                                   ! global
     &     dx,numslp,numsn,                                             ! slip
     &     tfault,numfn,                                                ! fault
     &     state,dstate,dmat,ien,lm,lmx,lmf,infiel,iddmat,nstatesz,     ! elemnt
     &     ndmatsz,numelt,nconsz,                                       ! elemnt
     &     ptmp,infmat(1,imat),nprop,matgpt,elas_strs_1,                ! materl
     &     td_strs_mat_1,matchg,                                        ! materl
     &     gauss,sh,shj,infetype,                                       ! eltype
     &     rtimdat,ntimdat,rgiter,                                      ! timdat
     &     skew,numrot,                                                 ! skew
     &     getshape,bmatrix,                                            ! bbar
     &     ierr,errstrng)                                               ! errcode
        else if(matmodel.eq.2) then
          call stress_mat_cmp(
     &     alnz,ja,nnz,                                                 ! sparse
     &     b,neq,                                                       ! force
     &     x,d,numnp,                                                   ! global
     &     dx,numslp,numsn,                                             ! slip
     &     tfault,numfn,                                                ! fault
     &     state,dstate,dmat,ien,lm,lmx,lmf,infiel,iddmat,nstatesz,     ! elemnt
     &     ndmatsz,numelt,nconsz,                                       ! elemnt
     &     ptmp,infmat(1,imat),nprop,matgpt,elas_strs_2,                ! materl
     &     td_strs_mat_2,matchg,                                        ! materl
     &     gauss,sh,shj,infetype,                                       ! eltype
     &     rtimdat,ntimdat,rgiter,                                      ! timdat
     &     skew,numrot,                                                 ! skew
     &     getshape,bmatrix,                                            ! bbar
     &     ierr,errstrng)                                               ! errcode
        else if(matmodel.eq.3) then
          call stress_mat_cmp(
     &     alnz,ja,nnz,                                                 ! sparse
     &     b,neq,                                                       ! force
     &     x,d,numnp,                                                   ! global
     &     dx,numslp,numsn,                                             ! slip
     &     tfault,numfn,                                                ! fault
     &     state,dstate,dmat,ien,lm,lmx,lmf,infiel,iddmat,nstatesz,     ! elemnt
     &     ndmatsz,numelt,nconsz,                                       ! elemnt
     &     ptmp,infmat(1,imat),nprop,matgpt,elas_strs_3,                ! materl
     &     td_strs_mat_3,matchg,                                        ! materl
     &     gauss,sh,shj,infetype,                                       ! eltype
     &     rtimdat,ntimdat,rgiter,                                      ! timdat
     &     skew,numrot,                                                 ! skew
     &     getshape,bmatrix,                                            ! bbar
     &     ierr,errstrng)                                               ! errcode
        else if(matmodel.eq.4) then
          call stress_mat_cmp(
     &     alnz,ja,nnz,                                                 ! sparse
     &     b,neq,                                                       ! force
     &     x,d,numnp,                                                   ! global
     &     dx,numslp,numsn,                                             ! slip
     &     tfault,numfn,                                                ! fault
     &     state,dstate,dmat,ien,lm,lmx,lmf,infiel,iddmat,nstatesz,     ! elemnt
     &     ndmatsz,numelt,nconsz,                                       ! elemnt
     &     ptmp,infmat(1,imat),nprop,matgpt,elas_strs_4,                ! materl
     &     td_strs_mat_4,matchg,                                        ! materl
     &     gauss,sh,shj,infetype,                                       ! eltype
     &     rtimdat,ntimdat,rgiter,                                      ! timdat
     &     skew,numrot,                                                 ! skew
     &     getshape,bmatrix,                                            ! bbar
     &     ierr,errstrng)                                               ! errcode
        else if(matmodel.eq.5) then
          call stress_mat_cmp(
     &     alnz,ja,nnz,                                                 ! sparse
     &     b,neq,                                                       ! force
     &     x,d,numnp,                                                   ! global
     &     dx,numslp,numsn,                                             ! slip
     &     tfault,numfn,                                                ! fault
     &     state,dstate,dmat,ien,lm,lmx,lmf,infiel,iddmat,nstatesz,     ! elemnt
     &     ndmatsz,numelt,nconsz,                                       ! elemnt
     &     ptmp,infmat(1,imat),nprop,matgpt,elas_strs_5,                ! materl
     &     td_strs_mat_5,matchg,                                        ! materl
     &     gauss,sh,shj,infetype,                                       ! eltype
     &     rtimdat,ntimdat,rgiter,                                      ! timdat
     &     skew,numrot,                                                 ! skew
     &     getshape,bmatrix,                                            ! bbar
     &     ierr,errstrng)                                               ! errcode
        else if(matmodel.eq.6) then
          call stress_mat_cmp(
     &     alnz,ja,nnz,                                                 ! sparse
     &     b,neq,                                                       ! force
     &     x,d,numnp,                                                   ! global
     &     dx,numslp,numsn,                                             ! slip
     &     tfault,numfn,                                                ! fault
     &     state,dstate,dmat,ien,lm,lmx,lmf,infiel,iddmat,nstatesz,     ! elemnt
     &     ndmatsz,numelt,nconsz,                                       ! elemnt
     &     ptmp,infmat(1,imat),nprop,matgpt,elas_strs_6,                ! materl
     &     td_strs_mat_6,matchg,                                        ! materl
     &     gauss,sh,shj,infetype,                                       ! eltype
     &     rtimdat,ntimdat,rgiter,                                      ! timdat
     &     skew,numrot,                                                 ! skew
     &     getshape,bmatrix,                                            ! bbar
     &     ierr,errstrng)                                               ! errcode
        else if(matmodel.eq.7) then
          call stress_mat_cmp(
     &     alnz,ja,nnz,                                                 ! sparse
     &     b,neq,                                                       ! force
     &     x,d,numnp,                                                   ! global
     &     dx,numslp,numsn,                                             ! slip
     &     tfault,numfn,                                                ! fault
     &     state,dstate,dmat,ien,lm,lmx,lmf,infiel,iddmat,nstatesz,     ! elemnt
     &     ndmatsz,numelt,nconsz,                                       ! elemnt
     &     ptmp,infmat(1,imat),nprop,matgpt,elas_strs_7,                ! materl
     &     td_strs_mat_7,matchg,                                        ! materl
     &     gauss,sh,shj,infetype,                                       ! eltype
     &     rtimdat,ntimdat,rgiter,                                      ! timdat
     &     skew,numrot,                                                 ! skew
     &     getshape,bmatrix,                                            ! bbar
     &     ierr,errstrng)                                               ! errcode
        else if(matmodel.eq.8) then
          call stress_mat_cmp(
     &     alnz,ja,nnz,                                                 ! sparse
     &     b,neq,                                                       ! force
     &     x,d,numnp,                                                   ! global
     &     dx,numslp,numsn,                                             ! slip
     &     tfault,numfn,                                                ! fault
     &     state,dstate,dmat,ien,lm,lmx,lmf,infiel,iddmat,nstatesz,     ! elemnt
     &     ndmatsz,numelt,nconsz,                                       ! elemnt
     &     ptmp,infmat(1,imat),nprop,matgpt,elas_strs_8,                ! materl
     &     td_strs_mat_8,matchg,                                        ! materl
     &     gauss,sh,shj,infetype,                                       ! eltype
     &     rtimdat,ntimdat,rgiter,                                      ! timdat
     &     skew,numrot,                                                 ! skew
     &     getshape,bmatrix,                                            ! bbar
     &     ierr,errstrng)                                               ! errcode
        else if(matmodel.eq.9) then
          call stress_mat_cmp(
     &     alnz,ja,nnz,                                                 ! sparse
     &     b,neq,                                                       ! force
     &     x,d,numnp,                                                   ! global
     &     dx,numslp,numsn,                                             ! slip
     &     tfault,numfn,                                                ! fault
     &     state,dstate,dmat,ien,lm,lmx,lmf,infiel,iddmat,nstatesz,     ! elemnt
     &     ndmatsz,numelt,nconsz,                                       ! elemnt
     &     ptmp,infmat(1,imat),nprop,matgpt,elas_strs_9,                ! materl
     &     td_strs_mat_9,matchg,                                        ! materl
     &     gauss,sh,shj,infetype,                                       ! eltype
     &     rtimdat,ntimdat,rgiter,                                      ! timdat
     &     skew,numrot,                                                 ! skew
     &     getshape,bmatrix,                                            ! bbar
     &     ierr,errstrng)                                               ! errcode
        else if(matmodel.eq.10) then
          call stress_mat_cmp(
     &     alnz,ja,nnz,                                                 ! sparse
     &     b,neq,                                                       ! force
     &     x,d,numnp,                                                   ! global
     &     dx,numslp,numsn,                                             ! slip
     &     tfault,numfn,                                                ! fault
     &     state,dstate,dmat,ien,lm,lmx,lmf,infiel,iddmat,nstatesz,     ! elemnt
     &     ndmatsz,numelt,nconsz,                                       ! elemnt
     &     ptmp,infmat(1,imat),nprop,matgpt,elas_strs_10,               ! materl
     &     td_strs_mat_10,matchg,                                       ! materl
     &     gauss,sh,shj,infetype,                                       ! eltype
     &     rtimdat,ntimdat,rgiter,                                      ! timdat
     &     skew,numrot,                                                 ! skew
     &     getshape,bmatrix,                                            ! bbar
     &     ierr,errstrng)                                               ! errcode
        else if(matmodel.eq.11) then
          call stress_mat_cmp(
     &     alnz,ja,nnz,                                                 ! sparse
     &     b,neq,                                                       ! force
     &     x,d,numnp,                                                   ! global
     &     dx,numslp,numsn,                                             ! slip
     &     tfault,numfn,                                                ! fault
     &     state,dstate,dmat,ien,lm,lmx,lmf,infiel,iddmat,nstatesz,     ! elemnt
     &     ndmatsz,numelt,nconsz,                                       ! elemnt
     &     ptmp,infmat(1,imat),nprop,matgpt,elas_strs_11,               ! materl
     &     td_strs_mat_11,matchg,                                       ! materl
     &     gauss,sh,shj,infetype,                                       ! eltype
     &     rtimdat,ntimdat,rgiter,                                      ! timdat
     &     skew,numrot,                                                 ! skew
     &     getshape,bmatrix,                                            ! bbar
     &     ierr,errstrng)                                               ! errcode
        else if(matmodel.eq.12) then
          call stress_mat_cmp(
     &     alnz,ja,nnz,                                                 ! sparse
     &     b,neq,                                                       ! force
     &     x,d,numnp,                                                   ! global
     &     dx,numslp,numsn,                                             ! slip
     &     tfault,numfn,                                                ! fault
     &     state,dstate,dmat,ien,lm,lmx,lmf,infiel,iddmat,nstatesz,     ! elemnt
     &     ndmatsz,numelt,nconsz,                                       ! elemnt
     &     ptmp,infmat(1,imat),nprop,matgpt,elas_strs_12,               ! materl
     &     td_strs_mat_12,matchg,                                       ! materl
     &     gauss,sh,shj,infetype,                                       ! eltype
     &     rtimdat,ntimdat,rgiter,                                      ! timdat
     &     skew,numrot,                                                 ! skew
     &     getshape,bmatrix,                                            ! bbar
     &     ierr,errstrng)                                               ! errcode
        else if(matmodel.eq.13) then
          call stress_mat_cmp(
     &     alnz,ja,nnz,                                                 ! sparse
     &     b,neq,                                                       ! force
     &     x,d,numnp,                                                   ! global
     &     dx,numslp,numsn,                                             ! slip
     &     tfault,numfn,                                                ! fault
     &     state,dstate,dmat,ien,lm,lmx,lmf,infiel,iddmat,nstatesz,     ! elemnt
     &     ndmatsz,numelt,nconsz,                                       ! elemnt
     &     ptmp,infmat(1,imat),nprop,matgpt,elas_strs_13,               ! materl
     &     td_strs_mat_13,matchg,                                       ! materl
     &     gauss,sh,shj,infetype,                                       ! eltype
     &     rtimdat,ntimdat,rgiter,                                      ! timdat
     &     skew,numrot,                                                 ! skew
     &     getshape,bmatrix,                                            ! bbar
     &     ierr,errstrng)                                               ! errcode
        else if(matmodel.eq.14) then
          call stress_mat_cmp(
     &     alnz,ja,nnz,                                                 ! sparse
     &     b,neq,                                                       ! force
     &     x,d,numnp,                                                   ! global
     &     dx,numslp,numsn,                                             ! slip
     &     tfault,numfn,                                                ! fault
     &     state,dstate,dmat,ien,lm,lmx,lmf,infiel,iddmat,nstatesz,     ! elemnt
     &     ndmatsz,numelt,nconsz,                                       ! elemnt
     &     ptmp,infmat(1,imat),nprop,matgpt,elas_strs_14,               ! materl
     &     td_strs_mat_14,matchg,                                       ! materl
     &     gauss,sh,shj,infetype,                                       ! eltype
     &     rtimdat,ntimdat,rgiter,                                      ! timdat
     &     skew,numrot,                                                 ! skew
     &     getshape,bmatrix,                                            ! bbar
     &     ierr,errstrng)                                               ! errcode
        else if(matmodel.eq.15) then
          call stress_mat_cmp(
     &     alnz,ja,nnz,                                                 ! sparse
     &     b,neq,                                                       ! force
     &     x,d,numnp,                                                   ! global
     &     dx,numslp,numsn,                                             ! slip
     &     tfault,numfn,                                                ! fault
     &     state,dstate,dmat,ien,lm,lmx,lmf,infiel,iddmat,nstatesz,     ! elemnt
     &     ndmatsz,numelt,nconsz,                                       ! elemnt
     &     ptmp,infmat(1,imat),nprop,matgpt,elas_strs_15,               ! materl
     &     td_strs_mat_15,matchg,                                       ! materl
     &     gauss,sh,shj,infetype,                                       ! eltype
     &     rtimdat,ntimdat,rgiter,                                      ! timdat
     &     skew,numrot,                                                 ! skew
     &     getshape,bmatrix,                                            ! bbar
     &     ierr,errstrng)                                               ! errcode
        else if(matmodel.eq.16) then
          call stress_mat_cmp(
     &     alnz,ja,nnz,                                                 ! sparse
     &     b,neq,                                                       ! force
     &     x,d,numnp,                                                   ! global
     &     dx,numslp,numsn,                                             ! slip
     &     tfault,numfn,                                                ! fault
     &     state,dstate,dmat,ien,lm,lmx,lmf,infiel,iddmat,nstatesz,     ! elemnt
     &     ndmatsz,numelt,nconsz,                                       ! elemnt
     &     ptmp,infmat(1,imat),nprop,matgpt,elas_strs_16,               ! materl
     &     td_strs_mat_16,matchg,                                       ! materl
     &     gauss,sh,shj,infetype,                                       ! eltype
     &     rtimdat,ntimdat,rgiter,                                      ! timdat
     &     skew,numrot,                                                 ! skew
     &     getshape,bmatrix,                                            ! bbar
     &     ierr,errstrng)                                               ! errcode
        else if(matmodel.eq.17) then
          call stress_mat_cmp(
     &     alnz,ja,nnz,                                                 ! sparse
     &     b,neq,                                                       ! force
     &     x,d,numnp,                                                   ! global
     &     dx,numslp,numsn,                                             ! slip
     &     tfault,numfn,                                                ! fault
     &     state,dstate,dmat,ien,lm,lmx,lmf,infiel,iddmat,nstatesz,     ! elemnt
     &     ndmatsz,numelt,nconsz,                                       ! elemnt
     &     ptmp,infmat(1,imat),nprop,matgpt,elas_strs_17,               ! materl
     &     td_strs_mat_17,matchg,                                       ! materl
     &     gauss,sh,shj,infetype,                                       ! eltype
     &     rtimdat,ntimdat,rgiter,                                      ! timdat
     &     skew,numrot,                                                 ! skew
     &     getshape,bmatrix,                                            ! bbar
     &     ierr,errstrng)                                               ! errcode
        else if(matmodel.eq.18) then
          call stress_mat_cmp(
     &     alnz,ja,nnz,                                                 ! sparse
     &     b,neq,                                                       ! force
     &     x,d,numnp,                                                   ! global
     &     dx,numslp,numsn,                                             ! slip
     &     tfault,numfn,                                                ! fault
     &     state,dstate,dmat,ien,lm,lmx,lmf,infiel,iddmat,nstatesz,     ! elemnt
     &     ndmatsz,numelt,nconsz,                                       ! elemnt
     &     ptmp,infmat(1,imat),nprop,matgpt,elas_strs_18,               ! materl
     &     td_strs_mat_18,matchg,                                       ! materl
     &     gauss,sh,shj,infetype,                                       ! eltype
     &     rtimdat,ntimdat,rgiter,                                      ! timdat
     &     skew,numrot,                                                 ! skew
     &     getshape,bmatrix,                                            ! bbar
     &     ierr,errstrng)                                               ! errcode
        else if(matmodel.eq.19) then
          call stress_mat_cmp(
     &     alnz,ja,nnz,                                                 ! sparse
     &     b,neq,                                                       ! force
     &     x,d,numnp,                                                   ! global
     &     dx,numslp,numsn,                                             ! slip
     &     tfault,numfn,                                                ! fault
     &     state,dstate,dmat,ien,lm,lmx,lmf,infiel,iddmat,nstatesz,     ! elemnt
     &     ndmatsz,numelt,nconsz,                                       ! elemnt
     &     ptmp,infmat(1,imat),nprop,matgpt,elas_strs_19,               ! materl
     &     td_strs_mat_19,matchg,                                       ! materl
     &     gauss,sh,shj,infetype,                                       ! eltype
     &     rtimdat,ntimdat,rgiter,                                      ! timdat
     &     skew,numrot,                                                 ! skew
     &     getshape,bmatrix,                                            ! bbar
     &     ierr,errstrng)                                               ! errcode
        else if(matmodel.eq.20) then
          call stress_mat_cmp(
     &     alnz,ja,nnz,                                                 ! sparse
     &     b,neq,                                                       ! force
     &     x,d,numnp,                                                   ! global
     &     dx,numslp,numsn,                                             ! slip
     &     tfault,numfn,                                                ! fault
     &     state,dstate,dmat,ien,lm,lmx,lmf,infiel,iddmat,nstatesz,     ! elemnt
     &     ndmatsz,numelt,nconsz,                                       ! elemnt
     &     ptmp,infmat(1,imat),nprop,matgpt,elas_strs_20,               ! materl
     &     td_strs_mat_20,matchg,                                       ! materl
     &     gauss,sh,shj,infetype,                                       ! eltype
     &     rtimdat,ntimdat,rgiter,                                      ! timdat
     &     skew,numrot,                                                 ! skew
     &     getshape,bmatrix,                                            ! bbar
     &     ierr,errstrng)                                               ! errcode
        else
          ierr=101
          errstrng="stress_mat_drv"
        end if
        if(ierr.ne.izero) return
        matgpt=matgpt+nmatel
      end do
      return
      end
c
c version
c $Id: stress_mat_drv.f,v 1.2 2004/06/25 15:54:21 willic3 Exp $
c
c Generated automatically by Fortran77Mill on Wed May 21 14:15:03 2003
c
c End of file 