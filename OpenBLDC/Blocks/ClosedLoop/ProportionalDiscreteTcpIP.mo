within OpenBLDC.Blocks.ClosedLoop;

model ProportionalDiscreteTcpIP
  extends Modelica.Blocks.Icons.DiscreteBlock;
  parameter Modelica.Units.SI.Period t_s = 0.02 "Sample period";
  parameter Real dummynum = 99.9;
  Modelica.Blocks.Interfaces.RealInput r annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-94, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput y annotation(
    Placement(visible = true, transformation(origin = {0, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {0, -96}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput u annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {92, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanExpression trigger(y = sample(0, t_s)) annotation(
    Placement(visible = true, transformation(extent = {{-62, 20}, {-34, 40}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanExpression pre_trigger(y = pre(trigger.y)) annotation(
    Placement(visible = true, transformation(extent = {{18, 20}, {46, 40}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.Communication.TCPIPServerReceive tCPIPReceive(autoBufferSize = true, blockUntilConnected = true, clientIndex = 1, enableExternalTrigger = true, showAdvancedOutputs = true) annotation(
    Placement(visible = true, transformation(origin = {70, 30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  inner Modelica_DeviceDrivers.Blocks.Communication.TCPIPServerConfig tcpipserverconfig(maxClients = 1, port = 10002, useNonblockingMode = false) annotation(
    Placement(visible = true, transformation(origin = {-90, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.Communication.TCPIPServerSend tCPIPSend(autoBufferSize = true, blockUntilConnected = true, enableExternalTrigger = true, userBufferSize = 16) annotation(
    Placement(visible = true, transformation(origin = {-10, -60}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.AddFloat addFloat(n = 2, nu = 1) annotation(
    Placement(visible = true, transformation(origin = {-10, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.Packager packager(enableExternalTrigger = true, useBackwardPropagatedBufferSize = false, useBackwardSampleTimePropagation = true, userBufferSize = 16) annotation(
    Placement(visible = true, transformation(origin = {-10, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Routing.Multiplex2 multiplex2 annotation(
    Placement(visible = true, transformation(origin = {-50, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.GetFloat getFloat annotation(
    Placement(visible = true, transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.AddFloat addFloat1(n = 2, nu = 1) annotation(
    Placement(visible = true, transformation(origin = {-10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
//when initial() then
//Modelica.Utilities.System.command(Modelica.Utilities.System.getWorkDirectory()+"../OpenBLDC/Resources/build/test/Communication/TCPIPClientAsClosedLoopPositionController &");
//Modelica.Utilities.System.command("/home/joerg/repos/OpenBLDC/open-bldc-modelica/OpenBLDC/Resources/build/test/Communication/TCPIPClientAsClosedLoopPositionController &");
//y = a * pre( y ) + b * u ;
//end when;
  connect(addFloat.pkgOut[1], tCPIPSend.pkgIn) annotation(
    Line(points = {{-10, -39}, {-10, -49}}));
  connect(r, multiplex2.u1[1]) annotation(
    Line(points = {{-100, 0}, {-81, 0}, {-81, -22}, {-62, -22}}, color = {0, 0, 127}));
  connect(y, multiplex2.u2[1]) annotation(
    Line(points = {{0, -100}, {0, -80}, {-70, -80}, {-70, -34}, {-62, -34}}, color = {0, 0, 127}));
  connect(getFloat.y[1], u) annotation(
    Line(points = {{82, 0}, {100, 0}}, color = {0, 0, 127}));
  connect(tCPIPReceive.pkgOut, getFloat.pkgIn) annotation(
    Line(points = {{70, 20}, {70, 10}}));
  connect(pre_trigger.y, tCPIPReceive.trigger) annotation(
    Line(points = {{48, 30}, {58, 30}}, color = {255, 0, 255}));
  connect(trigger.y, packager.trigger) annotation(
    Line(points = {{-32, 30}, {-22, 30}}, color = {255, 0, 255}));
  connect(trigger.y, tCPIPSend.trigger) annotation(
    Line(points = {{-32, 30}, {-28, 30}, {-28, -60}, {-22, -60}}, color = {255, 0, 255}));
  addFloat1.u[1] = time;
  addFloat1.u[2] = time;
  connect(multiplex2.y, addFloat.u) annotation(
    Line(points = {{-38, -28}, {-22, -28}}, color = {0, 0, 127}, thickness = 0.5));
  connect(packager.pkgOut, addFloat1.pkgIn) annotation(
    Line(points = {{-10, 20}, {-10, 10}}));
  connect(addFloat1.pkgOut[1], addFloat.pkgIn) annotation(
    Line(points = {{-10, -10}, {-10, -18}}));
  annotation(
    Documentation(info = "<html>
<p>
The <code>tcpipserverconfig</code> block is configured for listening at port 10002 and for using a blocking TCP/IP
socket.
</p>
<p>
To run the simulation a TCP/IP client needs to connect and send suitable data, otherwise no data is received. Such
a client is provided as C code test program 
(<a href=\"modelica://Modelica_DeviceDrivers/Resources/test/Communication/TCPIPClientAsClosedLoopPositionController.c\">Resources/test/Communication/TCPIPClientAsClosedLoopPositionController.c</a>).
</p>
</html>"),
    experiment(StopTime = 10),
    Diagram(graphics = {Text(origin = {89, 155}, textColor = {28, 108, 200}, extent = {{-147, -99}, {-27, -107}}, textString = "Ensure that receive is called before  send is called")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end ProportionalDiscreteTcpIP;