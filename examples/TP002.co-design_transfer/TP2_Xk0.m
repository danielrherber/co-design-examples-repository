function ysolk0 = TP2_Xk0(t,f,y0,v0)
%TP2_XK0
%    YSOLK0 = TP2_XK0(T,F,Y0,V0)

%    This function was generated by the Symbolic Math Toolbox version 7.2.
%    12-Jul-2017 23:54:00

t2 = f-t;
ysolk0 = 1.0./f.^3.*t2.^2.*(f.*y0+t.*y0.*2.0+f.*t.*v0);
