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
      subroutine scan_fuldat(icode,lastep,icontr,kr,fofile,ierr,
     & errstrng)
c
c...  subroutine to perform an initial scan of the file specifying the
c     timesteps for which to produce output to determine the number of
c     outputs to produce.
c
c     Error codes:
c         0:  No error
c         1:  Error opening input file (an exception should be raised if
c             a full solution is being performed and the number of time
c             steps is greater than zero)
c         3:  Read error
c
      include "implicit.inc"
c
c...  parameter definitions
c
      include "nconsts.inc"
c
c...  subroutine arguments
c
      integer icode,lastep,icontr,kr,ierr
      character fofile*(*),errstrng*(*)
c
c...  local variables
c
      integer iprint
c
c...  open input file
c
      ierr=izero
      icontr=izero
      if(lastep.eq.izero) return
      open(kr,file=fofile,status="old",err=20)
c
c... scan the file, counting the number of entries.
c    Note:  Due to speed considerations, we are not allowing the option
c    of putting comments within the list.  To do this, we
c    would need to scan each line twice to determine whether it was a
c    comment.
c
      call pskip(kr)
 40   continue
        read(kr,*,end=10,err=30) iprint
        icontr=icontr+ione
        go to 40
c
c...  normal return
c
 10   continue
        if(icontr.eq.izero.and.icode.eq.ithree) then
          ierr=3
          errstrng="scan_fuldat"
        end if
        close(kr)
        return
c
c...  error opening file
c
 20   continue
	if(icode.eq.ithree) then
          ierr=1
          errstrng="scan_fuldat"
        end if
        close(kr)
        return
c
c...  read error
c
 30   continue
        ierr=3
        errstrng="scan_fuldat"
        close(kr)
        return
c
      end
c
c version
c $Id: scan_fuldat.f,v 1.2 2004/07/12 19:58:02 willic3 Exp $
c
c Generated automatically by Fortran77Mill on Wed May 21 14:15:03 2003
c
c End of file 