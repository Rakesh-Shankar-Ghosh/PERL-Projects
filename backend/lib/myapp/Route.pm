      # MyApp/Routes.pm
package myapp::Route;
use Mojo::Base -base;

sub register {
    my ($self, $r) = @_;

    # Normal route to controller
    $r->get('/')->to('Example#welcome');
    $r->get('/test')->to('Example#test');
    # Add more routes here
}

1;
