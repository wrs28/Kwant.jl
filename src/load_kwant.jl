using PyCall
const KWANT = PyNULL()
function __init__()
    copy!(KWANT, pyimport("kwant"))
end
