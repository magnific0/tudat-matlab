function [failcount,issueURL] = shapeModel

tudat.load();

% Test 1: rotation model types
test.createInputForEnum(?ShapeModels,fullfile(mfilename,'types'));

% Test 2: spherical shape model
sm = SphericalShapeModel();
sm.radius = 6.4e6;
test.createInput(sm,fullfile(mfilename,'spherical'));

% Test 3: spherical Spice shape model
sm = SphericalSpiceShapeModel();
test.createInput(sm,fullfile(mfilename,'sphericalSpice'));

% Test 4: oblate spherical shape model
sm = OblateSphericalShapeModel();
sm.equatorialRadius = 6.378e6;
sm.flattening = 0.0034;
test.createInput(sm,fullfile(mfilename,'oblateSpherical'));


% Run tests

[failcount,issueURL] = test.runUnitTest(mfilename);

