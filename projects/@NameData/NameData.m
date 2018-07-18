classdef NameData
%% NameData 
%   is a class that encapsulates the name for other classes. 
%   MATH 451, In class project.
%
%   Revision History
%       07/17/2018  First draft due
    
    properties(Access = private)
        Symbols = '-';
        
        First   % first name character array  
        Last    % last name character array
        MI      % middle initial char
    end
    
    methods
        function obj = NameData(last, first, mi)
        %% NameData 
        % Constructor
        %   
        %   Inputs: 
        %   last    last name, character array or string
        %   first   first name, character array or string
        %   mi      middle initial, character or single character string
        %
        %   names must be either 'single-quoted' character arrays
        %   or "double quoted" strings
            
            obj.Last  = obj.ValidName(last);
            obj.First = obj.ValidName(first);
            obj.MI    = obj.ValidName(mi);
        end
        
        function disp(obj)
        %% disp
        %   disp(obj) displays the full name of the object without printing 
        %   the variable name. It utilizes the disp function for a
        %   character array.
        %   
        %   Inputs: 
        %   obj     instance of class NameData
        %
        %   Outputs:
        %   void
        
            disp(obj.FullName);
        end
        
        function s = FullName(obj)
        %% FullName
        %   FullName(obj) returns a character array with the full name of
        %   object
        %   
        %   Inputs: 
        %   obj     instance of class NameData
        %
        %   Outputs:
        %   s       character vector 'firstname' 'middle initial'. 'lastname'

            s = sprintf('%s %s. %s', obj.First, obj.MI, obj.Last);
        end
        
        function s = GetFirstname(obj)
        %% GetFirstname
        %   GetFirstname(obj) returns a character vector contain the first
        %   name of the object.
        %   
        %   Inputs: 
        %   obj     instance of class NameData
        %
        %   Outputs:
        %   s       character vector containing first name of object

            s = obj.First;
        end
        
        function s = GetLastname(obj)
        %% GetLastname
        %   GetLaststname(obj) returns a character vector contain the last
        %   name of the object.
        %   
        %   Inputs: 
        %   obj     instance of class NameData
        %
        %   Outputs:
        %   s       character vector containing last name of object

            s = obj.Last;
        end
        
        function s = GetMI(obj)
        %% GetMI
        %   GetMI(obj) returns a character vector contain the middle 
        %   initial of the object.
        %   
        %   Inputs: 
        %   obj     instance of class NameData
        %
        %   Outputs:
        %   s       character vector containing the middle initial of object

            s = obj.MI;
        end
    end
    
    methods(Access=protected)
        function vname = ValidName(obj, name)
        %% ValidName
        %   ValidName(obj) returns a character vector with the text of the
        %   name argument if the name argument contains only valid name 
        %   characters. Valid characters are letters, spaces and characters
        %   contained in the SYMBOLS property of the NameData class. String 
        %   inputs are converted to character vectors.
        %   
        %   Inputs: 
        %   obj     instance of class NameData
        %   name    character vector or string containing name text
        %
        %   Outputs:
        %   s       character vector with valid name text

            if isstring(name)
                vname = char(name);
            elseif ischar(name)
                vname = name;
            else
                assert(false, 'NameData:ValidName:Assertion Failed isstring, ischar');
            end
            
            if ~obj.isvalidchars(vname)
                assert(false, 'NameData:ValidName:Assertion Invalid name string');
            end
        end
        
        function fisvalid = isvalidchars(obj, name)
        %% isvalidchars
        %   isvalidchars(name) returns a logical value; true if the name
        %   text contains only valid characters; that is letters, spaces or
        %   characters in the SYMBOLS property of the NameData class. 
        %   isvalidcchars returns false if name contains any other characters.
        %   
        %   Inputs: 
        %   obj         instance of class NameData
        %   name        character vector or string containing name text
        %
        %   Outputs:
        %   fisvalid    logical value true of name contains only legal
        %               characters and false otherwise.

            % create a logical vector the same length as the name
            fisvalid = zeros(size(name));
            
            % Set each element of fisvalid to true when the character is a 
            % character (other than a letter or a space) from the SYMBOLS
            % property of the NameData class; and false for any other 
            % character.
            for k=1:length(obj.Symbols)
                fisvalid(strfind(name,obj.Symbols(k))) = true;
            end

            % set fisvlaid to true if all characters are letters, spaces or
            % valid special characters and false otherwise
            fisvalid = all(fisvalid | isletter(name) | isspace(name));
        end
    end
end
