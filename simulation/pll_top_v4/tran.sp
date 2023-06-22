*** This line must be comment *************************************
*// hspice simulation for injection locking pll //*
*// by Sungyoung Lee, Hyunsuk Choi //*

*** LIBRARY *******************************************************
.include '../SNU_45nm_TT.lib'

*** NETLIST *******************************************************
.include './pll_top_v4.ckt'

*** OPTIONS *******************************************************
.option post probe
.option runlvl=6
.option captab 
.option method=gear
.option measfile=1
.option measform=1

*** PARAMETERS ****************************************************
.param vdd = 0.9
.param vss = 0.0

.param ref_freq = 1.125G
.param ref_period = '1/ref_freq'
.param ref_drise = 'ref_period/10'
.param ref_dfall = 'ref_period/10'

*** SOURCES  ******************************************************
vvdd	vdd	0	vdd
vvss	vss	0	vss

vREF_CLK	REF_CLK		0	pulse(0 vdd 0.01n ref_drise ref_dfall 'ref_period/2-ref_drise' ref_period)
*** INITIAL *******************************************************
.ic v(vctrl) = 0.2
.ic v(clk_outb) = 0.4

*** MEASURE *******************************************************

*** SIMULATION ****************************************************
*.op 25n
*.dc vin 0 vdd 0.01
*+sweep vib 0.2 0.7 0.05
.trans 1p 50n
*.snosc tones=0.5g nharms=100 oscnode=clk_outb trinit=10n
*.phasenoise v(clk_outb) dec 10 100 100g
*.print phasenoise phnoise v(clk_outb)
*.probe phasenoise phnoise v(clk_outb)
.op

.probe v(*) i(*)

**** ALTER *********************************************************
*.alter
*.param freq=5G
*
*.alter
*.param freq=6G

.end

