using PyCall
const kwant = PyNULL()
function __init__()
    copy!(kwant, pyimport("kwant"))
end
