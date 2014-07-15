within OpenBLDC.Blocks;
block SensorlessCtrl3phStateGraphNG "Commutation applying PWM"
  extends OpenBLDC.Icons.ControlLaw;
  parameter Modelica.SIunits.Duration DelayCommutation = 3e-5
    "Delay commutation";
  parameter Modelica.SIunits.Duration TimeoutCommutation = 10e-3
    "Motor has stopped when Timeout"; // das noch an der induzierten Spannung festmachen
  Boolean chAngle;
  Integer intAngle;
  Modelica.Blocks.Interfaces.BooleanOutput hCtrl[3] annotation(Placement(transformation(extent = {{230,50},{250,70}}), iconTransformation(extent = {{80,50},{100,70}})));
  Modelica.Blocks.Interfaces.BooleanOutput lCtrl[3] annotation(Placement(transformation(extent = {{230,-70},{250,-50}}), iconTransformation(extent = {{80,-70},{100,-50}})));
  Modelica.Blocks.Interfaces.RealInput angle "Decoded hall" annotation(Placement(transformation(extent={{-300,
            -20},{-260,20}})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(table=[0,0,0,0; 1,1,-1,0;
        2,0,-1,1; 3,-1,0,1; 4,-1,1,0; 5,0,1,-1; 6,1,0,-1])                                                            annotation(Placement(transformation(extent={{-18,-70},
            {2,-50}})));
  PulseWidthVar pulseWidth[3] annotation(Placement(transformation(extent={{0,72},{
            20,92}})));
  Modelica.Blocks.Sources.Constant const2[3](each k = 2.5e-005) annotation(Placement(transformation(extent={{-54,66},
            {-34,86}})));
  Modelica.Blocks.Sources.IntegerExpression integerExpression[3](each y = 1) annotation(Placement(transformation(extent={{124,30},
            {144,50}})));
  HalfBridgeDriver halfBridgeDriver[3] annotation(Placement(transformation(extent={{196,38},
            {216,58}})));
  HalfBridgeLogic halfBridgeLogic[3] annotation(Placement(transformation(extent={{164,38},
            {184,58}})));
  Modelica.Blocks.Interfaces.RealInput v_dc "dc link voltage" annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 90, origin = {60,-100})));
  Modelica.Blocks.Interfaces.RealInput v[3] "voltage per phase" annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 90, origin = {0,-100})));
  Modelica.StateGraph.InitialStep initialStep(nOut=1, nIn=2)
                                              annotation(Placement(transformation(extent={{-228,
            -30},{-208,-10}})));
  Modelica.StateGraph.StepWithSignal senseBEMF(nOut=2)
                                               annotation(Placement(transformation(extent={{40,-6},
            {60,14}})));
  Modelica.StateGraph.TransitionWithSignal transitionWithSignal(enableTimer=
        true, waitTime=DelayCommutation/2)                      annotation(Placement(transformation(extent={{72,-6},
            {92,14}})));
  replaceable DetectCommutationIntBEMF detectCommutationSimple
    annotation (Placement(transformation(extent={{40,-56},{60,-36}})));
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot annotation(Placement(transformation(extent={{200,80},
            {220,100}})));
  Modelica.StateGraph.Transition           speedOK(enableTimer=false, condition=
       true) "Check speed?"
    annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
  Modelica.Blocks.Interfaces.RealInput dutyCycle "Commanded duty cycle"
    annotation (Placement(transformation(extent={{-300,60},{-260,100}})));
  Modelica.StateGraph.Transition delaySense(enableTimer=true, waitTime=
        DelayCommutation) "Wait some time until current crosses zero"
    annotation (Placement(transformation(extent={{8,-6},{28,14}})));
  Modelica.StateGraph.Step wait(nIn=2) "Wait"
    annotation (Placement(transformation(extent={{-18,-6},{2,14}})));
  Modelica.StateGraph.StepWithSignal
                           stepIncrement
    annotation (Placement(transformation(extent={{-88,0},{-68,20}})));
  Modelica.StateGraph.Transition transLoop(enableTimer=true,
    waitTime=10e-3,
    condition=true) "Timeout of catch start"
    annotation (Placement(transformation(extent={{-252,-22},{-232,-2}})));
  Modelica.StateGraph.TransitionWithSignal catched "Catching successful"
    annotation (Placement(transformation(extent={{-138,-30},{-118,-10}})));
  CatchStart catchStart
    annotation (Placement(transformation(extent={{-154,-74},{-134,-50}})));
  Modelica.StateGraph.Transition firstAction(
    enableTimer=true,
    condition=true,
    waitTime=0.1e-3)
    annotation (Placement(transformation(extent={{-202,-30},{-182,-10}})));
  Modelica.StateGraph.StepWithSignal catching(nOut=2)
    annotation (Placement(transformation(extent={{-168,-30},{-148,-10}})));
  CommutationCounter commutationCounter
    annotation (Placement(transformation(extent={{-76,-70},{-56,-50}})));
  Modelica.StateGraph.StepWithSignal startRunning
    "Initialize motor angle and start PWM"
    annotation (Placement(transformation(extent={{-114,-30},{-94,-10}})));
  Modelica.StateGraph.Transition transition
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Modelica.StateGraph.Transition tooSlow(
    condition=true,
    enableTimer=true,
    waitTime=TimeoutCommutation)
    annotation (Placement(transformation(extent={{86,-38},{106,-18}})));
  Modelica.StateGraph.StepWithSignal stepWithSignal
    annotation (Placement(transformation(extent={{-46,36},{-66,56}})));
  Modelica.StateGraph.Transition transLoop1(
                                           enableTimer=true,
    condition=true,
    waitTime=1e-3) "Timeout of catch start"
    annotation (Placement(transformation(extent={{-252,-58},{-232,-38}})));
equation
  intAngle = integer(angle);
  chAngle = change(intAngle);
  connect(const2.y,pulseWidth.periodTime) annotation(Line(points={{-33,76},{-32,
          76},{-32,82},{0,82}},                                                                           color = {0,0,127}, smooth = Smooth.None));
  connect(halfBridgeLogic.pin_IN,halfBridgeDriver.pin_IN) annotation(Line(points={{184,54},
          {196,54}},                                                                                  color = {255,0,255}, smooth = Smooth.None));
  connect(halfBridgeLogic.pin_SD,halfBridgeDriver.pin_SD) annotation(Line(points={{184,42},
          {196,42}},                                                                                    color = {255,0,255}, smooth = Smooth.None));
  connect(halfBridgeDriver.lCtrl,lCtrl) annotation(Line(points={{216,42},{220,
          42},{220,-60},{240,-60}},                                                                       color = {255,0,255}, smooth = Smooth.None));
  connect(halfBridgeDriver.hCtrl,hCtrl) annotation(Line(points={{216,54},{220,
          54},{220,60},{240,60}},                                                                     color = {255,0,255}, smooth = Smooth.None));
  connect(combiTable1Ds.y,halfBridgeLogic.val) annotation(Line(points={{3,-60},
          {138,-60},{138,48},{164,48}},                                                                  color = {0,0,127}, smooth = Smooth.None));
  connect(pulseWidth.y,halfBridgeLogic.pulses) annotation(Line(points={{20,82},
          {152,82},{152,55.8},{164,55.8}},                                                                       color = {255,0,255}, smooth = Smooth.None));
  connect(integerExpression.y,halfBridgeLogic.pwm_Mode) annotation(Line(points={{145,40},
          {164,40}},                                                                                                    color = {255,127,0}, smooth = Smooth.None));
  connect(senseBEMF.outPort[1],transitionWithSignal.inPort) annotation(Line(points={{60.5,
          4.25},{70,4.25},{70,4},{78,4}},                                                                   color = {0,0,0}, smooth = Smooth.None));
  connect(detectCommutationSimple.senseBEMF,senseBEMF.active) annotation(Line(points={{50,-36},
          {50,-7}},                                                                                         color = {255,0,255}, smooth = Smooth.None));
  connect(detectCommutationSimple.pulses,pulseWidth.y) annotation(Line(points={{40,-42},
          {34,-42},{34,82},{20,82}},                                                                                  color = {255,0,255}, smooth = Smooth.None));
  connect(detectCommutationSimple.bridgeState,combiTable1Ds.y) annotation(Line(points={{40,-50},
          {28,-50},{28,-60},{3,-60}},                                                                                       color = {0,0,127}, smooth = Smooth.None));
  connect(detectCommutationSimple.v_dc,v_dc) annotation(Line(points={{54,-56},{
          54,-100},{60,-100}},                                                                        color = {0,0,127}, smooth = Smooth.None));
  connect(detectCommutationSimple.v,v) annotation(Line(points={{46,-56},{46,-82},
          {0,-82},{0,-100}},                                                                          color = {0,0,127}, smooth = Smooth.None));
  connect(detectCommutationSimple.y,transitionWithSignal.condition) annotation(Line(points={{60,-50},
          {82,-50},{82,-8}},                                                                                               color = {255,0,255}, smooth = Smooth.None));
  connect(pulseWidth[1].dutyCycle, dutyCycle) annotation (Line(
      points={{0,90},{-140,90},{-140,80},{-280,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dutyCycle, pulseWidth[2].dutyCycle) annotation (Line(
      points={{-280,80},{-140,80},{-140,90},{0,90}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dutyCycle, pulseWidth[3].dutyCycle) annotation (Line(
      points={{-280,80},{-140,80},{-140,90},{0,90}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(delaySense.outPort, senseBEMF.inPort[1]) annotation (Line(
      points={{19.5,4},{39,4}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(speedOK.outPort, wait.inPort[1]) annotation (Line(
      points={{-38.5,10},{-30,10},{-30,4.5},{-19,4.5}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(wait.outPort[1], delaySense.inPort) annotation (Line(
      points={{2.5,4},{14,4}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transLoop.outPort, initialStep.inPort[1]) annotation (Line(
      points={{-240.5,-12},{-234,-12},{-234,-19.5},{-229,-19.5}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(v, catchStart.v) annotation (Line(
      points={{0,-100},{0,-86},{-162,-86},{-162,-60},{-154,-60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(stepIncrement.outPort[1], speedOK.inPort) annotation (Line(
      points={{-67.5,10},{-44,10}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transitionWithSignal.outPort, stepIncrement.inPort[1]) annotation (
      Line(
      points={{83.5,4},{100,4},{100,30},{-96,30},{-96,10},{-89,10}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(initialStep.outPort[1], firstAction.inPort) annotation (Line(
      points={{-207.5,-20},{-196,-20}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(catching.active, catchStart.tryToCatch) annotation (Line(
      points={{-158,-31},{-158,-68},{-154,-68}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(firstAction.outPort, catching.inPort[1]) annotation (Line(
      points={{-190.5,-20},{-169,-20}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(catchStart.running, catched.condition) annotation (Line(
      points={{-134,-54},{-128,-54},{-128,-32}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(catching.outPort[1], transLoop.inPort) annotation (Line(
      points={{-147.5,-19.75},{-140,-19.75},{-140,8},{-250,8},{-250,-12},{-246,
          -12}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(catching.outPort[2], catched.inPort) annotation (Line(
      points={{-147.5,-20.25},{-130,-20.25},{-130,-20},{-132,-20}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(catchStart.y, commutationCounter.phi0) annotation (Line(
      points={{-134,-60},{-76,-60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(catchStart.dir, commutationCounter.dir0) annotation (Line(
      points={{-134,-64},{-76,-64}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(startRunning.active, commutationCounter.resetCounter) annotation (
      Line(
      points={{-104,-31},{-104,-54},{-76,-54}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(stepIncrement.active, commutationCounter.commutate) annotation (Line(
      points={{-78,-1},{-78,-28},{-70,-28},{-70,-50}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(transition.outPort, wait.inPort[2]) annotation (Line(
      points={{-48.5,-20},{-24,-20},{-24,3.5},{-19,3.5}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(startRunning.outPort[1], transition.inPort) annotation (Line(
      points={{-93.5,-20},{-54,-20}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(commutationCounter.pwmActive, pulseWidth[1].active) annotation (Line(
      points={{-56,-66},{-28,-66},{-28,74},{0,74}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(commutationCounter.pwmActive, pulseWidth[2].active) annotation (Line(
      points={{-56,-66},{-28,-66},{-28,74},{0,74}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(commutationCounter.pwmActive, pulseWidth[3].active) annotation (Line(
      points={{-56,-66},{-28,-66},{-28,74},{0,74}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(senseBEMF.outPort[2], tooSlow.inPort) annotation (Line(
      points={{60.5,3.75},{72,3.75},{72,-28},{92,-28}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(tooSlow.outPort, stepWithSignal.inPort[1]) annotation (Line(
      points={{97.5,-28},{108,-28},{108,46},{-45,46}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(stepWithSignal.active, commutationCounter.shutdown) annotation (Line(
      points={{-56,35},{-56,-12},{-62,-12},{-62,-50}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(transLoop1.outPort, initialStep.inPort[2]) annotation (Line(
      points={{-240.5,-48},{-234,-48},{-234,-20.5},{-229,-20.5}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(stepWithSignal.outPort[1], transLoop1.inPort) annotation (Line(
      points={{-66.5,46},{-256,46},{-256,-48},{-246,-48}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(commutationCounter.phi, combiTable1Ds.u) annotation (Line(
      points={{-56,-60},{-20,-60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(catched.outPort, startRunning.inPort[1]) annotation (Line(
      points={{-126.5,-20},{-115,-20}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(catchStart.KV, commutationCounter.KV0) annotation (Line(
      points={{-134,-68},{-76,-68}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-280,
            -100},{240,100}}),                                                                        graphics), Icon(coordinateSystem(extent={{-280,
            -100},{240,100}},                                                                                                    preserveAspectRatio=false),   graphics));
end SensorlessCtrl3phStateGraphNG;
