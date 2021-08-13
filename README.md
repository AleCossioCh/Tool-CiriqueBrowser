# Tool-CritiqueBrowser
Tool-CritiqueBrowser was created on the basic of CriticBrowser. CriticBrowser uses a deprecated version of [Spec](https://github.com/pharo-spec/Spec). Tool-CritiqueBrowser uses the new version of `Spec2`; It is a graphical tool that allows developers to select a list of software packages and a list of quality rules, this resulting on a new list of critiques that broke the selected rules. Tool-CritiqueBrowser helps Pharo developers avoid inspecting method by method to see if there are critiques to fix them. 

## Installation and how to open it

In order to install this tool, perform the following code in a Playground:

    Metacello new
      baseline:'ToolCritiqueBrowser';
      repository: 'github://AleCossioCh/Tool-CritiqueBrowser:master/src';
      load.

Once you have installed, select Browse and then click on CritiqueBrowser with error icon ![Screenshot from 2021-07-07 18-47-14](https://user-images.githubusercontent.com/23039347/124837923-cf695b00-df53-11eb-9731-ab1c6cd92e52.png)

![How to install and open](https://user-images.githubusercontent.com/23039347/129285364-2430e657-4b27-4062-a5f4-4c163a34b2f6.gif)

## How to select packages and rules

Next step is selecting packages and rules, as example:

![2  How to select](https://user-images.githubusercontent.com/23039347/129285933-07acd67a-866d-459c-b96e-a759e0a8e73b.gif)

* You can use the filter to look for your packages faster

## GSoC'21 - Refining code critics

The migration of this tool as well as the improvements to the UI are part of my project to GSoC21; For more information, see the [Refining code critics proposal](https://summerofcode.withgoogle.com/projects/#6095801345900544).

## About the name

"It is worth mentioning that the developers of CriticBrowser confused the word critique (an instance of criticism) with critic (a person who criticizes)" (Yuriy Tymchuk's, Quality-Aware Tooling, 2017 : p.52) 
I saw an opportunity to rename the tool :) 


