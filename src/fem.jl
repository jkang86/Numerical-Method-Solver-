module FEMSolver

export fem_solve

using LinearAlgebra

"""
    fem_solve(f, c, a, n)

Solve BVP:
    -(c(x) u')' + a(x) u = f(x)
using linear FEM with n intervals.
"""
function fem_solve(f, c, a, n)
    h = 1/n
    nodes = collect(0:h:1)

    K = zeros(n+1, n+1)
    F = zeros(n+1)

    # Assemble element matrices
    for i in 1:n
        xL = nodes[i]
        xR = nodes[i+1]
        xm = (xL + xR)/2

        # Local stiffness
        k_local = c(xm)/h * [1 -1; -1 1]

        # Local load
        f_local = f(xm)*h/2 * [1, 1]

        # Assembly
        K[i:i+1, i:i+1] .+= k_local
        F[i:i+1] .+= f_local
    end

    # Apply Dirichlet BCs: u(0)=u(1)=0
    K[1, :] .= 0
    K[:, 1] .= 0
    K[1,1] = 1
    F[1] = 0

    K[end, :] .= 0
    K[:, end] .= 0
    K[end,end] = 1
    F[end] = 0

    # Solve
    u = K \ F
    return nodes, u
end

end # module
