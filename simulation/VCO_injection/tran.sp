*** This line must be comment *************************************
*// hspice simulation for injection locking pll //*
*// by Sungyoung Lee, Hyunsuk Choi //*

*** LIBRARY *******************************************************
.include '../SNU_45nm_TT.lib'

*** NETLIST *******************************************************
.include './VCO_injection.ckt'

*** OPTIONS *******************************************************
.option post probe
.option runlvl=6
.option captab 
.option method=gear
.option measfile=1
.option measform=1

*** PARAMETERS ****************************************************
.param vdd = 1.0
.param vss = 0.0

.param ref_freq = 1.0G
.param ref_period = '1/ref_freq'
.param ref_drise = 'ref_period/10'
.param ref_dfall = 'ref_period/10'

*** SOURCES  ******************************************************
vvdd	vdd	0	vdd
vvss	vss	0	vss

vvctrl	vctrl	0	pwl(0 0.0 100n 1.0)
vinj	inj	0	0

*vREF_CLK	REF_CLK		0	pulse(0 vdd 0.01n ref_drise ref_dfall 'ref_period/2-ref_drise' ref_period)
*** INITIAL *******************************************************
.ic v(clk_out_p) = 0.4
.ic v(clk_out_n) = 0.6

*** MEASURE *******************************************************

*** SIMULATION ****************************************************
*.op 25n
*.dc vin 0 vdd 0.01
*+sweep vib 0.2 0.7 0.05
.trans 1p 100n
*.snosc tones=10g nharms=20 oscnode=clk_outb trinit=30n
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

