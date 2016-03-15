classdef images
   % write a description of the class here.
       properties
       % define the properties of the class here, (like fields of a struct)
           pixels;
           names;
           labels;
       end
       methods
       % methods, including the constructor are defined in this block
           function obj = images(pixels,names,labels)
           % class constructor
               if(nargin > 0)
                 obj.pixels = pixels;
                 obj.names   = names;
                 obj.labels    = labels;
                 obj.size = size;
               end
           end
           function obj = size(obj)
               obj.size = size(obj.pixels);
           end
       end
   end