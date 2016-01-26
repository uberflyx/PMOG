function [ ] = Speak( what )
%SPEAK Summary of this function goes here
%   Detailed explanation goes here

NET.addAssembly('System.Speech');
speak = System.Speech.Synthesis.SpeechSynthesizer;
speak.Volume = 100;
Speak(speak,what)

end

