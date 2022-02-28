within OpenBLDC.Blocks;
block CommutationCounter
  "Counts up angular position in BLDC sensorless control mode"
  extends Modelica.Blocks.Icons.Block;
  Real dir;
  // besser discrete machen? Wie dann mit phi?
  //  Real KV "Memory of motor KV";
  Modelica.Blocks.Interfaces.BooleanInput resetCounter
    "Reset counter with phi0"                                                    annotation(Placement(transformation(extent = {{-120,40},{-80,80}})));
  Modelica.Blocks.Interfaces.RealInput phi0 "Initial hall angle" annotation(Placement(transformation(extent = {{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealInput dir0 "Initial rotation direction" annotation(Placement(transformation(extent = {{-120,-60},{-80,-20}})));
  Modelica.Blocks.Interfaces.BooleanInput commutate
    "Pulse when commutation detected"                                                 annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 270, origin = {-40,100})));
  Modelica.Blocks.Interfaces.RealOutput phi(start = 0) "Actual angle count" annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.BooleanInput shutdown
    "Shutdown PWM and commutation"                                                annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 270, origin = {40,100})));
  Modelica.Blocks.Interfaces.BooleanOutput pwmActive annotation(Placement(transformation(extent = {{90,-70},{110,-50}})));
  Modelica.Blocks.Interfaces.RealInput KV0 "Motor KV" annotation(Placement(transformation(extent = {{-120,-100},{-80,-60}})));
  Modelica.Blocks.Interfaces.RealOutput KV(start = 0) "Motor voltage constant" annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {0,-100})));
initial equation
  dir = 0;
  phi = 0;
  KV = 0;
  pwmActive = false;
equation
  der(phi) = 0;
  der(dir) = 0;
  der(KV) = 0;
  when resetCounter then
    reinit(phi, phi0);
    //phi = phi0;
    reinit(dir, dir0);
    //dir = dir0;
    reinit(KV, KV0);
    pwmActive = true;
    //fill(false, 3);
  elsewhen shutdown then
    reinit(phi, 0);
    reinit(dir, 0);
    reinit(KV, 0);
    pwmActive = false;
    //fill(false, 3);
  end when;
  when commutate then
    reinit(phi, mod(pre(phi) - 1 + dir, 6) + 1);
    //pwmActive = true;
    //fill(true, 3);
  end when;

  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
end CommutationCounter;
