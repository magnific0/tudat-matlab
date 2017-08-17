% See: https://github.com/aleixpinardell/tudat-matlab#usage
tudat.load();
simulation = Simulation('1992-02-14 06:00','1992-02-15 12:00');
simulation.spice = Spice('pck00009.tpc','de-403-masses.tpc','de421.bsp');
satelliteBody = Body('Satellite');
simulation.addBodies('Earth',satelliteBody);
propagator = TranslationalPropagator();
initialKeplerianState = [7500.0E3 0.1 deg2rad(85.3) deg2rad(235.7) deg2rad(23.4) deg2rad(139.87)];
propagator.initialStates = convert.keplerianToCartesian(initialKeplerianState);
propagator.centralBodies = 'Earth';
propagator.bodiesToPropagate = 'Satellite';
propagator.accelerations.Satellite.Earth = PointMassGravity();
simulation.propagator = propagator;
simulation.integrator = Integrator(Integrators.rungeKutta4,20);
simulation.run();
[t,r,v] = compute.epochPositionVelocity(simulation.results.numericalSolution);
plot(convert.epochToDate(t),r);
