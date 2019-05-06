using PyCall

const kwant = PyNULL()
const plotter = PyNULL()
const operator = PyNULL()
# const builder = PyNULL()

function __init__()
    copy!(kwant, pyimport("kwant"))
    copy!(plotter, pyimport("kwant.plotter"))
    copy!(operator, pyimport("kwant.operator"))
    # copy!(builder, pyimport("kwant.builder"))
end
