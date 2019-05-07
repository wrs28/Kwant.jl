module Kwant

export Builder,
TranslationalSymmetry,
smatrix,
lattice,
builder

abstract type AbstractKwantObject end

include("load_kwant.jl")
include("Lattice.jl")
include("Builder.jl")

using PyPlot
using .builder

function Base.getproperty(k::AbstractKwantObject, name::Symbol)
    if name==:o
        p = getfield(k,:o)
    else
        p = getproperty(k.o,name)
    end
    if name==:finalized
        p = _FiniteSystem(p)
    elseif name==:neighbors
        p = _Neighbors(p)
    end
    return p
end

(p::PyObject)(k::AbstractKwantObject,args...) = pycall(p,PyObject,k.o,args...)


struct _FiniteSystem o::PyObject end
struct _Neighbors o::PyObject end
(fs::_FiniteSystem)() = pycall(fs.o,PyObject)
(nn::_Neighbors)() = pycall(nn.o,PyObject)

PyPlot.plot(b::AbstractKwantObject; kwargs...) = kwant.plot(b.o;kwargs...)

TranslationalSymmetry(x) = kwant.TranslationalSymmetry(x)

smatrix(system, energy; params=nothing) = pycall(kwant.smatrix,PyObject,system,energy,params=params)

end # module
