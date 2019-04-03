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

HoppingKind(a::Tuple,b::AbstractKwantObject,c::AbstractKwantObject) = pycall(kwant.builder.HoppingKind,PyObject,a,b.o,c.o)


end # module

# struct FiniteSystem <:AbstractKwantObject o::PyObject end
