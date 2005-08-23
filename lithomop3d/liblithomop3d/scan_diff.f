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
      subroutine scan_diff(numslp,numdif,kr,difile,ierr,errstrng)
c
c...  subroutine to perform an initial scan of the slippery node
c     differential forces input file to determine the number of
c     differential force entries (numdif).
c
c     Error codes:
c         0:  No error
c         1:  Error opening input file (no exception should be raised
c             in this case since a differential force file is optional)
c         3:  Read error
c
      include "implicit.inc"
c
c...  parameter definitions
c
      include "ndimens.inc"
      include "nconsts.inc"
c
c...  subroutine arguments
c
      integer numslp,numdif,kr,ierr
      character difile*(*),errstrng*(*)
c
c...  local variables
c
      integer j,n,idhist
      double precision diforc(3)
c
c...  open input file
c
      ierr=izero
      numdif=izero
      if(numslp.eq.izero) return
      open(kr,file=difile,status="old",err=10)
c
c... scan the file, counting the number of entries.
c    Note:  Due to speed considerations, we are not allowing the option
c    of putting comments within the list.  To do this, we
c    would need to scan each line twice to determine whether it was a
c    comment.
c
      call pskip(kr)
 40   continue
        read(kr,*,end=10,err=30) n,idhist,(diforc(j),j=1,ndof)
        numdif=numdif+ione
        go to 40
c
c...  normal return
c
 10   continue
        close(kr)
        return
c
c...  error opening file -- not used, since file is optional
c
c* 20   continue
c*	ierr=1
c*        close(kr)
c*        return
c
c...  read error
c
 30   continue
        close(kr)
        ierr=3
        errstrng="scan_diff"
        return
c
      end
c
c version
c $Id: scan_diff.f,v 1.2 2004/07/12 19:47:26 willic3 Exp $
c
c Generated automatically by Fortran77Mill on Wed May 21 14:15:03 2003
c
c End of file 