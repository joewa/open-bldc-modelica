within OpenBLDC.Blocks;
block DetectCommutationIntBEMFext
  "Detects sensorless when commutation is required by back EMF integration - extended method"
  extends DetectCommutationPartial;
  parameter Boolean sampleAll = true "Sample only on pulses when false";
  parameter Integer bufsize = 10 "Size of buffer";
  parameter Real period_adc = 1e-6;
  parameter Modelica.SIunits.Time Ts_ADC = 1e-6 "Sample rate of ADC";
  parameter Real vdivider = 3.6/13.6 "Voltage divider of phase voltage";
  parameter Integer NREG = 10 "Number of elements for a valid regression";
  Integer v_dc_int(start=0) "ADC value of dc link voltage";
  Integer k_cb_ADC(start=0) "Increments at each the ADC callback";
  Integer sumx(start=0) "computes sum of x (time-axis)";
  Integer sumx2(start=0) "computes sum of x**2";
  Integer sumxy(start=0) "computes sum of x * y";
  Integer sumy(start=0) "computes sum of y";
  Integer sumy2(start=0) "computes sum of y**2";
  Integer n_reg(start=0) "number of elements in list";
  Integer yreg[NREG](start=zeros(NREG)) "Circular buffer for y";
  Integer xreg[NREG](start=zeros(NREG)) "Circular buffer for x";
  Integer k_sample(start=0) "Sample in the present commutation cycle";
  Integer pwm_dutyCycle_int;
  Integer pwm_period_int "PWM period relating to period_adc";
  Integer k_pwm_period(start=0) "Indicates if the pwm sample ocurred at pwm-on";
  Integer k_zc(start=0) "Sample when the zero crossing occurs";
  Integer KV_int(start=0) "Integer equivalent of KV";
  discrete Real duration_zc2comm_int(start=0)
    "Duration from zero crossing to next commutation";
  discrete Real m_reg(start=0) "Slope";
  discrete Real b_reg(start=0) "y-intercept";
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
  Sensors.ADCs.AdcSingleBufferedInteger adcSingleBufferedInteger(BufDepth=
        bufsize, Ts=Ts_ADC)
    annotation (Placement(transformation(extent={{-28,8},{-8,28}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-10,-8},{10,12}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage
    annotation (Placement(transformation(extent={{-28,34},{-8,54}})));

algorithm
  when not senseBEMF then
    k_cb_ADC := 0;
    sumx := 0;
    sumx2 := 0;
    sumxy := 0;
    sumy := 0;
    sumy2 := 0;
    xreg := zeros(NREG);
    yreg := zeros(NREG);
    m_reg := 0;
    n_reg := 0;
  end when;
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

  //Neueste Variante mit ADC-Modell
  when adcSingleBufferedInteger.adcSingleIntegerBus.cbStart then
    //sumx := 0;
    //sumx2 := 0;
    //sumxy := 0;
    //sumy := 0;
    //sumy2 := 0;
    pwm_dutyCycle_int := integer(floor(10000 * pwmControlBusConnectorIn.dutyCycle));
    pwm_period_int := integer(pwmControlBusConnectorIn.period / period_adc);
    // CAUTION: pwm_period_int works only if period / period_adc has no fraction
    v_dc_int := integer(floor(v_dc*vdivider*4096/3)); // ADC value
    KV_int := integer(KV * v_dc*vdivider*4096/3 / period_adc);
    for f in 1:bufsize loop
      k_sample := bufsize * k_cb_ADC + f;
      // Store valid measurements in the table (e.g. high side switch is on)
      // TODO Add a proper condition here
      //if pulses then
      k_pwm_period := mod(k_sample, pwm_period_int);
      if (k_pwm_period >= 1 and k_pwm_period < ((pwm_dutyCycle_int * pwm_period_int)/10000)) or sampleAll then
        if n_reg < NREG then
          n_reg := n_reg + 1;
        end if;
        //if n_reg >= NREG then // decrement obsolete buffer values from sums
         sumx := sumx - xreg[1];
         sumx2 := sumx2 - xreg[1]*xreg[1];
         sumxy := sumxy - xreg[1]*yreg[1];
         sumy := sumy - yreg[1];
         sumy2 := sumy2 - yreg[1]*yreg[1];
        //end if;
        //if n_reg > 1 then
          for f2 in 2:NREG loop
            yreg[f2-1] := yreg[f2]; // Shift buffer (ugly)
            xreg[f2-1] := xreg[f2]; // Shift buffer (ugly)
          end for;
        //end if;
        yreg[NREG] := integer( senseBridgeSign*(adcSingleBufferedInteger.adcSingleIntegerBus.buffer[f] - v_dc_int / 2));
        xreg[NREG] := k_sample; // Sample-number in actual commutation cycle
        sumx := sumx + xreg[NREG];
        sumx2 := sumx2 + xreg[NREG]*xreg[NREG];
        sumxy := sumxy + xreg[NREG]*yreg[NREG];
        sumy := sumy + yreg[NREG];
        sumy2 := sumy2 + yreg[NREG]*yreg[NREG];
      end if;
    end for;
    // Check if we are ready to calculate slope and zero crossing (sufficient values and time)
    // TODO Add a proper condition here
    if (n_reg >= NREG and not (n_reg * sumx2 == sumx * sumx)) then
      m_reg := (n_reg * sumxy  -  sumx * sumy) / (n_reg * sumx2  -  sumx * sumx);
      //m_reg := (yreg[2]-yreg[1])/(xreg[2]-xreg[1]);
      b_reg := (sumy * sumx2  -  sumx * sumxy) / (n_reg * sumx2  -  sumx * sumx);
      if m_reg < -0.1 then // slope must not be zero
        k_zc := integer( -b_reg / m_reg);
        if k_zc < k_sample then // the zero crossing shall have occurred in the past
          duration_zc2comm_int := sqrt(-(2*KV / m_reg));
        end if;
      end if;
    end if;
    // Hier schon Counter zur Zeitmessung mitlaufen lassen: bei jedem Callback +1
    k_cb_ADC := k_cb_ADC + 1;
  end when;

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

equation
  v_sense = v[senseBridgeID] - v_dc / 2;
  bemf = senseBridgeSign * v_sense;
  signalVoltage.v = v[senseBridgeID] * vdivider;
  adcSingleBufferedInteger.adcSingleIntegerBus.active = senseBEMF;
  connect(adcSingleBufferedInteger.pin_n, ground.p) annotation (Line(
      points={{-8,18},{0,18},{0,12}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(signalVoltage.n, adcSingleBufferedInteger.pin_n) annotation (Line(
      points={{-8,44},{-8,18}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(signalVoltage.p, adcSingleBufferedInteger.pin_p) annotation (Line(
      points={{-28,44},{-28,18}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                        graphics), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics={  Text(extent = {{-76,60},{-12,24}}, lineColor = {0,0,255}, textString = "pulses", fontSize = 48,
            horizontalAlignment =                                                                                                   TextAlignment.Left),Text(extent = {{-76,-20},{36,-56}}, lineColor = {0,0,255}, fontSize = 48,
            horizontalAlignment =                                                                                                   TextAlignment.Left, textString = "bridgeState")}),
    Documentation(info="<html>
<p>This block implements the extended back-emf integration method.</p>
<p>It determines the time of a zero crossing by evaluating the slope of the back-emf. In the next step, the slope is also used to calculate the time when the next commutation is required.</p>
<p>TODO:</p>
<p>1. Implement the ADC-DMA-method and evaluate the measurements only when the ADC callback is executed.</p>
<p>2. In case the single-leg-PWM is applied, evaluate only the measurements when high side switch is on.</p>
<p>3. In case the function is called late, i.e. the zero crossing already happened, use the earliest voltage measurements and slope to determine when the zero crossing occured.</p>
</html>"));
end DetectCommutationIntBEMFext;
