within OpenBLDC.Tests;
model AperiodicSampler
  extends BaseSampler;
  discrete Real nextSampling(start = 0);
  discrete Real periodTime(start = 1) "time-varying sample period";
equation
  doSample = time >= pre(nextSampling);
  when doSample then
    nextSampling = pre(nextSampling) + periodTime;
    periodTime = pre(periodTime) + log(pre(periodTime));
    // example
  end when;
end AperiodicSampler;