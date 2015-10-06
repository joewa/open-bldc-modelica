within OpenBLDC.Blocks;
block SensorCtrl5phStateGraphNG "Commutation applying PWM"
  extends OpenBLDC.Icons.ControlLaw;
  constant Integer m = 5 "Number of phases";
  parameter Integer PwmMode = 1 "Two-leg (1) or single-leg (2) mode";
  parameter Modelica.SIunits.Duration DelayCommutation = 20e-006
    "Delay commutation";
  parameter Modelica.SIunits.Duration TimeoutCommutation = 0.01
    "Motor has stopped when Timeout";
  // das noch an der induzierten Spannung festmachen
  Boolean chAngle;
  Integer intAngle;
  Modelica.Blocks.Interfaces.BooleanOutput hCtrl[m] annotation(Placement(transformation(extent = {{250,50},{270,70}}), iconTransformation(extent = {{80,50},{100,70}})));
  Modelica.Blocks.Interfaces.BooleanOutput lCtrl[m] annotation(Placement(transformation(extent = {{250,-70},{270,-50}}), iconTransformation(extent = {{80,-70},{100,-50}})));
  Modelica.Blocks.Interfaces.RealInput angle "Decoded hall" annotation(Placement(transformation(extent = {{-300,-20},{-260,20}})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(table=[0,0,0,0,0.0,0.0; 1,1,
        -1,0,0.0,0.0; 2,0,-1,1,0.0,0.0; 3,-1,0,1,0.0,0.0; 4,-1,1,0,0.0,0.0; 5,0,
        1,-1,0.0,0.0; 6,1,0,-1,0.0,0.0])                                                                                      annotation(Placement(transformation(extent={{52,24},
            {72,44}})));
  Modelica.Blocks.Sources.IntegerExpression integerExpression[m](each y=PwmMode)
                                                                             annotation(Placement(transformation(extent = {{164,-78},{184,-58}})));
  Modelica.Blocks.Interfaces.RealInput v_dc "dc link voltage" annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 90, origin = {60,-100})));
  Modelica.Blocks.Interfaces.RealInput v[m] "voltage per phase" annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 90, origin = {0,-100})));
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot annotation(Placement(transformation(extent = {{200,80},{220,100}})));
  Modelica.Blocks.Interfaces.RealInput dutyCycle "Commanded duty cycle" annotation(Placement(transformation(extent = {{-300,60},{-260,100}})));
  PulseLogicNph
             pulseLogic annotation(Placement(transformation(extent={{156,38},{176,
            58}})));
  HalfBridgeLogicBLDC halfBridgeLogicINSD[m]
    annotation (Placement(transformation(extent={{198,38},{218,58}})));
  Modelica.Blocks.Sources.BooleanStep switchOn(startTime=0.1e-3)
    annotation (Placement(transformation(extent={{118,-10},{138,10}})));
  Modelica.Blocks.Sources.Constant const(k=7)
    annotation (Placement(transformation(extent={{-104,24},{-84,44}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-60,24},{-40,44}})));
  PhaseDiffVoltageNph phaseDiffVoltageNph(m=m)
    annotation (Placement(transformation(extent={{10,-66},{30,-46}})));
equation
  intAngle = integer(angle);
  chAngle = change(intAngle);
  connect(pulseLogic.bridgeModeOut, halfBridgeLogicINSD.val) annotation (Line(
      points={{176,48},{198,48}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(integerExpression.y, halfBridgeLogicINSD.pwm_Mode) annotation (Line(
      points={{185,-68},{190,-68},{190,40},{198,40}},
      color={255,127,0},
      smooth=Smooth.None));
  for i in 1:m loop
    connect(pulseLogic.y, halfBridgeLogicINSD[i].pulses) annotation (Line(
      points={{176,56},{188,56},{188,55.8},{198,55.8}},
      color={255,0,255},
      smooth=Smooth.None));
  end for;
  connect(halfBridgeLogicINSD.hCtrl, hCtrl) annotation (Line(
      points={{218,54},{236,54},{236,60},{260,60}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(halfBridgeLogicINSD.lCtrl, lCtrl) annotation (Line(
      points={{218,42},{238,42},{238,-60},{260,-60}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(dutyCycle, pulseLogic.dutyCycle) annotation (Line(
      points={{-280,80},{-62,80},{-62,56},{156,56}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(combiTable1Ds.y, pulseLogic.bridgeModeIn) annotation (Line(
      points={{73,34},{114,34},{114,48},{156,48}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(switchOn.y, pulseLogic.active) annotation (Line(
      points={{139,0},{148,0},{148,40},{156,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(const.y, feedback.u1) annotation (Line(
      points={{-83,34},{-58,34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(angle, feedback.u2) annotation (Line(
      points={{-280,0},{-50,0},{-50,26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(angle, combiTable1Ds.u) annotation (Line(
      points={{-280,0},{20,0},{20,34},{50,34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(v, phaseDiffVoltageNph.u) annotation (Line(
      points={{0,-100},{0,-56},{10,-56}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-280,
            -100},{260,140}}),                                                                        graphics), Icon(coordinateSystem(extent = {{-280,-100},{260,140}}, preserveAspectRatio = false), graphics), Documentation(info = "<html>
<p>Mit dem Rampen-algorithmus am Besten direkt auf das PWM und Br&uuml;ckentreiber gehen. Dann kann dort auch gleich der einfache Hall-Regler eingebaut werden.</p>
</html>"));
end SensorCtrl5phStateGraphNG;
