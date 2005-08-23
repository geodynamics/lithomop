c -*- Fortran -*-
c
c~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
c
c                             Charles A. Williams
c                       Rensselaer Polytechnic Institute
c                        (C) 2003  All Rights Reserved
c
c <LicenseText>
c
c~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
c
c...  nprint_def.inc:  A header that associates scalars with elements
c     of an array.  In general, the array and scalars should have
c     already been defined with a 'xxx_dim.inc' file.  This include
c     file actually contains executable (assignment) statements, so
c     it should be included after all type, data, etc. statements.
c
c...  associate local names with array elements
c
      icontr=nprint(1)
      idout=nprint(2)
      idsk=nprint(3)
      iucd=nprint(4)
c
c version
c $Id: nprint_def.inc,v 1.2 2004/08/24 18:36:28 willic3 Exp $
c
c Generated automatically by Fortran77Mill on Wed May 21 21:38:38 2003
c
c End of file 