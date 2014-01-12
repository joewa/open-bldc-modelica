within OpenBLDC.Blocks;
block TestCtrl3phPWM "Commutation applying PWM"

  Modelica.Blocks.Interfaces.BooleanOutput hCtrl[3] annotation(Placement(transformation(extent = {{90,50},{110,70}})));
  Modelica.Blocks.Interfaces.BooleanOutput lCtrl[3] annotation(Placement(transformation(extent = {{90,-70},{110,-50}})));
  Modelica.Blocks.Interfaces.RealInput angle "Decoded hall" annotation(Placement(transformation(extent = {{-120,-20},{-80,20}})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(table = [1,1,-1,0;2,0,-1,1;3,-1,0,1;4,-1,1,0;5,0,1,-1;6,1,0,-1]) annotation(Placement(transformation(extent = {{-60,-10},{-40,10}})));
  PulseWidthVar pulseWidth[3]
                           annotation(Placement(transformation(extent={{-30,74},
            {-10,94}})));
  Modelica.Blocks.Sources.Constant const[3](each k=0.9)
                                                  annotation(Placement(transformation(extent={{-90,78},
            {-70,98}})));
  Modelica.Blocks.Sources.Constant const2[3](each k=0.0001)
                                                      annotation(Placement(transformation(extent={{-90,48},
            {-70,68}})));
  Modelica.Blocks.Sources.IntegerExpression integerExpression[3](each y=1)
                                                                     annotation(Placement(transformation(extent={{-42,-56},
            {-22,-36}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression[3](each y=time >
        Modelica.Constants.small)
    annotation (Placement(transformation(extent={{-82,18},{-62,38}})));
  HalfBridgeDriver halfBridgeDriver[3]
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  HalfBridgeLogic halfBridgeLogic[3]
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
equation
  connect(angle,combiTable1Ds.u) annotation(Line(points = {{-100,0},{-62,0}}, color = {0,0,127}, smooth = Smooth.None));
  connect(const.y, pulseWidth.dutyCycle) annotation (Line(
      points={{-69,88},{-48,88},{-48,92},{-30,92}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const2.y, pulseWidth.periodTime) annotation (Line(
      points={{-69,58},{-54,58},{-54,84},{-30,84}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(booleanExpression.y, pulseWidth.active) annotation (Line(
      points={{-61,28},{-36,28},{-36,76},{-30,76}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(halfBridgeLogic.pin_IN, halfBridgeDriver.pin_IN) annotation (Line(
      points={{40,6},{50,6}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(halfBridgeLogic.pin_SD, halfBridgeDriver.pin_SD) annotation (Line(
      points={{40,-6},{50,-6}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(halfBridgeDriver.lCtrl, lCtrl) annotation (Line(
      points={{70,-6},{80,-6},{80,-60},{100,-60}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(halfBridgeDriver.hCtrl, hCtrl) annotation (Line(
      points={{70,6},{80,6},{80,60},{100,60}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(combiTable1Ds.y, halfBridgeLogic.val) annotation (Line(
      points={{-39,0},{20,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pulseWidth.y, halfBridgeLogic.pulses) annotation (Line(
      points={{-9,84},{6,84},{6,7.8},{20,7.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(integerExpression.y, halfBridgeLogic.pwm_Mode) annotation (Line(
      points={{-21,-46},{0,-46},{0,-8},{20,-8}},
      color={255,127,0},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                        graphics));
end TestCtrl3phPWM;

