within OpenBLDC.Blocks.ClosedLoop;

model ProportionalDiscreteTcpIP
extends Modelica.Blocks.Icons.DiscreteBlock;
  parameter Modelica.Units.SI.Period t_s = 0.02 "Sample period";
  Modelica.Blocks.Interfaces.RealInput r annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-94, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput y annotation(
    Placement(visible = true, transformation(origin = {0, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {0, -96}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput u annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {92, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanExpression trigger(y=sample(0, 0.1))
    annotation (Placement(visible = true, transformation(extent = {{20, 20}, {48, 40}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanExpression pre_trigger(y=pre(trigger.y))
    annotation (Placement(visible = true, transformation(extent = {{-64, 20}, {-36, 40}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.Communication.TCPIPServerReceive tCPIPReceive(
    autoBufferSize = true,
    blockUntilConnected= true,clientIndex=1, enableExternalTrigger = true,
                   showAdvancedOutputs=true)
                                annotation (Placement(visible = true, transformation(origin = {70, 30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  inner Modelica_DeviceDrivers.Blocks.Communication.TCPIPServerConfig tcpipserverconfig(maxClients = 1, port = 10002, useNonblockingMode = false)  annotation(
    Placement(visible = true, transformation(origin = {-70, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.Communication.TCPIPServerSend tCPIPSend(autoBufferSize = true, enableExternalTrigger = true)  annotation(
    Placement(visible = true, transformation(origin = {-10, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.GetFloat getFloat annotation(
    Placement(visible = true, transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.AddFloat addFloat(n = 2, nu = 1)  annotation(
    Placement(visible = true, transformation(origin = {-10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.Packager packager(enableExternalTrigger = true, useBackwardPropagatedBufferSize = true, useBackwardSampleTimePropagation = true)  annotation(
    Placement(visible = true, transformation(origin = {-10, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Routing.Multiplex2 multiplex2 annotation(
    Placement(visible = true, transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(pre_trigger.y, tCPIPSend.trigger) annotation(
    Line(points = {{-34.6, 30}, {-28.9, 30}, {-28.9, -30}, {-21.2, -30}}, color = {255, 0, 255}));
  connect(pre_trigger.y, packager.trigger) annotation(
    Line(points = {{-34.6, 30}, {-22.2, 30}}, color = {255, 0, 255}));
  connect(packager.pkgOut, addFloat.pkgIn) annotation(
    Line(points = {{-10, 19.2}, {-10, 9.2}}));
  connect(addFloat.pkgOut[1], tCPIPSend.pkgIn) annotation(
    Line(points = {{-10, -10.8}, {-10, -20.8}}));
  connect(trigger.y, tCPIPReceive.trigger) annotation(
    Line(points = {{50, 30}, {58, 30}}, color = {255, 0, 255}));
  connect(tCPIPReceive.pkgOut, getFloat.pkgIn) annotation(
    Line(points = {{70, 20}, {70, 10}}));
  connect(multiplex2.y, addFloat.u) annotation(
    Line(points = {{-38, 0}, {-22, 0}}, color = {0, 0, 127}, thickness = 0.5));
  connect(r, multiplex2.u1[1]) annotation(
    Line(points = {{-100, 0}, {-70, 0}, {-70, 6}, {-62, 6}}, color = {0, 0, 127}));
  connect(y, multiplex2.u2[1]) annotation(
    Line(points = {{0, -100}, {0, -50}, {-70, -50}, {-70, -6}, {-62, -6}}, color = {0, 0, 127}));
  connect(getFloat.y[1], u) annotation(
    Line(points = {{82, 0}, {100, 0}}, color = {0, 0, 127}));
  annotation(
    Diagram(graphics = {Text(origin = {89, 155},lineColor = {28, 108, 200}, extent = {{-147, -99}, {-27, -107}}, textString = "Ensure that send is called before receive is called")}));
end ProportionalDiscreteTcpIP;