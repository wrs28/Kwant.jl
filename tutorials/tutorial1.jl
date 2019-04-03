using Kwant,
    PyPlot

syst = Builder()

a = 1
    lat = lattice.square(a)
    t = 1.0
    W = 10
    L = 30

    for i ∈ 1:L
        for j ∈ 1:W
            # On-site Hamiltonian
            syst[lat(i,j)] = 4*t

            # Hopping in y-direction
            if j > 1
                syst[lat(i,j),lat(i,j-1)] = -t
            end

            # Hopping in x-direction
            if i > 1
                syst[lat(i,j), lat(i-1,j)] = -t
            end
        end
    end

plot(syst)

sym_left_lead = TranslationalSymmetry((-a, 0))
    left_lead = Builder(sym_left_lead)

    for j in 1:W
        left_lead[lat(1, j)] = 4 * t
        if j > 1
            left_lead[lat(1, j), lat(1, j - 1)] = -t
        end
        left_lead[lat(2, j), lat(1, j)] = -t
    end

    syst.attach_lead(left_lead)

sym_right_lead = TranslationalSymmetry((a, 0))
    right_lead = Builder(sym_right_lead)

    for j in 1:W
        right_lead[lat(1, j)] = 4 * t
        if j > 1
            right_lead[lat(1, j), lat(1, j - 1)] = -t
        end
        right_lead[lat(2, j), lat(1, j)] = -t
    end

    syst.attach_lead(right_lead)

plot(syst)

syst = syst.finalized()

energies = []
data = []
for ie in 1:100
    energy = ie * 0.01
    smatrix = Kwant.kwant.smatrix(syst, energy)
    append!(energies,energy)
    append!(data,smatrix.transmission(1, 0))
end

clf(); plot(energies,data); gcf()

function make_system(a=1, t=1.0, W=10, L=30)
    lat = lattice.square(a)
    syst = Builder()
    syst[[lat(x, y) for x in 1:L for y in 1:W]] = 4 * t
    syst[lat.neighbors()] = -t
    lead = Builder(TranslationalSymmetry((-a, 0)))
    lead[[lat(0, j) for j in 1:W]] = 4 * t
    lead[lat.neighbors()] = -t
    syst.attach_lead(lead)
    syst.attach_lead(lead.reversed())
    return syst
end

function plot_conductance(syst, energies)
    # Compute conductance
    data = []
    for energy in energies
        smatrix = Kwant.smatrix(syst, energy)
        append!(data,smatrix.transmission(1, 0))
    end

    plot(energies, data)
    xlabel("energy [t]")
    ylabel("conductance [e^2/h]")
    gcf()
end

system = make_system()
syst = system.finalized()
plot_conductance(syst,LinRange(0,1,100))
