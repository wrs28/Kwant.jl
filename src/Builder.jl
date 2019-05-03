module builder

export Builder

include("load_kwant.jl")
import .. AbstractKwantObject

struct Builder <:AbstractKwantObject
    o::PyObject
    Builder() = new(kwant.Builder())
    Builder(x) = new(kwant.Builder(x))
end

Base.setproperty!(b::Builder, name::Symbol, x::AbstractKwantObject) =
    setproperty!(b.o,name,x.o)

Base.setindex!(b::Builder,val,keys...) = set!(b.o,keys,val)
Base.setindex!(b::Builder,val,key) = set!(b.o,key,val)
Base.setindex!(b::Builder,val,key::AbstractKwantObject) = set!(b.o,key.o,val)

struct HoppingKind <: AbstractKwantObject
    o::PyObject
    (hk::HoppingKind)(syst::Builder) = hk.o(syst)
    function HoppingKind(a::Tuple,b::AbstractKwantObject,c::AbstractKwantObject)
        new(pycall(kwant.builder.HoppingKind,PyObject,a,b.o,c.o))
    end
end


end # module

# struct FiniteSystem <:AbstractKwantObject o::PyObject end
