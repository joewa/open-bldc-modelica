within OpenBLDC.Blocks;
block SensorlessCtrl3phStateGraph "Commutation applying PWM"
  extends OpenBLDC.Icons.ControlLaw;
  parameter Modelica.SIunits.Duration DelayCommutation = 3e-005
    "Delay commutation";
  Boolean chAngle;
  Integer intAngle;
  Modelica.Blocks.Interfaces.BooleanOutput hCtrl[3] annotation(Placement(transformation(extent = {{230,50},{250,70}}), iconTransformation(extent = {{80,50},{100,70}})));
  Modelica.Blocks.Interfaces.BooleanOutput lCtrl[3] annotation(Placement(transformation(extent = {{230,-70},{250,-50}}), iconTransformation(extent = {{80,-70},{100,-50}})));
  Modelica.Blocks.Interfaces.RealInput angle "Decoded hall" annotation(Placement(transformation(extent = {{-120,-20},{-80,20}})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(table = [0,1,0,0;1,1,-1,0;2,0,-1,1;3,-1,0,1;4,-1,1,0;5,0,1,-1;6,1,0,-1]) annotation(Placement(transformation(extent = {{-48,14},{-28,34}})));
  PulseWidthVar pulseWidth[3] annotation(Placement(transformation(extent = {{-30,-82},{-10,-62}})));
  Modelica.Blocks.Sources.Constant const2[3](each k = 2.5e-005) annotation(Placement(transformation(extent = {{-90,-82},{-70,-62}})));
  Modelica.Blocks.Sources.IntegerExpression integerExpression[3](each y = 1) annotation(Placement(transformation(extent = {{122,-16},{142,4}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression[3](each y = time > Modelica.Constants.small) annotation(Placement(transformation(extent = {{-60,-100},{-40,-80}})));
  HalfBridgeDriver halfBridgeDriver[3] annotation(Placement(transformation(extent = {{194,8},{214,28}})));
  HalfBridgeLogic halfBridgeLogic[3] annotation(Placement(transformation(extent = {{166,8},{186,28}})));
  Modelica.Blocks.Interfaces.RealInput v_dc "dc link voltage" annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 90, origin = {60,-100})));
  Modelica.Blocks.Interfaces.RealInput v[3] "voltage per phase" annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 90, origin = {0,-100})));
  Modelica.StateGraph.InitialStep initialStep annotation(Placement(transformation(extent = {{-54,-24},{-34,-4}})));
  Modelica.StateGraph.StepWithSignal senseBEMF annotation(Placement(transformation(extent = {{40,-24},{60,-4}})));
  Modelica.StateGraph.TransitionWithSignal transitionWithSignal(enableTimer = true, waitTime = DelayCommutation / 2) annotation(Placement(transformation(extent = {{64,-24},{84,-4}})));
  DetectCommutationIntBEMF detectCommutationSimple annotation(Placement(transformation(extent = {{40,-52},{60,-32}})));
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot annotation(Placement(transformation(extent = {{200,80},{220,100}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(each y = chAngle) annotation(Placement(transformation(extent = {{-44,-46},{-24,-26}})));
  Modelica.StateGraph.TransitionWithSignal transitionWithSignal1(enableTimer = false) annotation(Placement(transformation(extent = {{-30,-24},{-10,-4}})));
  Modelica.Blocks.Interfaces.RealInput dutyCycle "Commanded duty cycle" annotation(Placement(transformation(extent = {{-120,60},{-80,100}})));
  Modelica.StateGraph.Transition delaySense(enableTimer = true, waitTime = DelayCommutation)
    "Wait some time until current crosses zero"                                                                                          annotation(Placement(transformation(extent = {{8,-24},{28,-4}})));
  Modelica.StateGraph.Step wait annotation(Placement(transformation(extent = {{-12,-24},{8,-4}})));
equation
  intAngle = integer(angle);
  chAngle = change(intAngle);
  connect(angle,combiTable1Ds.u) annotation(Line(points = {{-100,0},{-74,0},{-74,24},{-50,24}}, color = {0,0,127}, smooth = Smooth.None));
  connect(const2.y,pulseWidth.periodTime) annotation(Line(points = {{-69,-72},{-30,-72}}, color = {0,0,127}, smooth = Smooth.None));
  connect(booleanExpression.y,pulseWidth.active) annotation(Line(points = {{-39,-90},{-36,-90},{-36,-80},{-30,-80}}, color = {255,0,255}, smooth = Smooth.None));
  connect(halfBridgeLogic.pin_IN,halfBridgeDriver.pin_IN) annotation(Line(points = {{186,24},{194,24}}, color = {255,0,255}, smooth = Smooth.None));
  connect(halfBridgeLogic.pin_SD,halfBridgeDriver.pin_SD) annotation(Line(points = {{186,12},{194,12}}, color = {255,0,255}, smooth = Smooth.None));
  connect(halfBridgeDriver.lCtrl,lCtrl) annotation(Line(points = {{214,12},{220,12},{220,-60},{240,-60}}, color = {255,0,255}, smooth = Smooth.None));
  connect(halfBridgeDriver.hCtrl,hCtrl) annotation(Line(points = {{214,24},{220,24},{220,60},{240,60}}, color = {255,0,255}, smooth = Smooth.None));
  connect(combiTable1Ds.y,halfBridgeLogic.val) annotation(Line(points = {{-27,24},{122,24},{122,18},{166,18}}, color = {0,0,127}, smooth = Smooth.None));
  connect(pulseWidth.y,halfBridgeLogic.pulses) annotation(Line(points = {{-10,-72},{158,-72},{158,25.8},{166,25.8}}, color = {255,0,255}, smooth = Smooth.None));
  connect(integerExpression.y,halfBridgeLogic.pwm_Mode) annotation(Line(points = {{143,-6},{154,-6},{154,10},{166,10}}, color = {255,127,0}, smooth = Smooth.None));
  connect(senseBEMF.outPort[1],transitionWithSignal.inPort) annotation(Line(points = {{60.5,-14},{70,-14}}, color = {0,0,0}, smooth = Smooth.None));
  connect(detectCommutationSimple.senseBEMF,senseBEMF.active) annotation(Line(points = {{50,-32},{50,-25}}, color = {255,0,255}, smooth = Smooth.None));
  connect(detectCommutationSimple.pulses,pulseWidth.y) annotation(Line(points = {{40,-38},{34,-38},{34,-72},{-10,-72}}, color = {255,0,255}, smooth = Smooth.None));
  connect(detectCommutationSimple.bridgeState,combiTable1Ds.y) annotation(Line(points = {{40,-46},{28,-46},{28,24},{-27,24}}, color = {0,0,127}, smooth = Smooth.None));
  connect(detectCommutationSimple.v_dc,v_dc) annotation(Line(points={{56,-52},{
          56,-100},{60,-100}},                                                                        color = {0,0,127}, smooth = Smooth.None));
  connect(detectCommutationSimple.v,v) annotation(Line(points={{50,-52},{50,-82},
          {0,-82},{0,-100}},                                                                          color = {0,0,127}, smooth = Smooth.None));
  connect(detectCommutationSimple.y,transitionWithSignal.condition) annotation(Line(points = {{60,-46},{74,-46},{74,-26}}, color = {255,0,255}, smooth = Smooth.None));
  connect(initialStep.outPort[1],transitionWithSignal1.inPort) annotation(Line(points = {{-33.5,-14},{-24,-14}}, color = {0,0,0}, smooth = Smooth.None));
  connect(booleanExpression1.y,transitionWithSignal1.condition) annotation(Line(points = {{-23,-36},{-20,-36},{-20,-26}}, color = {255,0,255}, smooth = Smooth.None));
  connect(transitionWithSignal.outPort,initialStep.inPort[1]) annotation(Line(points = {{75.5,-14},{92,-14},{92,6},{-60,6},{-60,-14},{-55,-14}}, color = {0,0,0}, smooth = Smooth.None));
  connect(pulseWidth[1].dutyCycle,dutyCycle) annotation(Line(points = {{-30,-64},{-66,-64},{-66,80},{-100,80}}, color = {0,0,127}, smooth = Smooth.None));
  connect(dutyCycle,pulseWidth[2].dutyCycle) annotation(Line(points = {{-100,80},{-66,80},{-66,-64},{-30,-64}}, color = {0,0,127}, smooth = Smooth.None));
  connect(dutyCycle,pulseWidth[3].dutyCycle) annotation(Line(points = {{-100,80},{-66,80},{-66,-64},{-30,-64}}, color = {0,0,127}, smooth = Smooth.None));
  connect(delaySense.outPort,senseBEMF.inPort[1]) annotation(Line(points = {{19.5,-14},{39,-14}}, color = {0,0,0}, smooth = Smooth.None));
  connect(transitionWithSignal1.outPort,wait.inPort[1]) annotation(Line(points = {{-18.5,-14},{-13,-14}}, color = {0,0,0}, smooth = Smooth.None));
  connect(wait.outPort[1],delaySense.inPort) annotation(Line(points = {{8.5,-14},{14,-14}}, color = {0,0,0}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{240,100}}), graphics), Icon(coordinateSystem(extent = {{-100,-100},{240,100}}, preserveAspectRatio = false), graphics));
end SensorlessCtrl3phStateGraph;
