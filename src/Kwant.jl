module Kwant

export Builder,
lattice

include("load_kwant.jl")
include("Lattice.jl")

mutable struct Builder
    o::PyObject
    Builder() = new(KWANT.Builder())
end
setindex!(b::Builder,val,key) = set!(b.o,key,val)



end # module


# using Pkg

# ENV["PYTHON"]  = "/Users/wrs/anaconda3/envs/kwant/bin/python3.6"
# ENV["PYCALL_JL_RUNTIME_PYTHON"] = "/Users/wrs/anaconda3/envs/kwant/bin/python3.6"
# Pkg.build("PyCall")
