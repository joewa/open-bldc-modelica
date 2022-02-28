within OpenBLDC.Blocks;
partial block DetectCommutationPartial
  "I/O ports for commutation detection algorithm"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.Units.SI.Duration DelayCommutation = 5e-005
    "Delay commutation";
  parameter Real minEMF = 0.5 "Minimum EMF for good speed";
  //Real maxBEMF "Max EMF in this cycle";
  Integer bridgeStateInt[3];
  Integer senseBridgeID;
  Real senseBridgeSign;
  Modelica.Blocks.Interfaces.RealInput bridgeState[3] annotation(Placement(transformation(extent = {{-120,-60},{-80,-20}})));
  Modelica.Blocks.Interfaces.RealInput v[3] "Voltage per phase" annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 90, origin = {0,-100})));
  Modelica.Blocks.Interfaces.RealInput v_dc "dc link voltage" annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 90, origin = {60,-100})));
  Modelica.Blocks.Interfaces.BooleanInput senseBEMF "BEMF sensing active" annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 270, origin = {0,100})));
  Modelica.Blocks.Interfaces.BooleanOutput y "Commutate when true" annotation(Placement(transformation(extent = {{90,-50},{110,-30}})));
  Modelica.Blocks.Interfaces.BooleanOutput speedOK(start = false)
    "Sufficient EMF for good commutation"                                                               annotation(Placement(transformation(extent = {{90,30},{110,50}})));
  Modelica.Blocks.Interfaces.RealInput KV "Voltage constant" annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 90, origin = {-80,-100})));
  Interfaces.PwmControlBusConnectorIn pwmControlBusConnectorIn
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
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
  bridgeStateInt = integer(bridgeState);
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                        graphics), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics={  Text(extent = {{-76,60},{-12,24}}, lineColor = {0,0,255}, textString = "pulses", fontSize = 48,
            horizontalAlignment =                                                                                                   TextAlignment.Left),Text(extent = {{-76,-20},{36,-56}}, lineColor = {0,0,255}, fontSize = 48,
            horizontalAlignment =                                                                                                   TextAlignment.Left, textString = "bridgeState")}));
end DetectCommutationPartial;
