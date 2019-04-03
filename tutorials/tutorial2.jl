using Kwant,
    PyPlot,
    PyCall

tinyarray = pyimport("tinyarray")
    sigma_0 = tinyarray.array([[1, 0], [0, 1]])
    sigma_x = tinyarray.array([[0, 1], [1, 0]])
    sigma_y = tinyarray.array([[0, -1im], [1im, 0]])
    sigma_z = tinyarray.array([[1, 0], [0, -1]])

function make_system(t=1.0, alpha=0.5, e_z=0.08, W=10, L=30)
    lat = lattice.square()
    syst = Builder()

    syst[[lat(x, y) for x in 1:L for y in 1:W]] = 4t*sigma_0+e_z*sigma_z

    syst[builder.HoppingKind((1, 0), lat, lat)] = -t*sigma_0 + 1im*alpha*sigma_y/2
    syst[builder.HoppingKind((0, 1), lat, lat)] = -t*sigma_0 - 1im*alpha*sigma_x/2

    lead = Builder(TranslationalSymmetry((-1, 0)))
    lead[[lat(0, j) for j in 1:W]] = 4t*sigma_0 + e_z*sigma_z
    lead[builder.HoppingKind((1, 0), lat, lat)] = -t*sigma_0 + 1im*alpha*sigma_y/2
    lead[builder.HoppingKind((0, 1), lat, lat)] = -t*sigma_0 - 1im*alpha*sigma_x/2

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

plot_conductance(syst, [0.01i-0.3 for i in 0:56])
