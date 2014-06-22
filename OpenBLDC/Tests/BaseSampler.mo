within OpenBLDC.Tests;
partial model BaseSampler
  Real u;
  discrete output Real y;
  Boolean doSample;
  replaceable function f = Modelica.Math.atan2;
  // atan2 used as dummy
  replaceable function h = Modelica.Math.atan2;
  // default function
protected
  discrete Real x;
equation
  1 = der(u);
  when doSample then
    x = f(pre(x), u);
    // state update expression
    y = h(pre(x), u);
    // output expression
  end when;
end BaseSampler;

