within OpenBLDC.Blocks;
block HalfBridgeCtrl "Activates half bridge gates"
  Modelica.Blocks.Interfaces.BooleanOutput hCtrl annotation(Placement(transformation(extent = {{90,50},{110,70}})));
  Modelica.Blocks.Interfaces.BooleanOutput lCtrl annotation(Placement(transformation(extent = {{90,-70},{110,-50}})));
  Modelica.Blocks.Interfaces.RealInput val "0 or > 0 or < 0" annotation(Placement(transformation(extent = {{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.BooleanInput pulses "Pulses from the PWM generator" annotation(Placement(transformation(extent = {{-120,58},{-80,98}})));
  Modelica.Blocks.Interfaces.IntegerInput pwm_Mode "Set the PWM mode" annotation(Placement(transformation(extent = {{-120,-100},{-80,-60}})));
protected
  Boolean hPulse "Pulse to high side";
  Boolean lPulse "Pulse to low side";
equation
  if pwm_Mode == 1 then
    hPulse = pulses;
    lPulse = pulses;
  elseif pwm_Mode == 2 then
    hPulse = pulses;
    lPulse = true;
  else
    hPulse = false;
    lPulse = false;
  end if;
  // 2-leg PWM
  // 1-leg PWM
  if val > 0.5 then
    hCtrl = hPulse;
    lCtrl = not hPulse;
  elseif val < (-0.5) then
    hCtrl = not lPulse;
    lCtrl = lPulse;
  else
    hCtrl = false;
    lCtrl = false;
  end if;
  // High side ON
  // Low side ON
  // Half bridge OFF
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
end HalfBridgeCtrl;

