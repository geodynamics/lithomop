# -*- Makefile -*-
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#                             Charles A. Williams
#                       Rensselaer Polytechnic Institute
#                        (C) 2003  All Rights Reserved
#
# <LicenseText>
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#

include local.def

PROJECT = lithomop3d
PACKAGE = liblithomop3d

PROJ_SAR = $(BLD_LIBDIR)/$(PACKAGE).$(EXT_SAR)
PROJ_TMPDIR = $(BLD_TMPDIR)/$(PROJECT)/$(PACKAGE)
PROJ_CLEAN += $(PROJ_INCDIR) $(PROJ_SAR)

PROJ_SRCS = \
	addfor.f \
        addpr.f \
        addsn.f \
        addstf.f \
        adfldp.f \
        adjid.f \
        bdeld_ss.f \
        bdiff.f \
        bmatrixb.f \
        bmatrixn.f \
        bnmatrix.f \
        choldc2.f \
        cholsl.f \
        ckdiag.f \
        cklock.f \
        const.f \
        convert_case.f \
        cross.f \
        disp.f \
        eforce.f \
        elas_matinit_cmp_ss.f \
        elas_strs_cmp_ss.f \
        elas_strs_mat_cmp_ss.f \
        elastc.f \
        fill.f \
        formdf_ss.f \
        formes_ss.f \
        formf_ss.f \
        formrt.f \
        funcs.f \
        get_units.f \
        getder.f \
        getjac.f \
        getmat.f \
        getshapb.f \
        getshapn.f \
        gload_cmp_ss.f \
        gload_drv.f \
        gravld.f \
        gspre.f \
        id_split.f \
        ifill.f \
        indexx.f \
        infcmp.f \
        infellh.f \
        infelqh.f \
        invar.f \
        iquate.f \
        isort.f \
        iterate.f \
        jacobi.f \
        lcoord.f \
        ldisbc.f \
        ldisp.f \
        ldupdat.f \
        lfit.f \
        lflteq.f \
        lnklst.f \
        load.f \
        loadf.f \
        loadx.f \
        local.f \
        localf.f \
        localx.f \
        makemsr.f \
        mat_1.f \
        mat_2.f \
        mat_3.f \
        mat_4.f \
        mat_5.f \
        mat_6.f \
        mat_7.f \
        mat_8.f \
        mat_9.f \
        mat_10.f \
        mat_11.f \
        mat_12.f \
        mat_13.f \
        mat_14.f \
        mat_15.f \
        mat_16.f \
        mat_17.f \
        mat_18.f \
        mat_19.f \
        mat_20.f \
        mathist.f \
        matinit_drv.f \
        matmod_def.f \
        meansh.f \
        nchar.f \
        nfind.f \
        nnblnk.f \
        pcginv.f \
        plinhex.f \
        plinpyr.f \
        plintet.f \
        plinwedge.f \
        poldcmp.f \
        pquadhex.f \
        pquadpyr.f \
        pquadtet.f \
        pquadwedge.f \
        preshape.f \
        presurql.f \
        printd.f \
        printf.f \
        printl.f \
        printv.f \
        prntforc.f \
        pskip.f \
        rdisp.f \
        read_bc.f \
        read_connect.f \
        read_coords.f \
        read_diff.f \
        read_fuldat.f \
        read_hist.f \
        read_mathist.f \
        read_skew.f \
        read_slip.f \
        read_split.f \
        read_stateout.f \
        read_timdat.f \
        read_wink.f \
        read_winkx.f \
        residu.f \
        rpforc.f \
        rsplit.f \
        rstiff.f \
        rstress.f \
        scan_bc.f \
        scan_connect.f \
        scan_coords.f \
        scan_diff.f \
        scan_fuldat.f \
        scan_hist.f \
        scan_skew.f \
        scan_slip.f \
        scan_split.f \
        scan_timdat.f \
        scan_wink.f \
        scan_winkx.f \
        skclear.f \
        skcomp.f \
        sprod.f \
        stiff_ss.f \
        stiffld.f \
        stress_drv.f \
        stress_mat_drv.f \
        symmet.f \
        td_matinit_cmp_ss.f \
        td_strs_cmp_ss.f \
        td_strs_mat_cmp_ss.f \
        transp.f \
        unlock.f \
        update_state.f \
        viscos.f \
        winklf.f \
        winklr.f \
        write_element_info.f \
        write_global_info.f \
        write_props.f \
        write_sparse_info.f \
        write_state.f \
        write_strscomp.f \
        write_subiter.f \


#--------------------------------------------------------------------------

all: $(PROJ_SAR) export

#--------------------------------------------------------------------------
# build the shared object

$(PROJ_SAR): product_dirs $(PROJ_OBJS)
	$(CXX) -o $(PROJ_SAR) $(PROJ_OBJS) $(LCXXFLAGS) $(LCXX_FORTRAN) $(PROJ_LIBRARIES)

#--------------------------------------------------------------------------
#
export:: export-libraries


EXPORT_LIBS = $(PROJ_SAR)


# version
# $Id: Make.mm,v 1.7 2004/08/18 21:05:36 willic3 Exp $

# Generated automatically by MakeMill on Tue Mar  2 17:05:23 2004

# End of file 
