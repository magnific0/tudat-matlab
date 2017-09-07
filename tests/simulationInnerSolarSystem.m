function failcount = simulationInnerSolarSystem

tudat.load();

% Simulation
t0 = 1e7;  % seconds since J2000
tf = t0 + convert.toSI(2,'y');  % two years later
simulation = Simulation(t0,tf);
simulation.spice = Spice('pck00009.tpc','de-403-masses.tpc','de421.bsp');
simulation.spice.preloadKernels = false;

% Bodies
simulation.addBodies(Sun,Mercury,Venus,Earth,Moon,Mars);

% Accelerations
bodyNames = fieldnames(simulation.bodies);
for i = 1:length(bodyNames)
    for j = 1:length(bodyNames)
        if i ~= j
            accelerations.(bodyNames{j}).(bodyNames{i}) = PointMassGravity();
        end
    end
end

% Propagator
propagator = TranslationalPropagator();
propagator.centralBodies = repmat({'SSB'},size(bodyNames));
propagator.bodiesToPropagate = bodyNames;
propagator.accelerations = accelerations;
simulation.propagator = propagator;

% Integrator
simulation.integrator.type = Integrators.rungeKutta4;
simulation.integrator.stepSize = 3600;

% Generate input file
test.createInput(simulation,mfilename);

% Run test
failcount = test.runUnitTest(mfilename);
