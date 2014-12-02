within OpenBLDC.Blocks;
block DetectCommutationZeroCrossingSimple
  "Detects sensorless when commutation is required by zero crossings"
  extends DetectCommutationPartial;
  Real maxBEMF "Max EMF in this cycle";
  //Modelica.Blocks.Logical.ZeroCrossing zeroCrossing;
  Real bemf;
  Boolean v_greaterthan0;
  Real time2commutate(start = 0.006)
    "Duration when next commutation shall happen from last zero crossing";
  Real time_from_zc(start = -0.005) "Time from the last zero crossing";
initial equation
  maxBEMF = 0;
  //time2commutate = 1;
equation
  //der(intBEMF) = if senseBEMF then senseBridgeSign * (v[senseBridgeID] - v_dc / 2) else 0;
  //zeroCrossing.enable = true;
  bemf = senseBridgeSign * (v[senseBridgeID] - v_dc / 2);
  v_greaterthan0 = bemf > 0;
  der(maxBEMF) = 0;
  der(time2commutate) = 0;
  der(time_from_zc) = 1;
  speedOK = maxBEMF > minEMF;
  when senseBEMF and time_from_zc < 0 then
    //Erste Kommutierung: time_from_zc < 0 oder wenn zu langsam gewesen
    reinit(time_from_zc, 0);
    reinit(maxBEMF, 0);
elsewhen maxBEMF < abs(bemf) then
    reinit(maxBEMF, abs(bemf));

elsewhen pre(v_greaterthan0) == true and v_greaterthan0 == false then
    // detect negative zero crossing
    reinit(time_from_zc, 0);
    reinit(time2commutate, pre(time_from_zc) / 2);
    // hier noch dir "richtige" Zeit bestimmen und die 0.00006 ersetzen!
  end when;
  y = if time_from_zc > time2commutate and senseBEMF then true else false;
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics={  Text(extent=  {{-76,60},{-12,24}}, lineColor=  {0,0,255}, textString=  "pulses", fontSize=  48,
            horizontalAlignment=                                                                                                    TextAlignment.Left),Text(extent=  {{-76,-20},{36,-56}}, lineColor=  {0,0,255}, fontSize=  48,
            horizontalAlignment=                                                                                                    TextAlignment.Left, textString=  "bridgeState")}));
end DetectCommutationZeroCrossingSimple;
