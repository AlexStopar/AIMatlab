classdef (Sealed) Actions
    properties (Constant)
       LEFT = 1;
       RIGHT = 2;
       UP = 3;
       DOWN = 4;
    end

    methods (Access = private)    % private so that you cant instantiate
        function out = Actions
        end
    end
end

