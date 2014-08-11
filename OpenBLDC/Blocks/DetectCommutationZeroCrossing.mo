within OpenBLDC.Blocks;
block DetectCommutationZeroCrossing
  "Detects sensorless when commutation is required by zero crossings"
  extends DetectCommutationPartial;
  Real maxBEMF "Max EMF in this cycle";
  //Modelica.Blocks.Logical.ZeroCrossing zeroCrossing;
  Boolean v_greaterthan0;
  Real time2commutate "Duration when next commutation shall happen";
  Real time_zc "Time when the zero crossing occurred";
  Real dv "Voltage derivative";
  Modelica.Blocks.Continuous.FirstOrder filtV(T = 1e-006)
    "Filters the voltage to be able to differentiate it";
initial equation
  maxBEMF = 0;
  time2commutate = 1;
  time_zc = 0;
equation
  //der(intBEMF) = if senseBEMF then senseBridgeSign * (v[senseBridgeID] - v_dc / 2) else 0;
  //zeroCrossing.enable = true;
  v_greaterthan0 = senseBridgeSign * (v[senseBridgeID] - v_dc / 2) > 0;
  //zeroCrossing.u = if senseBEMF then senseBridgeSign * (v[senseBridgeID] - v_dc / 2) else 0;
  filtV.u = senseBridgeSign * (v[senseBridgeID] - v_dc / 2);
  if senseBEMF then
    dv = der(filtV.y);
  else
    dv = 0;
  end if;
  //dv = if senseBEMF then KV*der(v[senseBridgeID]) else 0; // v darf man nicht ableiten
  der(maxBEMF) = 0;
  der(time2commutate) = 0;
  der(time_zc) = 0;
  speedOK = maxBEMF > minEMF;
  when not senseBEMF then
    reinit(time2commutate, 1);
    // hier richtige Zeit
    reinit(time_zc, 1);
    reinit(maxBEMF, 0);
elsewhen maxBEMF < abs(v[senseBridgeID] - v_dc / 2) then
    reinit(maxBEMF, abs(v[senseBridgeID] - v_dc / 2));

elsewhen pre(v_greaterthan0) == true and v_greaterthan0 == false then
    // detect negative zero crossing
    reinit(time_zc, time);
    reinit(time2commutate, sqrt(abs(-KV / dv)) / 6 - DelayCommutation);
    // hier noch dir "richtige" Zeit bestimmen und die 0.00006 ersetzen!
  end when;
  y = if time > time_zc + time2commutate and senseBEMF then true else false;
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics={  Text(extent = {{-76,60},{-12,24}}, lineColor = {0,0,255}, textString = "pulses", fontSize = 48,
            horizontalAlignment =                                                                                                    TextAlignment.Left),Text(extent = {{-76,-20},{36,-56}}, lineColor = {0,0,255}, fontSize = 48,
            horizontalAlignment =                                                                                                    TextAlignment.Left, textString = "bridgeState")}));
end DetectCommutationZeroCrossing;
