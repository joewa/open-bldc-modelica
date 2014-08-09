within OpenBLDC.Blocks;
block StartMotor "Select input 1 when true"
  extends Modelica.Blocks.Icons.DiscreteBlock;
  parameter Real DutyCycleStart = 0.2;
  parameter Real FinalSpeed = 200 "Speed at end of ramp [rev/s]";
  parameter Real StartTime = 0.5 "Duration of the ramp [s]";
  parameter Integer dir = 1 "Direction of start (1 or -1)";
  parameter Boolean HallAvail = false;
  Real revolutions(start = 0.4);
  Real rev_per_sec(start = 0);
  Modelica.Blocks.Interfaces.RealOutput bridgeModeOut[3] annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.BooleanInput rmpStart annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 0, origin = {-100,-80})));
  Modelica.Blocks.Interfaces.RealOutput dutyCycleOut annotation(Placement(transformation(extent = {{90,-90},{110,-70}})));
  Modelica.Blocks.Tables.CombiTable1Ds bridgeSequence(table = [0,0,0,0;1,1,-1,0;2,0,-1,1;3,-1,0,1;4,-1,1,0;5,0,1,-1;6,1,0,-1]) annotation(Placement(transformation(extent = {{40,-10},{60,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput done annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {-40,-100})));
  Modelica.Blocks.Interfaces.RealInput angle "HAll angle" annotation(Placement(transformation(extent = {{-120,60},{-80,100}})));
  Modelica.Blocks.Interfaces.RealInput dutyCycleIn "HAll angle" annotation(Placement(transformation(extent = {{-120,-20},{-80,20}})));
equation
  when rmpStart then
    //change(rmpStart) then
    reinit(revolutions, 0.4);
    reinit(rev_per_sec, 0);
  end when;
  dutyCycleOut = if HallAvail then dutyCycleIn else DutyCycleStart;
  der(rev_per_sec) = if rmpStart then FinalSpeed / StartTime else 0;
  der(revolutions) = rev_per_sec;
  bridgeSequence.u = if HallAvail then angle else mod(floor(revolutions * 6) - 1 + dir, 6) + 1;
  done = if rev_per_sec >= FinalSpeed and rmpStart then true else false;
  //hasControl = if rampStart or HallAvail then true else false; // parameter in if-eqn is doof
  //hasControl = if rmpStart then true else false; // parameter in if-eqn is doof
  connect(bridgeSequence.y,bridgeModeOut) annotation(Line(points = {{61,0},{100,0}}, color = {0,0,127}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
end StartMotor;