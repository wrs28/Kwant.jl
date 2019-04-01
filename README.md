# Kwant.jl

Kwant.jl is an interface with the [_kwant_](https://kwant-project.org) quantum transport package, using the [PyCall](https://github.com/JuliaPy/PyCall.jl) pacakage.

The goal of this project is to faithfully emulate the native API of _kwant_.

To date, the implementation is in its very early stages, reproducing only the first page of the [First Steps Tutorial](https://kwant-project.org/doc/1/tutorial/first_steps).

The main difference thus far is that I use 1-base indexing instead of 0-base indexing, and the package name is capitalized in accordance with the Julia standard.

To use the plotting routines that come with _kwant_, you must implicitly call `using PyPlot`. Then something like `plot(syst)` should plot the system. Dependeing on the environment and build, you may need to explicitly call `gcf()` to show the figure.

Thus the first lines of the _kwant_ tutorial read
``` JULIA
import kwant
syst = kwant.Builder()
a=1
lat = kwant.lattice.square(a)
t=1.0
W=10
L=30
for i in range(L):
    for j in range(W):
        # On-site Hamiltonian
        syst[lat(i, j)] = 4 * t

        # Hopping in y-direction
        if j > 0:
            syst[lat(i, j), lat(i, j - 1)] = -t

        # Hopping in x-direction
        if i > 0:
            syst[lat(i, j), lat(i - 1, j)] = -t
```

while the first lines of the Julia implementation read
``` JULIA
import Kwant
syst = Kwant.Builder()
a=1
lat = Kwant.lattice.square(a)
t=1.0
W=10
L=30
for i in 1:L
    for j in 1:W
        # On-site Hamiltonian
        syst[lat(i, j)] = 4 * t

        # Hopping in y-direction
        if j > 1
            syst[lat(i, j), lat(i, j - 1)] = -t
        end

        # Hopping in x-direction
        if i > 1
            syst[lat(i, j), lat(i - 1, j)] = -t
        end
    end
end
```

Note that the Python `range(W)` becomes `1:W`, and the `if j>0:` becomes `if j>1 ... end`. Alternate expressions for iterating can be found [here](https://docs.julialang.org/en/v1/manual/arrays/#Iteration-1).

It is also worth nothing that the prepended `Kwant` can be avoided by `using Kwant` instead of `import Kwant`.
