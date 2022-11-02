within OpenBLDC.Converters;

package Examples
  extends Modelica.Icons.ExamplesPackage;

model InvertersWithLoad
  extends Modelica.Icons.Example;
  constant Integer m = 3 "Number of phases";
  parameter Modelica.Units.SI.Duration T_PWM = 50e-6;
  parameter Modelica.Units.SI.Resistance R_p = 0.33/2
    "Motor per phase resistance";
  parameter Modelica.Units.SI.Inductance L_p = 3.5e-5/2
    "Motor per phase inductance";
Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(extent = {{-40, -80}, {-20, -60}}, rotation = 0)));
Modelica.Electrical.Analog.Sources.ConstantVoltage battery(V = 15) annotation(
    Placement(visible = true, transformation(origin = {-30, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
OpenBLDC.Converters.Continous.InverterNph inverterNph_cont annotation(
    Placement(visible = true, transformation(origin = {0, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
OpenBLDC.Converters.SwitchingIdeal.InverterNph inverterNph_sw annotation(
    Placement(visible = true, transformation(origin = {0, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Electrical.Polyphase.Basic.Resistor resistorNph_cont(R = r_p)  annotation(
    Placement(visible = true, transformation(origin = {28, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Electrical.Polyphase.Basic.Resistor resistorNph_sw(R = r_p)  annotation(
    Placement(visible = true, transformation(origin = {28, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Electrical.Polyphase.Basic.Inductor inductorNph_cont(L = l_p)  annotation(
    Placement(visible = true, transformation(origin = {60, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Electrical.Polyphase.Basic.Inductor inductorNph_sw(L = l_p)  annotation(
    Placement(visible = true, transformation(origin = {60, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Electrical.Polyphase.Basic.Star star_cont annotation(
    Placement(visible = true, transformation(origin = {86, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Electrical.Polyphase.Basic.Star star_sw annotation(
    Placement(visible = true, transformation(origin = {86, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
OpenBLDC.Blocks.HalfBridgeLogicBLDC halfBridgeDriver[3] annotation(
    Placement(visible = true, transformation(extent = {{-60, 0}, {-40, 20}}, rotation = 0)));
Modelica.Blocks.Routing.Multiplex3 multiplex3_1 annotation(
    Placement(visible = true, transformation(extent = {{-86, -12}, {-76, -2}}, rotation = 0)));
Modelica.Blocks.Sources.Constant dutyCycle[3](each k = 0.6) annotation(
    Placement(visible = true, transformation(extent = {{-164, 38}, {-144, 58}}, rotation = 0)));
Modelica.Blocks.Sources.Constant mode_c(k = 0) annotation(
    Placement(visible = true, transformation(extent = {{-104, -28}, {-94, -18}}, rotation = 0)));
Modelica.Blocks.Sources.Constant period[3](each k = T_PWM) annotation(
    Placement(visible = true, transformation(extent = {{-164, 8}, {-144, 28}}, rotation = 0)));
Modelica.Blocks.Sources.IntegerConstant pwmMode[3](each k = 1) annotation(
    Placement(visible = true, transformation(extent = {{-86, -30}, {-76, -20}}, rotation = 0)));
Modelica.Blocks.Sources.Constant mode_b(k = -1) annotation(
    Placement(visible = true, transformation(extent = {{-104, -12}, {-94, -2}}, rotation = 0)));
Modelica.Blocks.Sources.BooleanConstant booleanConstant[3](each k = false) annotation(
    Placement(visible = true, transformation(extent = {{-164, -52}, {-144, -32}}, rotation = 0)));
Modelica.Blocks.Sources.Constant mode_a(k = 1) annotation(
    Placement(visible = true, transformation(extent = {{-104, 4}, {-94, 14}}, rotation = 0)));
Modelica.Blocks.Sources.BooleanStep startPWM[3](each startTime = 0.001e-3) annotation(
    Placement(visible = true, transformation(extent = {{-164, -22}, {-144, -2}}, rotation = 0)));
OpenBLDC.Blocks.PulseWidthVar pulseWidthVar[3] annotation(
    Placement(visible = true, transformation(extent = {{-130, 8}, {-110, 28}}, rotation = 0)));
Modelica.Blocks.Sources.BooleanConstant booleanConstant1[3](each k = true) annotation(
    Placement(visible = true, transformation(extent = {{-30, 56}, {-10, 76}}, rotation = 0)));

protected
  parameter Modelica.Units.SI.Resistance r_p[:] = fill(R_p, m);
  parameter Modelica.Units.SI.Inductance l_p[:] = fill(L_p, m);
equation
connect(mode_a.y, multiplex3_1.u1[1]) annotation(
    Line(points = {{-93.5, 9}, {-90.75, 9}, {-90.75, -3.5}, {-87, -3.5}}, color = {0, 0, 127}));
connect(pwmMode.y, halfBridgeDriver.pwm_Mode) annotation(
    Line(points = {{-75.5, -25}, {-68, -25}, {-68, 2}, {-60, 2}}, color = {255, 127, 0}));
connect(booleanConstant.y, pulseWidthVar.reset) annotation(
    Line(points = {{-143, -42}, {-120, -42}, {-120, 7.8}}, color = {255, 0, 255}));
connect(period.y, pulseWidthVar.periodTime) annotation(
    Line(points = {{-143, 18}, {-130, 18}}, color = {0, 0, 127}));
connect(startPWM.y, pulseWidthVar.active) annotation(
    Line(points = {{-143, -12}, {-136, -12}, {-136, 10}, {-130, 10}}, color = {255, 0, 255}));
connect(multiplex3_1.y, halfBridgeDriver.val) annotation(
    Line(points = {{-75.5, -7}, {-72, -7}, {-72, 10}, {-60, 10}}, color = {0, 0, 127}));
connect(mode_c.y, multiplex3_1.u3[1]) annotation(
    Line(points = {{-93.5, -23}, {-90, -23}, {-90, -10.5}, {-87, -10.5}}, color = {0, 0, 127}));
connect(pulseWidthVar.y, halfBridgeDriver.pulses) annotation(
    Line(points = {{-110, 18}, {-66, 18}, {-66, 17.8}, {-60, 17.8}}, color = {255, 0, 255}));
connect(dutyCycle.y, pulseWidthVar.dutyCycle) annotation(
    Line(points = {{-143, 48}, {-136, 48}, {-136, 26}, {-130, 26}}, color = {0, 0, 127}));
connect(mode_b.y, multiplex3_1.u2[1]) annotation(
    Line(points = {{-93.5, -7}, {-87, -7}}, color = {0, 0, 127}));
connect(ground.p, battery.n) annotation(
    Line(points = {{-30, -60}, {-30, -54}}, color = {0, 0, 255}));
connect(ground.p, star_sw.pin_n) annotation(
    Line(points = {{-30, -60}, {96, -60}, {96, -10}}, color = {0, 0, 255}));
connect(ground.p, star_cont.pin_n) annotation(
    Line(points = {{-30, -60}, {96, -60}, {96, 30}}, color = {0, 0, 255}));
connect(ground.p, inverterNph_sw.p_n) annotation(
    Line(points = {{-30, -60}, {-20, -60}, {-20, -14}, {-10, -14}}, color = {0, 0, 255}));
connect(ground.p, inverterNph_cont.p_n) annotation(
    Line(points = {{-30, -60}, {-20, -60}, {-20, 26}, {-10, 26}}, color = {0, 0, 255}));
connect(battery.p, inverterNph_sw.p_p) annotation(
    Line(points = {{-30, -34}, {-30, -6}, {-10, -6}}, color = {0, 0, 255}));
connect(battery.p, inverterNph_cont.p_p) annotation(
    Line(points = {{-30, -34}, {-30, 34}, {-10, 34}}, color = {0, 0, 255}));
connect(halfBridgeDriver.lCtrl, inverterNph_sw.ctrl_l) annotation(
    Line(points = {{-40, 4}, {2, 4}, {2, 0}}, color = {255, 0, 255}, thickness = 0.5));
connect(halfBridgeDriver.hCtrl, inverterNph_sw.ctrl_h) annotation(
    Line(points = {{-40, 16}, {-2, 16}, {-2, 0}}, color = {255, 0, 255}, thickness = 0.5));
connect(dutyCycle.y, inverterNph_cont.ctrl_h) annotation(
    Line(points = {{-142, 48}, {-2, 48}, {-2, 40}}, color = {0, 0, 127}, thickness = 0.5));
connect(booleanConstant1.y, inverterNph_cont.ctrl_l) annotation(
    Line(points = {{-8, 66}, {2, 66}, {2, 40}}, color = {255, 0, 255}, thickness = 0.5));
connect(inverterNph_cont.plug_m, resistorNph_cont.plug_p) annotation(
    Line(points = {{10, 30}, {18, 30}}, color = {0, 0, 255}));
connect(inverterNph_sw.plug_m, resistorNph_sw.plug_p) annotation(
    Line(points = {{10, -10}, {18, -10}}, color = {0, 0, 255}));
connect(resistorNph_cont.plug_n, inductorNph_cont.plug_p) annotation(
    Line(points = {{38, 30}, {50, 30}}, color = {0, 0, 255}));
connect(resistorNph_sw.plug_n, inductorNph_sw.plug_p) annotation(
    Line(points = {{38, -10}, {50, -10}}, color = {0, 0, 255}));
connect(inductorNph_cont.plug_n, star_cont.plug_p) annotation(
    Line(points = {{70, 30}, {76, 30}}, color = {0, 0, 255}));
connect(inductorNph_sw.plug_n, star_sw.plug_p) annotation(
    Line(points = {{70, -10}, {76, -10}}, color = {0, 0, 255}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-200,
            -200},{100,100}}),                                                                        graphics), Documentation(info= "<html><head></head><body><p>This example is used to compare the continuous with the switching domain inverter model.</p>
<p>The connectors a and b are operated in 2-leg PWM mode. Observe the voltage on the open connector c of inverter3ph_2 and the torque of the motor.</p>
</body></html>"),
    experiment(StopTime=0.01));

end InvertersWithLoad;
end Examples;