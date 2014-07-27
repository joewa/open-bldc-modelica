within OpenBLDC.Blocks;
block DetectCommutationIntBEMF
  "Detects sensorless when commutation is required by back EMF integration"
  extends DetectCommutationPartial;
  Real intBEMF "int(BEMF)!";
  Real maxBEMF "Max EMF in this cycle";

initial equation
  intBEMF = 0;
  maxBEMF = 0;
equation

  der(intBEMF) = if senseBEMF then senseBridgeSign * (v[senseBridgeID] - v_dc / 2) else 0;

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
end DetectCommutationIntBEMF;
