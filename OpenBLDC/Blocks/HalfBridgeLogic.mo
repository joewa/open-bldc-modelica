within OpenBLDC.Blocks;
block HalfBridgeLogic "Logics"

  Modelica.Blocks.Interfaces.BooleanOutput pin_IN
                                                 annotation(Placement(transformation(extent = {{90,50},{110,70}})));
  Modelica.Blocks.Interfaces.BooleanOutput pin_SD
                                                 annotation(Placement(transformation(extent = {{90,-70},{110,-50}})));
  Modelica.Blocks.Interfaces.RealInput val "0 or > 0 or < 0" annotation(Placement(transformation(extent = {{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.BooleanInput pulses
    "Pulses from the PWM generator"                                              annotation(Placement(transformation(extent = {{-120,58},{-80,98}})));
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
    pin_IN = hPulse;
    pin_SD = true;
  elseif val < (-0.5) then
    pin_IN = not lPulse;
    pin_SD = true;
  else
    pin_IN = false;
    pin_SD = false;
  end if;
  // High side ON
  // Low side ON
  // Half bridge OFF
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                        graphics));
end HalfBridgeLogic;
