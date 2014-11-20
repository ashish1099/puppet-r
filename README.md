# Puppet R module

This module gives you the ability to install R, but also R packages.

## Usage

To install R you need to include the class...

    class { 'r': }

To install any addon packages, and this will automatically update the addon packages also.

    r::package { 'ggplot2': }
    r::package { 'reshape': }

To install addon package without dependencies

    r::package { "forecast" : dependencies => 'FALSE' }
   
To remove package 

    r::package { 'reshape': enusre => absent }
    

