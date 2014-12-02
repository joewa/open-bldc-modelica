within OpenBLDC.Blocks;
block DetectCommutationIntBEMFext
  "Detects sensorless when commutation is required by back EMF integration - extended method"
  extends DetectCommutationPartial;
  parameter Integer bufsize = 50 "Size of buffer";
  parameter Real period_adc = 1e-6;
  discrete Real v_buffer[bufsize](start=zeros(bufsize));
  Integer zc_index(start=bufsize)
    "Index in the ADC-buffer where the zero crossing occurs";
  discrete Real duration_zc2comm(start=0)
    "Duration from zero crossing to next commutation";
  discrete Real time_blockstart(start=0) "Time when last block started";
  discrete Real time_zc(start=0) "Time when last zero crossing occured";
  Real bemf "Back EMF at the open phase";
  discrete Real intBEMF(start=0) "int(BEMF)!";
  //Real intBEMFext;
  discrete Real maxBEMF(start=0) "Max EMF in this cycle";
  Real v_sense "Sensed voltage at the open motor pin, referenced to v_dc/2";
  Boolean y_neu(start=false);
algorithm
  v_sense := v[senseBridgeID] - v_dc / 2;
  bemf := senseBridgeSign * v_sense;

  when senseBEMF then
    intBEMF :=KV;
    maxBEMF:= 0;
    time_blockstart := time;
    for f in 1:bufsize loop
      v_buffer[f] := 0;
    end for;
    zc_index := bufsize;
    //anstieg :=0;
  end when;
  when maxBEMF < abs(v_sense) then
    // das ist fragwürdig
    maxBEMF :=abs(v_sense);
  end when;
  speedOK :=true;//maxBEMF > minEMF; TODO

  when (senseBEMF and sample(0, period_adc)) then
    for f in 1:(bufsize-1) loop
      v_buffer[f] := v_buffer[f+1]; // Shift buffer (ugly)
      if v_buffer[f] > 0 then //and v_buffer[f+1] < 0 then
        zc_index := f; // index of last value > 0
      end if;
    end for;
    v_buffer[bufsize] := bemf; // Add new value to buffer
    // Extended method
    if zc_index == 25 then
      time_zc := time - 25*period_adc;
      duration_zc2comm := sqrt(-(2*KV*(10+10)*period_adc/(v_buffer[35]-v_buffer[15])));
    end if;
    if time_zc+duration_zc2comm < time and time_zc+duration_zc2comm+period_adc > time then
      y_neu := true; // Puls erzeugen
    else
      y_neu := false;
    end if;

    if bemf < 0 then // Alte Methode: Integriere ab Nulldurchgang
      intBEMF := intBEMF + bemf*period_adc;
    end if;
  end when;

  y :=if intBEMF < 0 and senseBEMF then true else false;
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics={  Text(extent=  {{-76,60},{-12,24}}, lineColor=  {0,0,255}, textString=  "pulses", fontSize=  48,
            horizontalAlignment=                                                                                                    TextAlignment.Left),Text(extent=  {{-76,-20},{36,-56}}, lineColor=  {0,0,255}, fontSize=  48,
            horizontalAlignment=                                                                                                    TextAlignment.Left, textString=  "bridgeState")}),
    Documentation(info="<html>
<p>This block implements the extended back-emf integration method.</p>
<p>It determines the time of a zero crossing by evaluating the slope of the back-emf. In the next step, the slope is also used to calculate the time when the next commutation is required.</p>
<p>TODO:</p>
<p>1. Implement the ADC-DMA-method and evaluate the measurements only when the ADC callback is executed.</p>
<p>2. In case the single-leg-PWM is applied, evaluate only the measurements when high side switch is on.</p>
<p>3. In case the function is called late, i.e. the zero crossing already happened, use the earliest voltage measurements and slope to determine when the zero crossing occured.</p>
</html>"));
end DetectCommutationIntBEMFext;
