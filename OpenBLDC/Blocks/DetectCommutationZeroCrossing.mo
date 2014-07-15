within OpenBLDC.Blocks;
block DetectCommutationZeroCrossing
  "Detects sensorless when commutation is required by zero crossings"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.SIunits.Duration DelayCommutation = 3e-005
    "Delay commutation";
  parameter Real minEMF = 0.5 "Minimum EMF for good speed";
  Real intBEMF "int(BEMF)!";
  Real maxBEMF "Max EMF in this cycle";
  Integer bridgeStateInt[3];
  Integer senseBridgeID;
  Real senseBridgeSign;
  Modelica.Blocks.Interfaces.BooleanInput pulses[3] "PWM signal" annotation(Placement(transformation(extent = {{-120,20},{-80,60}})));
  Modelica.Blocks.Interfaces.RealInput bridgeState[3] annotation(Placement(transformation(extent = {{-120,-60},{-80,-20}})));
  Modelica.Blocks.Interfaces.RealInput v[3] "Voltage per phase" annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 90, origin = {-40,-100})));
  Modelica.Blocks.Interfaces.RealInput v_dc "dc link voltage" annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 90, origin = {40,-100})));
  Modelica.Blocks.Interfaces.BooleanInput senseBEMF "BEMF sensing active" annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 270, origin = {0,100})));
  Modelica.Blocks.Interfaces.BooleanOutput y "Commutate when true"
                                             annotation(Placement(transformation(extent={{90,-50},
            {110,-30}})));
  Modelica.Blocks.Interfaces.BooleanOutput speedOK(start=false)
    "Sufficient EMF for good commutation"
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
initial equation
  intBEMF = 0;
  maxBEMF = 0;
equation
  if bridgeStateInt[1] == 0 and bridgeStateInt[2] == (-1) and bridgeStateInt[3] == 1 then
    senseBridgeID = 1;
    senseBridgeSign = 1;
  elseif bridgeStateInt[1] == 0 and bridgeStateInt[2] == 1 and bridgeStateInt[3] == (-1) then
    senseBridgeID = 1;
    senseBridgeSign = -1;
  elseif bridgeStateInt[1] == 1 and bridgeStateInt[2] == 0 and bridgeStateInt[3] == (-1) then
    senseBridgeID = 2;
    senseBridgeSign = 1;
  elseif bridgeStateInt[1] == (-1) and bridgeStateInt[2] == 0 and bridgeStateInt[3] == 1 then
    senseBridgeID = 2;
    senseBridgeSign = -1;
  elseif bridgeStateInt[1] == 1 and bridgeStateInt[2] == (-1) and bridgeStateInt[3] == 0 then
    senseBridgeID = 3;
    senseBridgeSign = -1;
  else
    senseBridgeID = 3;
    senseBridgeSign = 1;
  end if;
  der(intBEMF) = if senseBEMF then senseBridgeSign * (v[senseBridgeID] - v_dc / 2) else 0;
  bridgeStateInt = integer(bridgeState);

  der(maxBEMF) = 0;
  speedOK = maxBEMF > minEMF;
  when not senseBEMF then
    reinit(intBEMF, Modelica.Constants.small);
    reinit(maxBEMF, 0);
  elsewhen maxBEMF < abs(v[senseBridgeID] - v_dc / 2) then
    reinit(maxBEMF,  abs(v[senseBridgeID] - v_dc / 2));
  end when;
  y = if intBEMF < 0 and senseBEMF then true else false;
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                        graphics), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics={  Text(extent = {{-76,60},{-12,24}}, lineColor = {0,0,255}, textString = "pulses", fontSize = 48,
            horizontalAlignment =                                                                                                    TextAlignment.Left),Text(extent = {{-76,-20},{36,-56}}, lineColor = {0,0,255}, fontSize = 48,
            horizontalAlignment =                                                                                                    TextAlignment.Left, textString = "bridgeState")}));
end DetectCommutationZeroCrossing;
