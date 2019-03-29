module lattice
    include("load_kwant.jl")
    export AbstractLattice
    abstract type AbstractLattice end
    struct Monatomic <: AbstractLattice
        o::PyObject
    end
    square(a) = Monatomic(KWANT.lattice.square(a))

    (lat::Monatomic)(i,j) = pycall(lat.o,PyObject,i-1,j-1)
end
