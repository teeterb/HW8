classdef StudentData
%% StudentData 
%   is a class that encapsulates the name of a student for other classes. 
%   MATH 451, In class project.
%   lastname
%   firstname
%   id            MyWSU student ID
%   homework      array of homework scores, double precision
%   midterm       midterm grade/score
%   project       final project/score
%
%   Revision History
%       07/17/2018  First draft due
    properties(Access = public)
        Symbols = '-';
        Numbers = '0':'9';
        
        lastname;   %string
        firstname;  %string
        MI;         %middle initial Char
        id;         %string in form: cdddcdd, where c = char and d = digit.
        homework;   %array of homework scores
        midterm;    %midterm score
        project;    %final score
    end
    
    methods
        function obj = StudentData(last,first,mi,id,hw)
        %% StudentData 
        % Constructor
        %   
        %   Inputs: 
        %   last    last name, character array or string
        %   first   first name, character array or string
        %   mi      middle initial, character or single character string
        %
        %   names must be either 'single-quoted' character arrays
        %   or "double quoted" strings
           
            obj.lastname  = obj.ValidStrings(last);
            obj.firstname = obj.ValidStrings(first);
            obj.MI        = obj.ValidStrings(mi);
            if nargin > 3
                obj.id        = obj.isvalidStudentID(id);
                obj.homework  = obj.validHWScores(hw);
            end
            
            
        end
        
        function disp(obj)
        %% disp 
        %   disp(obj) displays the full object without printing 
        %   the variable name. It utilizes the disp function for a
        %   character array.
        %   
        %   Inputs: 
        %   obj     instance of class StudentData
        %
        %   Outputs: void
        
            disp(obj.Student)
        
        end
    
        function s = Student(obj)
        %% Student
        %   Student(obj) returns a character array with the full info
        %   of the student object
        %   
        %   Inputs: 
        %   obj     instance of class StudentData
        %
        %   Outputs: %This will be added to 
        %   s       character vector 'firstname' 'middle initial'.
        %   'lastname' 'id'
        
            s = sprintf('%s %s %s %s',obj.firstname,obj.MI,obj.lastname,obj.id,obj.homework);
        end
        
        function s = GetFirstname(obj)
        %% GetFirstname
        %   GetFirstname(obj) returns a character vector contain the first
        %   name of the object.
        %   
        %   Inputs: 
        %   obj     instance of class StudentData
        %
        %   Outputs:
        %   s       character vector containing first name of object

            s = obj.firstname;
        end
        
        function s = GetLastname(obj)
        %% GetLastname
        %   GetLaststname(obj) returns a character vector containing the last
        %   name of the object.
        %   
        %   Inputs: 
        %   obj     instance of class StudentData
        %
        %   Outputs:
        %   s       character vector containing the last name of object

            s = obj.lastname;
        end
        
        function s = GetMI(obj)
        %% GetMI
        %   GetMI(obj) returns a character vector containing the first
        %   name of the student object.
        %   
        %   Inputs: 
        %   obj     instance of class Student
        %
        %   Outputs:
        %   s       character vector containing the first name of object

            s = obj.MI;
        end
        
        function s = GetID(obj)
        %% GetMI
        %   GetMI(obj) returns a character vector containing the middle 
        %   initial of the object.
        %   
        %   Inputs: 
        %   obj     instance of class Student
        %
        %   Outputs:
        %   s       character vector containing the student ID of object

            s = obj.id;
        end
         function s = GetHW(obj)
        %% GetMI
        %   GetMI(obj) returns a character vector containing the middle 
        %   initial of the object.
        %   
        %   Inputs: 
        %   obj     instance of class Student
        %
        %   Outputs:
        %   s       character vector containing the student ID of object

            s = obj.homework;
        end
    end

    
    methods(Access = protected)
        function vstring = ValidStrings(obj, name)
        %% ValidName
        %   ValidName(obj) returns a character vector with the text of the
        %   name argument if the name argument contains only valid name 
        %   characters. Valid characters are letters, spaces and characters
        %   contained in the SYMBOLS property of the TestStudentData 
        %   class. String inputs are converted to character vectors.
        %   
        %   Inputs: 
        %   obj     instance of class StudentData
        %   name    character vector or string containing name text
        %
        %   Outputs:
        %   s       character vector with valid name text

            if isstring(name)
                vstring = char(name);
            elseif ischar(name)
                vstring = name;
            else
                assert(false, 'StudentData:ValidString:Assertion Failed isstring, ischar');
            end
            
            if ~obj.isvalidchars(vstring)
                assert(false, 'StudentData:ValidString:Assertion Invalid name string');
            
            end
            
            
                
           
            
        end
        
        
        function fisvalid = isvalidchars(obj, name)
        %% isvalidchars
        %   isvalidchars(name) returns a logical value; true if the name
        %   text contains only valid characters; that is letters, spaces or
        %   characters in the SYMBOLS property of the StudentData class. 
        %   isvalidcchars returns false if name contains any other characters.
        %   
        %   Inputs: 
        %   obj         instance of class StudentData
        %   name        character vector or string containing name text
        %
        %   Outputs:
        %   fisvalid    logical value true of name contains only legal
        %               characters and false otherwise.

            % create a logical vector the same length as the name
            fisvalid = zeros(size(name));
            
            % Set each element of fisvalid to true when the character is a 
            % character (other than a letter or a space) from the SYMBOLS
            % property of the StudentData class; and false for any other 
            % character.
            for k=1:length(obj.Symbols)
                fisvalid(strfind(name,obj.Symbols(k))) = true;
            end

            % set fisvlaid to true if all characters are letters, spaces or
            % valid special characters and false otherwise
            fisvalid = all(fisvalid | isletter(name) | isspace(name));
        end
        
        function vID = isvalidStudentID(obj,id)
        %% isvalidStudentId
        %
        %
        %
        %
            if isstring(id)
                s = char(id);
            elseif ischar(id)
                s = id;
            else
                assert(false, 'StudentData:ValidString:Assertion Failed isstring, ischar');
            end
            x = 2:4;
            y = 6:8;
            a = str2double(s(x));
            b = str2double(s(y));
            
            if ~isnan(a) || ~isnan(b)
                if length(s) == 8 && isletter(s(1)) && isletter(s(5))
                    if all(isnumeric(a) && isnumeric(b))
                        vID = s;
                    end
               
                else
                    assert(false, 'StudentData:ValidString:Assertion Invalid Student ID');
                end
            
            end
        end
        
        function homework = validHWScores(obj,hw)
        
            
            if ~isvector(hw)
                assert(false, 'StudentData:validHWScores:Assertion Hw not in vector format');
            end
            if length(hw) < 20
                numOfScores = length(hw);
                n = 1:numOfScores;
                if hw(n) < 0 | hw(n) > 100
                    assert(false, 'StudentData:validHWScores:Assertion HW cant be negative');
                end
                if ~isnumeric(hw(n))
                    assert(false, 'StudentData:validHWScores:Assertion Invalid hw format');
                end
            else
                assert(false, 'StudentData:validHWScores:Assertion Way to much homework!');
            end
            
            homework = hw;
        end
    end
end

