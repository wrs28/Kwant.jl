module lattice
    include("load_kwant.jl")
    export AbstractLattice
    abstract type AbstractLattice end
    struct Monatomic <: AbstractLattice o::PyObject end
    square(a) = Monatomic(kwant.lattice.square(a))
    (lat::Monatomic)(i::Integer,j::Integer) = pycall(lat.o,PyObject,i-1,j-1)

    struct _Neighbors o::PyObject end
    (nn::_Neighbors)() = pycall(nn.o,PyObject)

    function Base.getproperty(k::AbstractLattice, name::Symbol)
        if name==:o
            p = getfield(k,:o)
        else
            p = getproperty(k.o,name)
        end
        if name==:neighbors
            p = _Neighbors(p)
        end
        return p
    end

end
