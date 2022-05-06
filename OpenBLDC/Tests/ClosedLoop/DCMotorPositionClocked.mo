within OpenBLDC.Tests.ClosedLoop;

model DCMotorPositionClocked "Simple DC motor servo with clocked discrete controller"
  extends Modelica.Icons.Example;
  parameter Real k_p = 25.0 "Proportional gain";
  parameter Modelica.Units.SI.Period t_s = 0.02 "Sample period";
  extends Assemblies.ClosedLoopSystems.DCMotorPosition(
      redeclare Blocks.ClosedLoop.ProportionalClocked positionController(
        k_p = k_p, t_s = t_s
      )
    );
  annotation(experiment(StopTime = 1.0));

end DCMotorPositionClocked;