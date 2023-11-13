Before installing anything package or else please chek it is already install or not

# PROJECT SETUP

- install Sterwbry perl {check if u already have}
- cpan Mojolicious {check the version if u have allready install it}
- mojo generate app MyApp
- cd MyApp
- morbo script/myapp

# PACKAGES

- cpan are globally installtion comad
- if u want to install locall use the "cpanm" use it
- but for use cpanm u have to instal like {cpan App::cpanminus} first
- then u can use cpanm exmple: cpanm Dotenv. but cpan Dotenve globally installed in perl envrmnt.

# Yes, cpanm allows you to install Perl modules locally within your user's home directory, which is separate from the system-wide Perl installation. This can be useful if you want to manage Perl modules without affecting the system-wide environment or if you don't have administrative privileges to install modules globally.

# When you install Perl modules locally using cpanm, they are placed in a specific directory within your home directory. This directory is commonly referred to as the "local::lib" directory. The modules you install locally will only be available to the Perl scripts you run using the local::lib environment.

- so why pcanm, coz it is alternative and fast

# using .env

- here it is install locally
- cpanm --force Dotenv
- remember so much inport secrate is for env and less secrate for ymal

# Database set up

- used MongoDB as globally installed
- cpan MongoDB {took much time}

# Path declear system and export and import

- is given in project

# CORS

- so much important

- plguin is called here midddle ware, used in poroject u can see CROS is kind of middle ware

# Important

- In mojolicious Middleware are called Plugin {application lavel}
- and Filters are called hook {routess or controller or method leavel}
