
*** Library *******************************************************
.include './SNU_45nm_TT.lib'
$.unprotect
$.temp 40

*** Netlist *******************************************************
.include './osc.ckt'

*** Option ********************************************************
.option post 
.option captab
.option runlvl=6
*.option probe
.option method=gear
.option measfile=1
.option measform=1
*** Parameter******************************************************
.param par_vdd = 1.0

** Source ********************************************************
vvdd vdd 0 par_vdd
vvss vss 0 0

*** Initial Value **************************************************
.ic v(out)='par_vdd'

*** Measurement*****************************************************



*** Simulation *****************************************************
*.tran 10p 2n
$+sweep par_vctrl 0.0 1.0 0.025
.snosc tones=7.364g nharms=20 oscnode=out trinit=10n
.phasenoise v(out) dec 10 100 100g
.print phasenoise phnoise v(out)
.probe phasenoise phnoise v(out)
.op 

.probe v(*) i(*)

*.meas tran period trig v(out) = 'par_vdd/2' td=1n rise = 1 targ v(out) = 'par_vdd/2' rise = 2
*.meas tran freq param = '1/period'
$.meas tran swing pp v(out1) from=700n to=800n

.end



