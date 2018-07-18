classdef TestStudentData < matlab.unittest.TestCase
%% TestStudentData 
%   is a class derived from matlab.unittest.TestCase
%   running the Test methods unit tests the StudentData class.
%   
% Implements specific unit tests for the StudentData class.
% 
    properties(Access = private)
        symbols
        invalidSymbols
        DefLength = 50;
        
        numOfIsstringIschar;
        numOfInvalidString;
        numOfErrors;
        numOfValidStrings;
        numOfIdErrors;
        numOfHWErrors;
    end
    
    methods(TestMethodSetup)
        function createSymbols(testCase)
            %% createSymbols
            % Initializes variables used for testing
            % Reports results
            %
            % Input: testCase   TestStudentData handle to class 
            %                   TestStudentData
            %
            % Output: void
            %
            % Syntax: createSymbols(testCase)
            
            %temporarily making 0-9 invalid to get name part working
                testCase.symbols = [ 'A':'Z' 'a':'z' ' ' '-'];
                testCase.invalidSymbols = '0':'9';
            
                testCase.numOfIsstringIschar = 0;
                testCase.numOfInvalidString = 0;
                testCase.numOfErrors = 0;
                testCase.numOfValidStrings = 0;
                testCase.numOfIdErrors = 0;
                testCase.numOfHWErrors = 0;
                clc
                
        end
    end
    
    methods(TestMethodTeardown)
        function reportErrors(testCase)
            %% reportErrors
            % Prints each error count to the Command Window
            %
            % Input: testCase
            %
            %
            % Output: void
            %
            % Syntax: reportErrors(testCase)
            %
                fprintf('\nNumber of Isstring, Ischar errors = %g\n',testCase.numOfIsstringIschar);
                fprintf('Number of Invalid String errors = %g\n',testCase.numOfInvalidString);
                fprintf('Number of Other errors = %g\n',testCase.numOfErrors);
                fprintf('Number of ID errors = %g\n',testCase.numOfIdErrors);
                fprintf('Number of HW errors = %g\n',testCase.numOfHWErrors);
                fprintf('\nNumber of Valid Strings = %g\n',testCase.numOfValidStrings);
                
                
        end
    end
    
    methods(Test)
        function testContstructor(testCase)
            %% testContstructor
            % Tries to run the class StudentData with combinations of
            % strings and character arrays to test the class's ability
            % to use both types of input in its constructor.
            %
            % Input: testCase   TestStudentData handle to instance of class
            %                   TestStudentData
            %
            % Output: void
            %
            % Syntax: testConstructor(testCase)
            
                student = StudentData("Teeter","Braden","C",'v388t255',[100 100 100]);
                
                text = sprintf('TestStudentData: testConstuctor\n');
                testCase.verifyTrue(ischar(student.GetLastname),text);
                testCase.verifyTrue(ischar(student.GetFirstname),text);
                testCase.verifyTrue(ischar(student.GetMI),text);
                testCase.verifyTrue(ischar(student.GetID),text);
                testCase.verifyTrue(isvector(student.GetHW),text);
                
                student = StudentData("Teeter",'Braden',"C","v388t255",[100 100 100]);
                
                text = sprintf('TestStudentData: testConstuctor\n');
                testCase.verifyTrue(ischar(student.GetLastname),text);
                testCase.verifyTrue(ischar(student.GetFirstname),text);
                testCase.verifyTrue(ischar(student.GetMI),text);
                testCase.verifyTrue(ischar(student.GetID),text);
                testCase.verifyTrue(isvector(student.GetHW),text);
                
                student = StudentData('Teeter',"Braden","C",'v388t255',[100 100 100]);
                
                text = sprintf('TestStudentData: testConstuctor\n');
                testCase.verifyTrue(ischar(student.GetLastname),text);
                testCase.verifyTrue(ischar(student.GetFirstname),text);
                testCase.verifyTrue(ischar(student.GetMI),text);
                testCase.verifyTrue(ischar(student.GetID),text);
                testCase.verifyTrue(isvector(student.GetHW),text);
                

        end
        
        
        
        function testConstructorArguments(testCase)
            %% testConstructorArguments
            % Attempts to run Class StudentData with combinations of
            % string and character arrays containing random names 
            % generated with both legal and illegal characters.
            %
            % Input: testCase   TestStudentData handle to instance of class
            %                   TestStudentData
            % 
            % Output: void
            % 
            % Syntax: testConstructorArguments(testCase)
            
               for k=1:100
                first = testCase.randomString;
                last  = testCase.randomString;
                mi    = testCase.randomString(1);
                id    = testCase.randomStudentID;
                homework = testCase.randHWScores;
                
                if mod(k,2)
                    [last, first, mi,id] = convertCharsToStrings(last, first, mi,id);
                end

                try
                    validdata = true;
                    data  = StudentData(last, first, mi, id,homework);
                catch ME
                    validdata = false;
                    %Printing vectors proved to be difficult as hell
                    cprintf('r', '\n%s\n%s %s %s. %s\n', ME.message, last, first, mi ,id);
                    cprintf('r',' %d \n',homework);
                    switch ME.message
                        case char('StudentData:ValidString:Assertion Failed isstring, ischar')
                            testCase.numOfIsstringIschar = testCase.numOfIsstringIschar + 1;
                            
                        case char('StudentData:ValidString:Assertion Invalid name string')
                            testCase.numOfInvalidString = testCase.numOfInvalidString + 1;
                        case char('StudentData:ValidString:Assertion Invalid Student ID')
                            testCase.numOfIdErrors = testCase.numOfIdErrors + 1;
                        case char('StudentData:validHWScores:Assertion Hw not in vector format')
                            testCase.numOfHWErrors = testCase.numOfHWErrors + 1;
                        case char('StudentData:validHWScores:Assertion HW cant be negative')
                            testCase.numOfHWErrors = testCase.numOfHWErrors + 1;
                        case char('StudentData:validHWScores:Assertion Invalid hw format')
                            testCase.numOfHWErrors = testCase.numOfHWErrors + 1;
                        case char('StudentData:validHWScores:Assertion Way to much homework!')
                            testCase.numOfHWErrors = testCase.numOfHWErrors + 1;
                        otherwise
                            testCase.numOfErrors = testCase.numOfErrors + 1;
                            rethrow(ME);
                    end
                end
                array_string = (num2str(homework));
                txt = sprintf('TestStudentData:testConstructorArguments: \n%s %s %s %s %s', ...
                    first, mi, last,id,array_string);
                
                
                if validdata
                    testCase.numOfValidStrings = testCase.numOfValidStrings + 1;
                    disp(data)
                    testCase.verifyTrue(isa(data,'StudentData'));
                    testCase.verifyTrue(ischar(data.GetLastname), txt);
                    testCase.verifyTrue(ischar(data.GetFirstname), txt);
                    testCase.verifyTrue(data.GetMI == mi, txt);
                    testCase.verifyTrue(ischar(data.GetID),txt);
                    testCase.verifyTrue(isvector(data.GetHW),txt);
                end
               end
            
            fprintf('\n')
        end
    end
    
    methods(Access = private)
        
        
        function s = randomString(testCase, length)
         %% randomString 
        % creates a random string of specified length from a
        % vector or accepatable characters in the SYMBOLS property. Five
        % percent of the time, it will include illegal characters from the
        % INVALIDSYMBOLS vector and .5 percent of the time it will return a
        % double precision floating point number instead of an array of
        % characters.
        %
        % Input: testCase   TestStudentData handle to instance of class
        %                   TestStudentData
        %        length     Length of character to return in vector s. The
        %                   default value for length is given by the
        %                   DEFAULTLENGTH property.
        % 
        % Output: s         character vector of specified length, or (.5%)
        %                   a double precision floating number = pi.
        % 
        % Syntax: testConstructor(testCase)
            if nargin < 2
                length = randi(testCase.DefLength);
            end
            
            if rand(1,1) > 0.05
                testSymbols = testCase.symbols;
            else
                if rand(1,1) > 0.10
                    testSymbols = [testCase.symbols testCase.invalidSymbols ];
                else
                    s = pi;
                    return
                end
            end
            
            indices = randi(numel(testSymbols),[1,length]);
            s = testSymbols(indices);
        end
        
        function c = randletter(testCase)
            
            c = 0;
            while c < 65 || (c > 90 && c < 97)
                c = randi(122);
            end 
        end
        
        function n = randnum(testCase)
            
            n = 0;
            while n < 48
                n = randi(57);
            end 
        end
        
        function id = randomStudentID(testCase)
        %% randomStudentID
        % creates a random string of specified length from a
        % vector or accepatable characters in the SYMBOLS property. Five
        % percent of the time, it will include illegal characters from the
        % INVALIDSYMBOLS vector and .5 percent of the time it will return a
        % double precision floating point number instead of an array of
        % characters.
        %
        % Input: testCase   TestStudentData handle to instance of class
        %                   TestStudentData
        %        length     Length of character to return in vector s. The
        %                   default value for length is given by the
        %                   DEFAULTLENGTH property.
        % 
        % Output: s         character vector of specified length, or (.5%)
        %                   a double precision floating number = pi.
        % 
        % Syntax: testConstructor(testCase)
        
       
        s = '        ';
        
        if rand(1,1) > 0.05
            s(1) = randletter(testCase);
            s(2) = randnum(testCase);
            s(3) = randnum(testCase);
            s(4) = randnum(testCase);
            s(5) = randletter(testCase);
            s(6) = randnum(testCase);
            s(7) = randnum(testCase);
            s(8) = randnum(testCase);
            
        elseif rand(1,1) > 0.10
            s(1) = randletter(testCase);
            s(2) = randnum(testCase);
            s(3) = randnum(testCase);
            s(4) = randnum(testCase);
            s(5) = randletter(testCase);
            s(6) = randnum(testCase);
            s(7) = randnum(testCase);
            s(8) = randnum(testCase);
            s(2) = randletter(testCase);
        else 
            s = pi;
        end
        id = s;
        
        end
        
        function hw = randHWScores(testCase)
            
            
           
            n = 1:19;
            hw = zeros(1,length(n));
            for a = 1:19
            hw(a) = randi(100);
            end
            
        end
    end
end
