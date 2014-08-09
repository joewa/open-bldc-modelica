within OpenBLDC.Tests;
partial model BaseSampler
  Real u;
  discrete output Real y;
  Boolean doSample;
  // atan2 used as dummy
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