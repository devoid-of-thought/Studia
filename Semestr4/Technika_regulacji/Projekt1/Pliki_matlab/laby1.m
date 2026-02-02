sdt1_ID = "280082";
sdt2_ID = "280141";
A = str2double(extract(sdt1_ID,6));
B = str2double(extract(sdt2_ID,6));
if A == 0 && B == 0
    A=1;
    B=1;
end
C=A+B;
syms t
f1 = A*t*exp(-B*t);
f2 = A - exp(-2*t)*(sin(t-B)+sin(t-C)*cos(t-C));
F1 = simplify(laplace(f1));
F2 = simplify(laplace(f2));
disp("F1(s):")
pretty(F1)
disp("F2(s):")
pretty(F2)

