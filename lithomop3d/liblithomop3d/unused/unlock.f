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
      subroutine unlock(b,btot,id,iwink,idhist,ibond,bond,histry,
     & nstep,numnp,nwink,nhist,neq,numdif,lastep,iflag)
c
c       program to remove the winkler forces and leave the applied
c       forces at a specified step.  code uses load history factors
c       for forces, if they are defind
c
      include "implicit.inc"
c
c...  parameter definitions
c
      include "ndimens.inc"
      include "nconsts.inc"
      include "rconsts.inc"
c
c...  subroutine arguments
c
      integer nstep,numnp,nwink,nhist,neq,numdif,lastep,iflag
      integer id(ndof,numnp),iwink(2,nwink),idhist(numnp)
      integer ibond(ndof,numnp)
      double precision b(neq),btot(neq),bond(ndof,numnp)
      double precision histry(nhist,lastep+1)
c
c...  local constants
c
      double precision cutoff
      parameter(cutoff=0.8d0)
c
c...  local variables
c
      integer i,j,k,idk,mode,ihist,idforc
      double precision diff,forc
c
cdebug      write(6,*) "Hello from unlock_f!"
c
      do i=1,ndof
        do j=1,numnp
          if(id(i,j).ne.izero) then
            do k=1,nwink
              idk=iwink(2,k)
              if(id(i,j).eq.idk) then
                mode=iwink(1,k)
                if(mode.lt.izero) then
                  ihist=-mode
                  diff=histry(ihist,nstep+1)-histry(ihist,nstep)
                  if(diff.lt.-cutoff) then
                    if(iflag.eq.ione) then
                      idforc=ibond(i,j)
                      forc=bond(i,j)
                    else if(iflag.eq.itwo) then
                      idforc=idhist(j)
                      forc=zero
                      if(numdif.ne.izero) forc=bond(i,j)
                    end if
                    if(idforc.eq.izero) then
                      b(idk)=-btot(idk)+forc
                    else
                      b(idk)=-btot(idk)+forc*histry(idforc,nstep+1)
                    end if
                  end if
                end if
                go to 20
              end if
            end do
          end if
20        continue
        end do
      end do
      return
      end
c
c version
c $Id: unlock.f,v 1.1 2005/01/06 01:22:38 willic3 Exp $
c
c Generated automatically by Fortran77Mill on Wed May 21 14:15:03 2003
c
c End of file 
