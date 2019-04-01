module Kwant

using PyPlot

export Builder,
lattice,
TranslationalSymmetry,
plot

include("load_kwant.jl")
include("Lattice.jl")

abstract type AbstractKwantObject end

struct Builder <:AbstractKwantObject
    o::PyObject
    Builder() = new(kwant.Builder())
    Builder(x) = new(kwant.Builder(x))
end

struct _FiniteSystem <:AbstractKwantObject
    o::PyObject
end
struct FiniteSystem <:AbstractKwantObject
    o::PyObject
end
(fs::_FiniteSystem)() = FiniteSystem(fs.o())

(p::PyObject)(k::AbstractKwantObject,args...) = pycall(p,PyObject,k.o,args...)
# (p::PyObject)(args...) = pycall(p,PyObject,(args...,))
function Base.getproperty(k::AbstractKwantObject, name::Symbol)
    if name==:o
        p = getfield(k,:o)
    else
        p = getproperty(k.o,name)
    end
    if name==:finalized
        p = _FiniteSystem(p)
    end
    return p
end
function Base.setproperty!(b::Builder, name::Symbol, x::AbstractKwantObject)
    setproperty!(b.o,name,x.o)
end
Base.setindex!(b::Builder,val,keys...) = set!(b.o,keys,val)
Base.setindex!(b::Builder,val,key) = set!(b.o,key,val)
PyPlot.plot(b::AbstractKwantObject) = kwant.plot(b.o)

TranslationalSymmetry(x) = kwant.TranslationalSymmetry(x)

end # module
