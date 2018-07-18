classdef TestNameData < matlab.unittest.TestCase
%% TestNameData 
%   is a class derived from matlab.unittest.TestCase
%   running the Test methods unit tests the NameData class.
%    
% Implements specific unit tests for the NameData class.
%
    properties(Access=private)
        symbols
        invalidsymbols
        DefaultLength = 50;
        
        numberOfIsstringIschar;
        numberOfInvalidString;
        numberOfOtherErrors;
        numberOfValidStrings;
    end
    
    methods(TestMethodSetup)
        function createSymbols(testCase)
        %% createSymbols 
        % initializes variables used by all tests and used to
        % report results during tear down.
        %
        % Input: testCase   TestNameData handle to instance of class
        %                   TestNamedata
        % 
        % Output: void
        % 
        % Syntax: createSymbols(testCase)
        
            testCase.symbols = [ 'A':'Z' 'a':'z' ' ' '-' ];
            testCase.invalidsymbols = '0':'9';

            testCase.numberOfIsstringIschar = 0;
            testCase.numberOfInvalidString  = 0;
            testCase.numberOfOtherErrors    = 0;
            testCase.numberOfValidStrings   = 0;
            clc
        end
    end
     
    methods(TestMethodTeardown)
        function reportErrors(testCase)
        %% reportErrors 
        % prints error counts to MatLab Command Window
        %
        % Input: testCase   TestNameData handle to instance of class
        %                   TestNamedata
        % 
        % Output: void
        % 
        % Syntax: reportErrors(testCase)
        
            fprintf('\nNumber Of Isstring, Ischar errors = %g\n', testCase.numberOfIsstringIschar)
            fprintf('Number of Invalid String errors = %g\n', testCase.numberOfInvalidString)
            fprintf('Number of Other errors = %g\n', testCase.numberOfOtherErrors)
            fprintf('\nNumber of Valid Strings = %g\n', testCase.numberOfValidStrings)
        end
    end
        
    methods(Test)
        function testContructor(testCase)
        %% 	testContructor 
        % attempts to create instances of class NameData with combinations 
        % of strings and character arrays to test the NameData class's 
        % ability to accepts both types of inputs to its constuctor.
        %
        % Input: testCase   TestNameData handle to instance of class
        %                   TestNamedata
        % 
        % Output: void
        % 
        % Syntax: testConstructor(testCase)
        
            name = NameData("Ingle", "William", "N");
            
            txt = sprintf('TestNameData:testContructor\n');
            testCase.verifyTrue(ischar(name.GetLastname), txt);
            testCase.verifyTrue(ischar(name.GetFirstname), txt);
            testCase.verifyTrue(name.GetMI == 'N');
            
            name = NameData("Ingle", 'William', "N");
            
            txt = sprintf('TestNameData:testContructor\n');
            testCase.verifyTrue(ischar(name.GetLastname), txt);
            testCase.verifyTrue(ischar(name.GetFirstname), txt);
            testCase.verifyTrue(name.GetMI == 'N');

            name = NameData('Ingle', "William", "N");
            
            txt = sprintf('TestNameData:testContructor\n');
            testCase.verifyTrue(ischar(name.GetLastname), txt);
            testCase.verifyTrue(ischar(name.GetFirstname), txt);
            testCase.verifyTrue(name.GetMI == 'N');
            
        end
        %Here is where sprintf needs to be cprintf
        function testContructorArguments(testCase)
        %% testContructorArguments 
        % attempts to create instances of class NameData with combinations 
        % of strings and character arrays containing randomly generated 
        % names with both legal and illegal characters.
        %
        % Input: testCase   TestNameData handle to instance of class
        %                   TestNamedata
        % 
        % Output: void
        % 
        % Syntax: testConstructorArguments(testCase)

            for k=1:100
                first = testCase.randomString;
                last  = testCase.randomString;
                mi    = testCase.randomString(1);
                
                if mod(k,2)
                    [last, first, mi] = convertCharsToStrings(last, first, mi);
                end

                try
                    validdata = true;
                    data  = NameData(last, first, mi);
                catch ME
                    validdata = false;
                    cprintf('r','%s\n%s %s. %s\n', ME.message, first, mi, last);
                    
                    switch ME.message
                        case char('NameData:ValidName:Assertion Failed isstring, ischar')
                            testCase.numberOfIsstringIschar = testCase.numberOfIsstringIschar + 1;
                            
                        case char('NameData:ValidName:Assertion Invalid name string')
                            testCase.numberOfInvalidString = testCase.numberOfInvalidString + 1;
                            
                        otherwise
                            testCase.numberOfOtherErrors = testCase.numberOfOtherErrors + 1;
                            rethrow(ME);
                    end
                end
                
                txt = sprintf('TestNameData:testConstructorArguments: %s %s %s\n', ...
                    first, mi, last);
                
                if validdata
                    testCase.numberOfValidStrings = testCase.numberOfValidStrings + 1;
                    disp(data)
                    testCase.verifyTrue(isa(data,'NameData'));
                    testCase.verifyTrue(ischar(data.GetLastname), txt);
                    testCase.verifyTrue(ischar(data.GetFirstname), txt);
                    testCase.verifyTrue(data.GetMI == mi, txt);
                end
            end
            
            fprintf('\n')
        end
    end
    
    methods(Access=private)
        function s = randomString(testCase, length)
        %% randomString 
        % creates a random string of specified length from a
        % vector or accepatable characters in the SYMBOLS property. Five
        % percent of the time, it will include illegal characters from the
        % INVALIDSYMBOLS vector and .5 percent of the time it will return a
        % double precision floating point number instead of an array of
        % characters.
        %
        % Input: testCase   TestNameData handle to instance of class
        %                   TestNamedata
        %        length     Length of character to return in vector s. The
        %                   default value for length is given by the
        %                   DEFAULTLENGTH property.
        % 
        % Output: s         character vector of specified length, or (.5%)
        %                   a double precision floating number = pi.
        % 
        % Syntax: testConstructor(testCase)
            if nargin < 2
                length = randi(testCase.DefaultLength);
            end
            
            if rand(1,1) > .05
                testsymbols = testCase.symbols;
            else
                if rand(1,1) > .10
                    testsymbols = [ testCase.symbols testCase.invalidsymbols ];
                else
                    s = pi;
                    return;
                end
            end
            
            indices = randi(numel(testsymbols),[1 length]);
            s = testsymbols(indices);
        end
    end
end
