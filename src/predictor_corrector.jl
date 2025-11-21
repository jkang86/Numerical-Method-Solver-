module PredictorCorrector

export predictor_corrector

"""
    predictor_corrector(f, u0, t0, t_end, h)

Adams–Bashforth (Predictor) +
Adams–Moulton (Corrector)
"""
function predictor_corrector(f, u0, t0, t_end, h)
    ts = collect(t0:h:t_end)
    us = zeros(length(ts))

    # Initialization using Trapezoidal Method
    us[1] = u0
    us[2] = u0 + h * f(ts[1], u0)  # simple starter (can be trapezoid)

    for i in 2:length(ts)-1
        # Predictor (Adams–Bashforth 2-step)
        up = us[i] + h * (3/2 * f(ts[i], us[i]) - 1/2 * f(ts[i-1], us[i-1]))

        # Corrector (Adams–Moulton 2-step)
        us[i+1] = us[i] + h * (5/12 * f(ts[i+1], up) +
                               2/3 * f(ts[i], us[i]) -
                               1/12 * f(ts[i-1], us[i-1]))
    end

    return ts, us
end

end # module
