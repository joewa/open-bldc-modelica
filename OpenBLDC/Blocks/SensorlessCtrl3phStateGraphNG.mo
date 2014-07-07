within OpenBLDC.Blocks;
block SensorlessCtrl3phStateGraphNG "Commutation applying PWM"
  extends OpenBLDC.Icons.ControlLaw;
  parameter Modelica.SIunits.Duration DelayCommutation = 3e-005
    "Delay commutation";
  Boolean chAngle;
  Integer intAngle;
  Modelica.Blocks.Interfaces.BooleanOutput hCtrl[3] annotation(Placement(transformation(extent = {{230,50},{250,70}}), iconTransformation(extent = {{80,50},{100,70}})));
  Modelica.Blocks.Interfaces.BooleanOutput lCtrl[3] annotation(Placement(transformation(extent = {{230,-70},{250,-50}}), iconTransformation(extent = {{80,-70},{100,-50}})));
  Modelica.Blocks.Interfaces.RealInput angle "Decoded hall" annotation(Placement(transformation(extent={{-180,
            -20},{-140,20}})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(table=[0,0,0,0; 1,1,-1,0;
        2,0,-1,1; 3,-1,0,1; 4,-1,1,0; 5,0,1,-1; 6,1,0,-1])                                                            annotation(Placement(transformation(extent={{-42,52},
            {-22,72}})));
  PulseWidthVar pulseWidth[3] annotation(Placement(transformation(extent={{0,-74},
            {20,-54}})));
  Modelica.Blocks.Sources.Constant const2[3](each k = 2.5e-005) annotation(Placement(transformation(extent={{-58,-80},
            {-38,-60}})));
  Modelica.Blocks.Sources.IntegerExpression integerExpression[3](each y = 1) annotation(Placement(transformation(extent={{124,30},
            {144,50}})));
  HalfBridgeDriver halfBridgeDriver[3] annotation(Placement(transformation(extent={{196,38},
            {216,58}})));
  HalfBridgeLogic halfBridgeLogic[3] annotation(Placement(transformation(extent={{164,38},
            {184,58}})));
  Modelica.Blocks.Interfaces.RealInput v_dc "dc link voltage" annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 90, origin = {60,-100})));
  Modelica.Blocks.Interfaces.RealInput v[3] "voltage per phase" annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 90, origin = {0,-100})));
  Modelica.StateGraph.InitialStep initialStep(nOut=2)
                                              annotation(Placement(transformation(extent={{-108,
            -46},{-88,-26}})));
  Modelica.StateGraph.StepWithSignal senseBEMF annotation(Placement(transformation(extent={{40,-6},
            {60,14}})));
  Modelica.StateGraph.TransitionWithSignal transitionWithSignal(enableTimer=
        true, waitTime=DelayCommutation/2)                      annotation(Placement(transformation(extent={{72,-6},
            {92,14}})));
  DetectCommutationSimple detectCommutationSimple annotation(Placement(transformation(extent={{40,-56},
            {60,-36}})));
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot annotation(Placement(transformation(extent={{200,80},
            {220,100}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(each y=false)     annotation(Placement(transformation(extent={{-64,-16},
            {-44,4}})));
  Modelica.StateGraph.TransitionWithSignal speedOK(enableTimer=false)
    "Check speed?"
    annotation (Placement(transformation(extent={{-48,0},{-28,20}})));
  Modelica.Blocks.Interfaces.RealInput dutyCycle "Commanded duty cycle"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.StateGraph.Transition delaySense(enableTimer=true, waitTime=
        DelayCommutation) "Wait some time until current crosses zero"
    annotation (Placement(transformation(extent={{8,-6},{28,14}})));
  Modelica.StateGraph.Step wait(nIn=2) "Wait"
    annotation (Placement(transformation(extent={{-18,-6},{2,14}})));
  Modelica.StateGraph.Step stepIncrement
    annotation (Placement(transformation(extent={{102,-6},{122,14}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-110,28},{-90,48}})));
  Modelica.StateGraph.Transition transLoop(enableTimer=true, waitTime=1e-3)
    annotation (Placement(transformation(extent={{-130,-46},{-110,-26}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression2[3](each y=false)
    annotation (Placement(transformation(extent={{-28,-82},{-8,-62}})));
  Modelica.StateGraph.Transition transition(condition=false)
    annotation (Placement(transformation(extent={{-50,-46},{-30,-26}})));
  CatchStart catchStart
    annotation (Placement(transformation(extent={{-100,-84},{-80,-64}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=1e-6)
    annotation (Placement(transformation(extent={{-150,-90},{-130,-70}})));
equation
  intAngle = integer(angle);
  chAngle = change(intAngle);
  connect(const2.y,pulseWidth.periodTime) annotation(Line(points={{-37,-70},{
          -32,-70},{-32,-64},{0,-64}},                                                                    color = {0,0,127}, smooth = Smooth.None));
  connect(halfBridgeLogic.pin_IN,halfBridgeDriver.pin_IN) annotation(Line(points={{184,54},
          {196,54}},                                                                                  color = {255,0,255}, smooth = Smooth.None));
  connect(halfBridgeLogic.pin_SD,halfBridgeDriver.pin_SD) annotation(Line(points={{184,42},
          {196,42}},                                                                                    color = {255,0,255}, smooth = Smooth.None));
  connect(halfBridgeDriver.lCtrl,lCtrl) annotation(Line(points={{216,42},{220,
          42},{220,-60},{240,-60}},                                                                       color = {255,0,255}, smooth = Smooth.None));
  connect(halfBridgeDriver.hCtrl,hCtrl) annotation(Line(points={{216,54},{220,
          54},{220,60},{240,60}},                                                                     color = {255,0,255}, smooth = Smooth.None));
  connect(combiTable1Ds.y,halfBridgeLogic.val) annotation(Line(points={{-21,62},
          {122,62},{122,48},{164,48}},                                                                   color = {0,0,127}, smooth = Smooth.None));
  connect(pulseWidth.y,halfBridgeLogic.pulses) annotation(Line(points={{20,-64},
          {152,-64},{152,55.8},{164,55.8}},                                                                      color = {255,0,255}, smooth = Smooth.None));
  connect(integerExpression.y,halfBridgeLogic.pwm_Mode) annotation(Line(points={{145,40},
          {164,40}},                                                                                                    color = {255,127,0}, smooth = Smooth.None));
  connect(senseBEMF.outPort[1],transitionWithSignal.inPort) annotation(Line(points={{60.5,4},
          {78,4}},                                                                                          color = {0,0,0}, smooth = Smooth.None));
  connect(detectCommutationSimple.senseBEMF,senseBEMF.active) annotation(Line(points={{50,-36},
          {50,-7}},                                                                                         color = {255,0,255}, smooth = Smooth.None));
  connect(detectCommutationSimple.pulses,pulseWidth.y) annotation(Line(points={{40,-42},
          {34,-42},{34,-64},{20,-64}},                                                                                color = {255,0,255}, smooth = Smooth.None));
  connect(detectCommutationSimple.bridgeState,combiTable1Ds.y) annotation(Line(points={{40,-50},
          {28,-50},{28,62},{-21,62}},                                                                                       color = {0,0,127}, smooth = Smooth.None));
  connect(detectCommutationSimple.v_dc,v_dc) annotation(Line(points={{54,-56},{
          54,-100},{60,-100}},                                                                        color = {0,0,127}, smooth = Smooth.None));
  connect(detectCommutationSimple.v,v) annotation(Line(points={{46,-56},{46,-82},
          {0,-82},{0,-100}},                                                                          color = {0,0,127}, smooth = Smooth.None));
  connect(detectCommutationSimple.y,transitionWithSignal.condition) annotation(Line(points={{60,-46},
          {82,-46},{82,-8}},                                                                                               color = {255,0,255}, smooth = Smooth.None));
  connect(booleanExpression1.y, speedOK.condition) annotation (Line(
      points={{-43,-6},{-38,-6},{-38,-2}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(pulseWidth[1].dutyCycle, dutyCycle) annotation (Line(
      points={{0,-56},{-78,-56},{-78,80},{-120,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dutyCycle, pulseWidth[2].dutyCycle) annotation (Line(
      points={{-120,80},{-78,80},{-78,-56},{0,-56}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dutyCycle, pulseWidth[3].dutyCycle) annotation (Line(
      points={{-120,80},{-78,80},{-78,-56},{0,-56}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(delaySense.outPort, senseBEMF.inPort[1]) annotation (Line(
      points={{19.5,4},{39,4}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(speedOK.outPort, wait.inPort[1]) annotation (Line(
      points={{-36.5,10},{-30,10},{-30,4.5},{-19,4.5}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(wait.outPort[1], delaySense.inPort) annotation (Line(
      points={{2.5,4},{14,4}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transitionWithSignal.outPort, stepIncrement.inPort[1]) annotation (
      Line(
      points={{83.5,4},{101,4}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(const.y, combiTable1Ds.u) annotation (Line(
      points={{-89,38},{-70,38},{-70,62},{-44,62}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(transLoop.outPort, initialStep.inPort[1]) annotation (Line(
      points={{-118.5,-36},{-109,-36}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(booleanExpression2.y, pulseWidth.active) annotation (Line(
      points={{-7,-72},{0,-72}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(stepIncrement.outPort[1], speedOK.inPort) annotation (Line(
      points={{122.5,4},{126,4},{126,30},{-50,30},{-50,10},{-42,10}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(initialStep.outPort[1], transition.inPort) annotation (Line(
      points={{-87.5,-35.75},{-64,-35.75},{-64,-36},{-44,-36}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition.outPort, wait.inPort[2]) annotation (Line(
      points={{-38.5,-36},{-30,-36},{-30,3.5},{-19,3.5}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(initialStep.outPort[2], transLoop.inPort) annotation (Line(
      points={{-87.5,-36.25},{-82,-36.25},{-82,-56},{-132,-56},{-132,-36},{-124,
          -36}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(v, catchStart.v) annotation (Line(
      points={{0,-100},{0,-88},{-104,-88},{-104,-72.3333},{-100,-72.3333}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(booleanStep.y, catchStart.tryToCatch) annotation (Line(
      points={{-129,-80},{-114,-80},{-114,-79},{-100,-79}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-160,
            -100},{240,100}}),                                                                        graphics), Icon(coordinateSystem(extent={{-160,
            -100},{240,100}},                                                                                                    preserveAspectRatio=false),   graphics));
end SensorlessCtrl3phStateGraphNG;
