syms s
F = (s^3+4*s^2+6*s+5)/((s+8)*(s^2+8*s+3)*(s^2+5*s+7))
odwrt = ilaplace(F)

fplot(odwrt,[0,50])

ilaplace((2746*s/41+2505/82)/(5*s^2+s+6))

