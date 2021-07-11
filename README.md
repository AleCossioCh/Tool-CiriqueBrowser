# Tool-CritiqueBrowser
Tool-CritiqueBrowser was created on the basic of CriticBrowser. CriticBrowser uses a deprecated version of `SpecCore`. Tool-CritiqueBrowser uses the new version of `SpecCore2`; It is a graphical tool that allows developers to select a list of software packages and a quality rules-group, this resulting on a new list of critiques that broke the selected rules-group.

## Installation

In order to install this tool, perform the following code in a Playground:

    Metacello new
      baseline:'ToolCritiqueBrowser';
      repository: 'github://AleCossioCh/Tool-CritiqueBrowser:master/src';
      load.
## How to open it

Once you have installed, select Browse and then CritiqueBrowser with error icon ![Screenshot from 2021-07-07 18-47-14](https://user-images.githubusercontent.com/23039347/124837923-cf695b00-df53-11eb-9731-ab1c6cd92e52.png)

![Screenshot from 2021-07-07 18-39-15](https://user-images.githubusercontent.com/23039347/124838096-20794f00-df54-11eb-8391-b772f1ba7c26.png)

## GSoC21 Refining code critiques
The migration of this tool as well as the improvements to the interface are part of my project to GSoC21; For more information, see the [Refining code critics proposal](https://summerofcode.withgoogle.com/projects/#6095801345900544).

## About the name

"It is worth mentioning that the developers of CriticBrowser confused the word critique (an instance of criticism) with critic (a person who criticizes)" (Yuriy Tymchuk's, Quality-Aware Tooling, 2017 : p.52) 
I saw an opportunity to rename the tool :) 


