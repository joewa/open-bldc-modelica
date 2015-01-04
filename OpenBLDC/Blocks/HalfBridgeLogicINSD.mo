within OpenBLDC.Blocks;
block HalfBridgeLogicINSD "Generate the gate signals with IN / SD driver"
  extends Modelica.Blocks.Icons.BooleanBlock;
  Modelica.Blocks.Interfaces.RealInput val "0 or > 0 or < 0" annotation(Placement(transformation(extent = {{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.BooleanInput pulses
    "Pulses from the PWM generator"                                              annotation(Placement(transformation(extent = {{-120,58},{-80,98}})));
  Modelica.Blocks.Interfaces.IntegerInput pwm_Mode "Set the PWM mode" annotation(Placement(transformation(extent = {{-120,-100},{-80,-60}})));

  Modelica.Blocks.Interfaces.BooleanOutput hCtrl annotation(Placement(transformation(extent={{90,50},
            {110,70}})));
  Modelica.Blocks.Interfaces.BooleanOutput lCtrl annotation(Placement(transformation(extent={{90,-70},
            {110,-50}})));
  HalfBridgeLogic halfBridgeLogic
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  HalfBridgeDriver halfBridgeDriver
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
equation

  connect(val, halfBridgeLogic.val) annotation (Line(
      points={{-100,0},{-40,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pulses, halfBridgeLogic.pulses) annotation (Line(
      points={{-100,78},{-70,78},{-70,7.8},{-40,7.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(pwm_Mode, halfBridgeLogic.pwm_Mode) annotation (Line(
      points={{-100,-80},{-70,-80},{-70,-8},{-40,-8}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(halfBridgeLogic.pin_IN, halfBridgeDriver.pin_IN) annotation (Line(
      points={{-20,6},{20,6}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(halfBridgeLogic.pin_SD, halfBridgeDriver.pin_SD) annotation (Line(
      points={{-20,-6},{20,-6}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(halfBridgeDriver.hCtrl, hCtrl) annotation (Line(
      points={{40,6},{66,6},{66,60},{100,60}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(halfBridgeDriver.lCtrl, lCtrl) annotation (Line(
      points={{40,-6},{66,-6},{66,-60},{100,-60}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                        graphics));
end HalfBridgeLogicINSD;
