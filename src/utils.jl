module Utils

export l2_error

"""
    l2_error(u_approx, u_exact, nodes)

Compute L2 error norm for FEM.
"""
function l2_error(u_approx, u_exact, nodes)
    err = 0.0
    for i in 1:length(nodes)
        err += (u_approx[i] - u_exact(nodes[i]))^2
    end
    return sqrt(err/length(nodes))
end

end # module
