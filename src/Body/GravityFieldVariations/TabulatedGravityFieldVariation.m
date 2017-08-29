classdef TabulatedGravityFieldVariation < GravityFieldVariation
    properties
        cosineCoefficientCorrections
        sineCoefficientCorrections
        minimumDegree
        minimumOrder
        modelInterpolation = ModelInterpolation
    end
    
    methods
        function obj = TabulatedGravityFieldVariation()
            obj@GravityFieldVariation(BodyDeformations.tabulatedVariation);
        end
        
    end
    
    methods (Hidden)
        function mp = getMandatoryProperties(obj)
            mp = getMandatoryProperties@GravityFieldVariation(obj);
            mp = horzcat(mp,{'cosineCoefficientCorrections','sineCoefficientCorrections','minimumDegree'...
                'minimumOrder','modelInterpolation'});
        end
        
    end
    
end
