using Kwant, PyPlot, PyCall
kwant = Kwant; pyplot = PyPlot

######### SPIN ORBIT ############

include("spin_orbit.jl")

syst = make_system()

# Check that the system looks as intended.
kwant.plot(syst)

# Finalize the system.
syst = syst.finalized()

# We should see non-monotonic conductance steps.
plot_conductance(syst, [0.01 * i - 0.3 for i in range(0,length=100)])
# CHANGE from oringal: energies not specified as keyword


######### QUANTUM WELL ############
include("quantum_well.jl")
syst = make_system()

# Check that the system looks as intended.
kwant.plot(syst)

# Finalize the system.
syst = syst.finalized()

# We should see conductance steps.
plot_conductance(syst, 0.2, [0.01 * i for i in 0:100-1]) ## note 1:100 not range(100)
