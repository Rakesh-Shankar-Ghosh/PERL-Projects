use strict;
use warnings;
use Dotenv;

if (eval { require Mojolicious::Routes

 }) {
    print "Dotenv is installed.\n";
} else {
    print "Dotenv is not installed.\n";
}

#its shows u that a package locally installed or not {using cpanm}