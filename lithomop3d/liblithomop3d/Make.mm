# -*- Makefile -*-
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#  Lithomop3d by Charles A. Williams
#  Copyright (c) 2003-2005 Rensselaer Polytechnic Institute
#
#  Permission is hereby granted, free of charge, to any person obtaining
#  a copy of this software and associated documentation files (the
#  "Software"), to deal in the Software without restriction, including
#  without limitation the rights to use, copy, modify, merge, publish,
#  distribute, sublicense, and/or sell copies of the Software, and to
#  permit persons to whom the Software is furnished to do so, subject to
#  the following conditions:
#
#  The above copyright notice and this permission notice shall be
#  included in all copies or substantial portions of the Software.
#
#  THE  SOFTWARE IS  PROVIDED  "AS  IS", WITHOUT  WARRANTY  OF ANY  KIND,
#  EXPRESS OR  IMPLIED, INCLUDING  BUT NOT LIMITED  TO THE  WARRANTIES OF
#  MERCHANTABILITY,    FITNESS    FOR    A   PARTICULAR    PURPOSE    AND
#  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
#  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
#  OF CONTRACT, TORT OR OTHERWISE,  ARISING FROM, OUT OF OR IN CONNECTION
#  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#

include local.def

PROJECT = lithomop3d
PACKAGE = liblithomop3d

PROJ_SAR = $(BLD_LIBDIR)/$(PACKAGE).$(EXT_SAR)
PROJ_DLL = $(BLD_LIBDIR)/$(PACKAGE).$(EXT_SO)
PROJ_TMPDIR = $(BLD_TMPDIR)/$(PROJECT)/$(PACKAGE)
PROJ_CLEAN += $(PROJ_INCDIR) $(PROJ_SAR) $(PROJ_DLL)

PROJ_SRCS = \
	addfor.f \
        addpr.f \
        addsn.f \
        addstf.F \
        adfldp.f \
	assign_wink.f \
        autoprestr.F \
        bdeld_ss.f \
        bmatrixb.f \
        bmatrixn.f \
        bnmatrix.f \
        bsum.f \
        choldc2.f \
        cholsl.f \
        ckdiag.F \
        cklock.f \
        cmp_stiffsz.f \
        const.f \
        convert_case.f \
        create_id.f \
        cross.f \
        disp.f \
        eforce.f \
        elas_matinit_cmp_ss.F \
        elas_strs_cmp_ss.f \
        elas_strs_mat_cmp_ss.F \
        elastc.F \
        fill.f \
        formdf_ss.f \
        formes_ss.f \
        formf_ss.f \
        formrt.f \
        funcs.f \
	get_initial_stress.f \
        get_units.f \
        getder.f \
        getjac.f \
        getmat.f \
        getshapb.f \
        getshapn.f \
        gload_cmp_ss.f \
        gload_drv.f \
        gravld.f \
        id_split.f \
	idisp.f \
        ifill.f \
        indexx.f \
        infcmp.f \
        infellh.f \
        infelqh.f \
        invar.f \
        iquate.f \
        isort.f \
        iterate.F \
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
        makemsr.F \
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
        matinit_drv.F \
        matmod_def.f \
        meansh.f \
        nchar.f \
        nfind.f \
        nnblnk.f \
	open_ucd.F \
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
        prestr_matinit_cmp_ss.F \
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
        read_skew.f \
        read_slip.f \
        read_split.f \
        read_stateout.f \
        read_timdat.f \
        read_wink.f \
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
	sort_elements.f \
	sort_slip_nodes.f \
	sort_split_nodes.f \
        sprod.f \
        stiff_ss.f \
        stiffld.f \
        stress_drv.f \
        stress_mat_drv.F \
        symmet.f \
        td_matinit_cmp_ss.F \
        td_strs_cmp_ss.f \
        td_strs_mat_cmp_ss.F \
        transp.f \
	unlock.f \
        update_state_cmp.f \
        update_state_drv.f \
        viscos.F \
        winklf.f \
        winklr.F \
	write_bc.F \
	write_connect.F \
	write_coords.F \
	write_diff.F \
        write_element_info.F \
	write_fuldat.F \
        write_global_info.F \
	write_hist.F \
        write_props.F \
	write_skew.F \
	write_slip.F \
        write_sparse_info.F \
	write_split.F \
	write_split_plot.F \
        write_state_cmp.F \
        write_state_drv.F \
        write_stateout.F \
        write_strscomp.F \
        write_subiter.F \
        write_timdat.F \
        write_ucd_header.F \
        write_ucd_mesh.F \
        write_ucd_node_vals.F \
        write_wink.F \
        write_winkx.F


#--------------------------------------------------------------------------

all: $(PROJ_SAR) export

testit: test

#--------------------------------------------------------------------------
# build the shared object

$(PROJ_SAR): product_dirs $(PROJ_OBJS)
	$(CXX) -o $(PROJ_SAR) $(PROJ_OBJS) $(PROJ_LCXX_FLAGS)

#--------------------------------------------------------------------------
#
export:: export-libraries

test:: show-configuration show-project cpp-configuration fortran-configuration


EXPORT_LIBS = $(PROJ_SAR)
EXPORT_BINS = $(PROJ_DLL)


# version
# $Id: Make.mm,v 1.25 2005/08/05 20:17:17 willic3 Exp $

# Generated automatically by MakeMill on Tue Mar  2 17:05:23 2004

# End of file 
