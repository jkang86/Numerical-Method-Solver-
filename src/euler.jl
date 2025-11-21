module EulerMethod

export euler_method

"""
    euler_method(f, u0, t0, t_end, h)

Solve an IVP using Euler’s Method:
    u' = f(t, u),     u(t0) = u0
"""
function euler_method(f, u0, t0, t_end, h)
    ts = collect(t0:h:t_end)
    us = zeros(length(ts))
    us[1] = u0

    for i in 1:length(ts)-1
        us[i+1] = us[i] + h * f(ts[i], us[i])
    end

    return ts, us
end

end # module
