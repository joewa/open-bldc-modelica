within OpenBLDC.Blocks;
block CommutationCounter
  "Counts up angular position in BLDC sensorless control mode"
  extends Modelica.Blocks.Icons.Block;
  Real dir(start=0);

  Modelica.Blocks.Interfaces.BooleanInput resetCounter
    "Reset counter with phi0"
    annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
  Modelica.Blocks.Interfaces.RealInput phi0 "Initial hall angle"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealInput dir0 "Initial rotation direction"
    annotation (Placement(transformation(extent={{-120,-80},{-80,-40}})));
  Modelica.Blocks.Interfaces.BooleanInput commutate
    "Pulse when commutation detected" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-40,100})));
  Modelica.Blocks.Interfaces.RealOutput phi(start=0) "Actual angle count"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.BooleanInput shutdown
    "Shutdown PWM and commutation" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={40,100})));
  Modelica.Blocks.Interfaces.BooleanOutput pwmActive
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
equation
  when initial() then
    phi = 0;
    dir = 0;
    pwmActive = false;//fill(false, 3);
  elsewhen resetCounter then
    phi = pre(phi0); // at resetCounter pre() breaks an algebraic loop
    dir = pre(dir0); // at resetCounter pre() breaks an algebraic loop
    pwmActive = false;//fill(false, 3);
  elsewhen commutate then
    phi = mod(pre(phi) - 1 + dir, 6) + 1;
    dir = pre(dir);
    pwmActive = true;//fill(true, 3);
  elsewhen shutdown then
    phi = 0;
    dir = 0;
    pwmActive = false;//fill(false, 3);
  end when;
  // PWM startet bei reset
  // Hier noch einen Eingang zum Ausschalten des PWM (phi=0) einfuegen.
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end CommutationCounter;
