package myapp;
use Mojo::Base 'Mojolicious', -signatures;
use myapp::Route::StudentRoute;  # Import your routes module
# This method will run once at server start
use myapp::Config::DatabaseCon;
use myapp::Plugin::CORS;

use myapp::Plugin::MyHook; 

sub startup ($self) {

  # Load configuration from config file
  my $config = $self->plugin('NotYAMLConfig');

# Middleware
  $self->plugin('myapp::Plugin::CORS');
  # Configure the application
  $self->secrets($config->{secrets});


  my $db_conn = myapp::Config::DatabaseCon->new;
  $db_conn->check_connection();

  #filters
  $self->hook(before_dispatch => \&myapp::Plugin::MyHook::before_dispatch_hook);
  $self->hook(after_dispatch => \&myapp::Plugin::MyHook::after_dispatch_hook);

  my $r = $self->routes;
  myapp::Route::StudentRoute->register($r);  # Register the routes using the imported method
  

}

1;


