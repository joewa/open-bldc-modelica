within OpenBLDC.Blocks;
block DetectCommutationIntBEMFext
  "Detects sensorless when commutation is required by back EMF integration - extended method"
  extends DetectCommutationPartial;
  parameter Boolean sampleHi = true "Sample when PWM signal is high when true";
  parameter Boolean sampleLo = true "Sample when PWM signal is low when true";
  parameter Boolean sampleAll = true "Use all samples";
  parameter Integer dropnoisysamples = 1 "Drop samples with switching noise";
  parameter Integer bufsize = 10 "Size of buffer";
  parameter Real period_adc = 1e-6;
  parameter Modelica.SIunits.Time Ts_ADC = 1e-6 "Sample rate of ADC";
  parameter Real vdivider = 3.6/13.6 "Voltage divider of phase voltage";
  parameter Integer NREG = 10 "Number of samples for a valid regression";
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
  Boolean takesampleHi "Is true when high sample will be evaluated";
  Boolean takesampleLo "Is true when low sample will be evaluated";
  Integer k_zc(start=0) "Sample when the zero crossing occurs";
  Integer KV_int(start=0) "Integer equivalent of KV";
  discrete Real duration_zc2comm_int(start=0)
    "Duration from zero crossing to next commutation";
  discrete Real m_reg(start=0) "Slope";
  discrete Real b_reg(start=0) "y-intercept";
  discrete Real time_blockstart(start=0) "Time when last block started";
  discrete Real time_nextblock(start=0)
    "Time when next block (commutation) will occur";
  discrete Real maxBEMF(start=0) "Max EMF in this cycle";
  Real v_sense "Sensed voltage at the open motor pin, referenced to v_dc/2";
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
    maxBEMF:= 0;
    time_blockstart := time;
  end when;
  when maxBEMF < abs(v_sense) then
    // das ist fragwürdig
    maxBEMF :=abs(v_sense);
  end when;
  speedOK :=true;//maxBEMF > minEMF; TODO

  //Neueste Variante mit ADC-Modell
  when adcSingleBufferedInteger.adcSingleIntegerBus.cbStart then
    pwm_dutyCycle_int := integer(floor(10000 * pwmControlBusConnectorIn.dutyCycle));
    pwm_period_int := integer(pwmControlBusConnectorIn.period / period_adc);
    // CAUTION: pwm_period_int works only if period / period_adc has no fraction
    v_dc_int := integer(floor(v_dc*vdivider*4096/3)); // ADC value
    KV_int := integer(KV * v_dc*vdivider*4096/3 / period_adc);
    for f in 1:bufsize loop
      k_sample := bufsize * k_cb_ADC + f;
      // Store valid measurements in the table (e.g. high side switch is on)
      //if pulses then
      k_pwm_period := mod(k_sample, pwm_period_int);
      takesampleHi := k_pwm_period > dropnoisysamples and k_pwm_period < ((pwm_dutyCycle_int * pwm_period_int)/10000 - dropnoisysamples);
      takesampleLo := k_pwm_period < pwm_period_int - dropnoisysamples and k_pwm_period > ((pwm_dutyCycle_int * pwm_period_int)/10000 + dropnoisysamples);
      if ( (takesampleHi and sampleHi) or (takesampleLo and sampleLo) or sampleAll) then
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
        // write new value to buffer
        yreg[NREG] := integer( senseBridgeSign*(adcSingleBufferedInteger.adcSingleIntegerBus.buffer[f] - v_dc_int / 2));
        xreg[NREG] := k_sample; // Sample-number in actual commutation cycle
        // calculate sums for linear fit
        sumx := sumx + xreg[NREG];
        sumx2 := sumx2 + xreg[NREG]*xreg[NREG];
        sumxy := sumxy + xreg[NREG]*yreg[NREG];
        sumy := sumy + yreg[NREG];
        sumy2 := sumy2 + yreg[NREG]*yreg[NREG];
      end if;
    end for;
    // Check if we are ready to calculate slope and zero crossing (sufficient values and time)
    if (n_reg >= NREG and not (n_reg * sumx2 == sumx * sumx)) then
      m_reg := (n_reg * sumxy  -  sumx * sumy) / (n_reg * sumx2  -  sumx * sumx);
      b_reg := (sumy * sumx2  -  sumx * sumxy) / (n_reg * sumx2  -  sumx * sumx);
      if m_reg < -0.1 then // slope must not be zero
        k_zc := integer( -b_reg / m_reg);
        if k_zc < k_sample and time > time_nextblock then // the zero crossing shall have occurred in the past
          duration_zc2comm_int := sqrt(-(2*KV_int / m_reg)) / 4; // TODO check "4"
          time_nextblock := time_blockstart + (k_zc + duration_zc2comm_int) * period_adc;
        end if;
      end if;
    end if;
    // Hier schon Counter zur Zeitmessung mitlaufen lassen: bei jedem Callback +1
    k_cb_ADC := k_cb_ADC + 1;
  end when;

  y := if time_nextblock < time and time_nextblock + period_adc > time then true else false;

equation
  v_sense = v[senseBridgeID] - v_dc / 2;
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
<p>1. Investigate the spike that occurs single leg mode as in Test.Commutation.IntBEMF3.</p>
</html>"));
end DetectCommutationIntBEMFext;
