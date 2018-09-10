classdef channel
    properties
        channelNumber
        verticalScale
        probe
        offset
    end
    methods
        function obj = channel(channelNumber,verticalScale,probe,offset)
            obj.channelNumber=channelNumber;
            obj.verticalScale=verticalScale;
            obj.probe=probe;
            obj.offset=offset;
        end
        
    end
end