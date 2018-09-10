classdef channel
    properties
        channelNumber
        verticalScale
        probe
        offset
        status
    end
    methods
        function obj = channel(channelNumber,verticalScale,probe,offset,status)
            obj.channelNumber=channelNumber;
            obj.verticalScale=verticalScale;
            obj.probe=probe;
            obj.offset=offset;
            obj.status=status;
        end
        
    end
end