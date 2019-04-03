module lattice

include("load_kwant.jl")
import .. AbstractKwantObject

abstract type AbstractLattice <:AbstractKwantObject end

struct Monatomic <: AbstractLattice o::PyObject end

(lat::Monatomic)(i::Integer,j::Integer) = pycall(lat.o,PyObject,i-1,j-1)

square(a=1) = Monatomic(kwant.lattice.square(a))

end # module

# function Base.getproperty(k::AbstractLattice, name::Symbol)
#     if name==:o
#         p = getfield(k,:o)
#     else
#         p = getproperty(k.o,name)
#     end
#     if name==:neighbors
#         p = _Neighbors(p)
#     end
#     return p
# end
