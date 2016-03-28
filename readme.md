# fluid
A concept for recording gym workouts. Used as an exercise to experiment with a complex data storage problem (CrossFit workouts come in many different varieties) and knockout.js.

Currently very incomplete, because it turns out no matter how clever you are with data structures in databases and drag and drop interfaces, data entry is really terrible by hand and after I've just finished a workout the last thing I want to do is data entry.

## Configuration (OS X)
fluid uses bundler to configure the prerequisites, and that means a whole host of hoop-jumping on OS X.

    brew install rbenv ruby-builder
    rbenv install 2.2.3
    gem update --system
    gem install bundler compass
    bundler update

## Local development
Just cd into the directory and run `make`. It will update the sass, and then run `rackup` for you. Visit localhost:9292 (assuming WEBrick) to play.

# Copyright & licensing
Copyright 2015-2016 Pieter Sartain, and released under the MIT license. See license.txt for details.