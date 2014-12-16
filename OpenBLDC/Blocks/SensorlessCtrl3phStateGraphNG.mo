within OpenBLDC.Blocks;
block SensorlessCtrl3phStateGraphNG "Commutation applying PWM"
  extends OpenBLDC.Icons.ControlLaw;
  parameter Integer PwmMode = 1 "Two-leg (1) or single-leg (2) mode";
  parameter Modelica.SIunits.Duration DelayCommutation = 5e-005
    "Delay commutation";
  parameter Modelica.SIunits.Duration TimeoutCommutation = 0.01
    "Motor has stopped when Timeout";
  // das noch an der induzierten Spannung festmachen
  Boolean chAngle;
  Integer intAngle;
  Modelica.Blocks.Interfaces.BooleanOutput hCtrl[3] annotation(Placement(transformation(extent = {{250,50},{270,70}}), iconTransformation(extent = {{80,50},{100,70}})));
  Modelica.Blocks.Interfaces.BooleanOutput lCtrl[3] annotation(Placement(transformation(extent = {{250,-70},{270,-50}}), iconTransformation(extent = {{80,-70},{100,-50}})));
  Modelica.Blocks.Interfaces.RealInput angle "Decoded hall" annotation(Placement(transformation(extent = {{-300,-20},{-260,20}})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(table = [0,0,0,0;1,1,-1,0;2,0,-1,1;3,-1,0,1;4,-1,1,0;5,0,1,-1;6,1,0,-1]) annotation(Placement(transformation(extent = {{-18,-60},{2,-40}})));
  Modelica.Blocks.Sources.IntegerExpression integerExpression[3](each y=PwmMode)
                                                                             annotation(Placement(transformation(extent = {{164,-78},{184,-58}})));
  HalfBridgeDriver halfBridgeDriver[3] annotation(Placement(transformation(extent = {{220,38},{240,58}})));
  HalfBridgeLogic halfBridgeLogic[3] annotation(Placement(transformation(extent = {{194,38},{214,58}})));
  Modelica.Blocks.Interfaces.RealInput v_dc "dc link voltage" annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 90, origin = {60,-100})));
  Modelica.Blocks.Interfaces.RealInput v[3] "voltage per phase" annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 90, origin = {0,-100})));
  Modelica.StateGraph.InitialStep initialStep(nOut = 1, nIn = 2) annotation(Placement(transformation(extent = {{-228,-30},{-208,-10}})));
  Modelica.StateGraph.StepWithSignal senseBEMF(nOut = 2, nIn=2)
                                                         annotation(Placement(transformation(extent = {{40,0},{60,20}})));
  Modelica.StateGraph.TransitionWithSignal transitionWithSignal(enableTimer = true, waitTime = 1e-007) annotation(Placement(transformation(extent = {{72,0},{92,20}})));
  replaceable DetectCommutationIntBEMF detectCommutation(DelayCommutation = DelayCommutation) annotation(Placement(transformation(extent = {{40,-32},{60,-12}})));
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot annotation(Placement(transformation(extent = {{200,80},{220,100}})));
  Modelica.StateGraph.Transition speedOK(enableTimer = false, condition = true)
    "Check speed?"                                                                             annotation(Placement(transformation(extent = {{-50,0},{-30,20}})));
  Modelica.Blocks.Interfaces.RealInput dutyCycle "Commanded duty cycle" annotation(Placement(transformation(extent = {{-300,60},{-260,100}})));
  Modelica.StateGraph.Transition delaySense(enableTimer = true, waitTime = DelayCommutation)
    "Wait some time until current crosses zero"                                                                                          annotation(Placement(transformation(extent = {{8,0},{28,20}})));
  Modelica.StateGraph.Step wait "Wait"          annotation(Placement(transformation(extent = {{-18,0},{2,20}})));
  Modelica.StateGraph.StepWithSignal stepIncrement annotation(Placement(transformation(extent = {{-88,0},{-68,20}})));
  Modelica.StateGraph.Transition catchTimeout(enableTimer = true, waitTime = 0.01, condition = true)
    "Timeout of catch start"                                                                                                  annotation(Placement(transformation(extent = {{-138,24},{-158,44}})));
  Modelica.StateGraph.TransitionWithSignal catched "Catching successful" annotation(Placement(transformation(extent = {{-138,-30},{-118,-10}})));
  CatchStart catchStart annotation(Placement(transformation(extent = {{-152,-74},{-132,-50}})));
  Modelica.StateGraph.Transition firstAction(enableTimer = true, condition = true, waitTime = 0.0001) annotation(Placement(transformation(extent = {{-202,-30},{-182,-10}})));
  Modelica.StateGraph.StepWithSignal catching(nOut = 2) annotation(Placement(transformation(extent = {{-168,-30},{-148,-10}})));
  CommutationCounter commutationCounter annotation(Placement(transformation(extent = {{-82,-70},{-62,-50}})));
  Modelica.StateGraph.StepWithSignal startRunning
    "Initialize motor angle and start PWM"                                               annotation(Placement(transformation(extent = {{-114,-30},{-94,-10}})));
  Modelica.StateGraph.Transition transition annotation(Placement(transformation(extent = {{-60,-30},{-40,-10}})));
  Modelica.StateGraph.Transition tooSlow(condition = true, enableTimer = true, waitTime = TimeoutCommutation) annotation(Placement(transformation(extent = {{86,-28},{106,-8}})));
  Modelica.StateGraph.StepWithSignal shutDownMotor
    "Shutdown motor (because of stall)"                                                annotation(Placement(transformation(extent = {{-46,42},{-66,62}})));
  Modelica.StateGraph.Transition transLoop1(enableTimer = true, condition = true, waitTime = 0.001)
    "Timeout of catch start"                                                                                                 annotation(Placement(transformation(extent = {{-252,-58},{-232,-38}})));
  Modelica.StateGraph.StepWithSignal rampMotor "Open loop motor speed ramp up" annotation(Placement(transformation(extent = {{-170,44},{-190,24}})));
  PulseLogic pulseLogic annotation(Placement(transformation(extent = {{156,38},{176,58}})));
  PulseControlSelector pulseControlSelector annotation(Placement(transformation(extent = {{128,38},{148,58}})));
  StartMotor startMotor(FinalSpeed = 200, DutyCycleStart = 0.65, StartTime = 0.3) annotation(Placement(transformation(extent = {{-164,94},{-144,114}})));
  Modelica.StateGraph.TransitionWithSignal rampDone annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 180, origin = {-212,34})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{100,-66},{112,-54}})));
equation
  intAngle = integer(angle);
  chAngle = change(intAngle);
  connect(halfBridgeLogic.pin_IN,halfBridgeDriver.pin_IN) annotation(Line(points = {{214,54},{220,54}}, color = {255,0,255}, smooth = Smooth.None));
  connect(halfBridgeLogic.pin_SD,halfBridgeDriver.pin_SD) annotation(Line(points = {{214,42},{220,42}}, color = {255,0,255}, smooth = Smooth.None));
  connect(halfBridgeDriver.lCtrl,lCtrl) annotation(Line(points = {{240,42},{246,42},{246,-60},{260,-60}}, color = {255,0,255}, smooth = Smooth.None));
  connect(halfBridgeDriver.hCtrl,hCtrl) annotation(Line(points = {{240,54},{248,54},{248,60},{260,60}}, color = {255,0,255}, smooth = Smooth.None));
  connect(integerExpression.y,halfBridgeLogic.pwm_Mode) annotation(Line(points = {{185,-68},{188,-68},{188,40},{194,40}}, color = {255,127,0}, smooth = Smooth.None));
  connect(senseBEMF.outPort[1],transitionWithSignal.inPort) annotation(Line(points = {{60.5,10.25},{70,10.25},{70,10},{78,10}}, color = {0,0,0}, smooth = Smooth.None));
  connect(detectCommutation.senseBEMF,senseBEMF.active) annotation(Line(points = {{50,-12},{50,-1}}, color = {255,0,255}, smooth = Smooth.None));
  connect(detectCommutation.bridgeState,combiTable1Ds.y) annotation(Line(points = {{40,-26},{18,-26},{18,-50},{3,-50}}, color = {0,0,127}, smooth = Smooth.None));
  connect(detectCommutation.v_dc,v_dc) annotation(Line(points = {{56,-32},{56,-100},{60,-100}}, color = {0,0,127}, smooth = Smooth.None));
  connect(detectCommutation.v,v) annotation(Line(points = {{50,-32},{50,-82},{0,-82},{0,-100}}, color = {0,0,127}, smooth = Smooth.None));
  connect(detectCommutation.y,transitionWithSignal.condition) annotation(Line(points = {{60,-26},{82,-26},{82,-2}}, color = {255,0,255}, smooth = Smooth.None));
  connect(delaySense.outPort,senseBEMF.inPort[1]) annotation(Line(points={{19.5,10},
          {30,10},{30,10.5},{39,10.5}},                                                         color = {0,0,0}, smooth = Smooth.None));
  connect(speedOK.outPort,wait.inPort[1]) annotation(Line(points={{-38.5,10},{
          -30,10},{-30,10},{-19,10}},                                                                           color = {0,0,0}, smooth = Smooth.None));
  connect(wait.outPort[1],delaySense.inPort) annotation(Line(points = {{2.5,10},{14,10}}, color = {0,0,0}, smooth = Smooth.None));
  connect(v,catchStart.v) annotation(Line(points = {{0,-100},{0,-86},{-162,-86},{-162,-60},{-152,-60}}, color = {0,0,127}, smooth = Smooth.None));
  connect(stepIncrement.outPort[1],speedOK.inPort) annotation(Line(points = {{-67.5,10},{-44,10}}, color = {0,0,0}, smooth = Smooth.None));
  connect(transitionWithSignal.outPort,stepIncrement.inPort[1]) annotation(Line(points = {{83.5,10},{100,10},{100,36},{-96,36},{-96,10},{-89,10}}, color = {0,0,0}, smooth = Smooth.None));
  connect(initialStep.outPort[1],firstAction.inPort) annotation(Line(points = {{-207.5,-20},{-196,-20}}, color = {0,0,0}, smooth = Smooth.None));
  connect(catching.active,catchStart.tryToCatch) annotation(Line(points = {{-158,-31},{-158,-68},{-152,-68}}, color = {255,0,255}, smooth = Smooth.None));
  connect(firstAction.outPort,catching.inPort[1]) annotation(Line(points = {{-190.5,-20},{-169,-20}}, color = {0,0,0}, smooth = Smooth.None));
  connect(catchStart.running,catched.condition) annotation(Line(points = {{-132,-54},{-128,-54},{-128,-32}}, color = {255,0,255}, smooth = Smooth.None));
  connect(catching.outPort[2],catched.inPort) annotation(Line(points = {{-147.5,-20.25},{-130,-20.25},{-130,-20},{-132,-20}}, color = {0,0,0}, smooth = Smooth.None));
  connect(catchStart.y,commutationCounter.phi0) annotation(Line(points = {{-132,-60},{-82,-60}}, color = {0,0,127}, smooth = Smooth.None));
  connect(catchStart.dir,commutationCounter.dir0) annotation(Line(points = {{-132,-64},{-82,-64}}, color = {0,0,127}, smooth = Smooth.None));
  connect(startRunning.active,commutationCounter.resetCounter) annotation(Line(points = {{-104,-31},{-104,-54},{-82,-54}}, color = {255,0,255}, smooth = Smooth.None));
  connect(stepIncrement.active,commutationCounter.commutate) annotation(Line(points = {{-78,-1},{-78,-28},{-76,-28},{-76,-50}}, color = {255,0,255}, smooth = Smooth.None));
  connect(startRunning.outPort[1],transition.inPort) annotation(Line(points = {{-93.5,-20},{-54,-20}}, color = {0,0,0}, smooth = Smooth.None));
  connect(senseBEMF.outPort[2],tooSlow.inPort) annotation(Line(points = {{60.5,9.75},{72,9.75},{72,-18},{92,-18}}, color = {0,0,0}, smooth = Smooth.None));
  connect(tooSlow.outPort,shutDownMotor.inPort[1]) annotation(Line(points = {{97.5,-18},{108,-18},{108,52},{-45,52}}, color = {0,0,0}, smooth = Smooth.None));
  connect(shutDownMotor.active,commutationCounter.shutdown) annotation(Line(points = {{-56,41},{-56,-12},{-68,-12},{-68,-50}}, color = {255,0,255}, smooth = Smooth.None));
  connect(transLoop1.outPort,initialStep.inPort[2]) annotation(Line(points = {{-240.5,-48},{-234,-48},{-234,-20.5},{-229,-20.5}}, color = {0,0,0}, smooth = Smooth.None));
  connect(shutDownMotor.outPort[1],transLoop1.inPort) annotation(Line(points = {{-66.5,52},{-256,52},{-256,-48},{-246,-48}}, color = {0,0,0}, smooth = Smooth.None));
  connect(catched.outPort,startRunning.inPort[1]) annotation(Line(points = {{-126.5,-20},{-115,-20}}, color = {0,0,0}, smooth = Smooth.None));
  connect(catchStart.KV,commutationCounter.KV0) annotation(Line(points = {{-132,-68},{-82,-68}}, color = {0,0,127}, smooth = Smooth.None));
  connect(commutationCounter.KV,detectCommutation.KV) annotation(Line(points = {{-72,-70},{-72,-74},{42,-74},{42,-32}}, color = {0,0,127}, smooth = Smooth.None));
  connect(commutationCounter.phi,combiTable1Ds.u) annotation(Line(points = {{-62,-60},{-42,-60},{-42,-50},{-20,-50}}, color = {0,0,127}, smooth = Smooth.None));
  connect(catching.outPort[1],catchTimeout.inPort) annotation(Line(points = {{-147.5,-19.75},{-140,-19.75},{-140,34},{-144,34}}, color = {0,0,0}, smooth = Smooth.None));
  connect(catchTimeout.outPort,rampMotor.inPort[1]) annotation(Line(points = {{-149.5,34},{-169,34}}, color = {0,0,0}, smooth = Smooth.None));
  connect(pulseLogic.bridgeModeOut,halfBridgeLogic.val) annotation(Line(points = {{176,48},{194,48}}, color = {0,0,127}, smooth = Smooth.None));
  connect(pulseLogic.y,halfBridgeLogic[1].pulses) annotation(Line(points = {{176,56},{176,55.8},{194,55.8}}, color = {255,0,255}, smooth = Smooth.None));
  connect(pulseLogic.y,halfBridgeLogic[2].pulses) annotation(Line(points = {{176,56},{176,55.8},{194,55.8}}, color = {255,0,255}, smooth = Smooth.None));
  connect(pulseLogic.y,halfBridgeLogic[3].pulses) annotation(Line(points = {{176,56},{176,55.8},{194,55.8}}, color = {255,0,255}, smooth = Smooth.None));
  connect(pulseControlSelector.dutyCycleOut,pulseLogic.dutyCycle) annotation(Line(points = {{148,56},{156,56}}, color = {0,0,127}, smooth = Smooth.None));
  connect(pulseControlSelector.bridgeModeOut,pulseLogic.bridgeModeIn) annotation(Line(points = {{148,48},{156,48}}, color = {0,0,127}, smooth = Smooth.None));
  connect(pulseControlSelector.activeOut,pulseLogic.active) annotation(Line(points = {{148,40},{156,40}}, color = {255,0,255}, smooth = Smooth.None));
  connect(combiTable1Ds.y,pulseControlSelector.bridgeModeIn1) annotation(Line(points = {{3,-50},{138,-50},{138,38}}, color = {0,0,127}, smooth = Smooth.None));
  connect(dutyCycle,pulseControlSelector.dutyCycleIn1) annotation(Line(points = {{-280,80},{114,80},{114,28},{132,28},{132,38}}, color = {0,0,127}, smooth = Smooth.None));
  connect(startMotor.dutyCycleOut,pulseControlSelector.dutyCycleIn2) annotation(Line(points = {{-144,96},{132,96},{132,58}}, color = {0,0,127}, smooth = Smooth.None));
  connect(startMotor.bridgeModeOut,pulseControlSelector.bridgeModeIn2) annotation(Line(points = {{-144,104},{138,104},{138,58}}, color = {0,0,127}, smooth = Smooth.None));
  connect(rampMotor.outPort[1],rampDone.inPort) annotation(Line(points = {{-190.5,34},{-208,34}}, color = {0,0,0}, smooth = Smooth.None));
  connect(rampDone.outPort,initialStep.inPort[1]) annotation(Line(points = {{-213.5,34},{-236,34},{-236,-19.5},{-229,-19.5}}, color = {0,0,0}, smooth = Smooth.None));
  connect(startMotor.done,rampDone.condition) annotation(Line(points = {{-158,94},{-158,66},{-212,66},{-212,46}}, color = {255,0,255}, smooth = Smooth.None));
  connect(startMotor.dutyCycleIn,dutyCycle) annotation(Line(points = {{-164,104},{-188,104},{-188,80},{-280,80}}, color = {0,0,127}, smooth = Smooth.None));
  connect(startMotor.angle,angle) annotation(Line(points = {{-164,112},{-244,112},{-244,62},{-280,62},{-280,0}}, color = {0,0,127}, smooth = Smooth.None));
  connect(rampMotor.active,pulseControlSelector.activeIn2) annotation(Line(points = {{-180,45},{-180,122},{144,122},{144,58}}, color = {255,0,255}, smooth = Smooth.None));
  connect(rampMotor.active,pulseControlSelector.select2) annotation(Line(points = {{-180,45},{-180,72},{118,72},{118,48},{128,48}}, color = {255,0,255}, smooth = Smooth.None));
  connect(rampMotor.active,startMotor.rmpStart) annotation(Line(points = {{-180,45},{-180,96},{-164,96}}, color = {255,0,255}, smooth = Smooth.None));
  connect(transition.outPort, senseBEMF.inPort[2]) annotation (Line(
      points={{-48.5,-20},{26,-20},{26,9.5},{39,9.5}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(pulseLogic.pwmControlBusConnectorOut, detectCommutation.pwmControlBusConnectorIn)
    annotation (Line(
      points={{166,38.2},{166,-40},{32,-40},{32,-18},{40,-18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(commutationCounter.pwmActive, and1.u2) annotation (Line(
      points={{-62,-66},{26,-66},{26,-64.8},{98.8,-64.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(and1.y, pulseControlSelector.activeIn1) annotation (Line(
      points={{112.6,-60},{144,-60},{144,38}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(senseBEMF.active, and1.u1) annotation (Line(
      points={{50,-1},{50,-6},{68,-6},{68,-60},{98.8,-60}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-280,
            -100},{260,140}}),                                                                        graphics), Icon(coordinateSystem(extent = {{-280,-100},{260,140}}, preserveAspectRatio = false), graphics), Documentation(info = "<html>
<p>Mit dem Rampen-algorithmus am Besten direkt auf das PWM und Br&uuml;ckentreiber gehen. Dann kann dort auch gleich der einfache Hall-Regler eingebaut werden.</p>
</html>"));
end SensorlessCtrl3phStateGraphNG;
