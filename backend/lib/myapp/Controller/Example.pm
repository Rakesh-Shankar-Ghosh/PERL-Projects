package myapp::Controller::Example;
use Mojo::Base 'Mojolicious::Controller', -signatures;

# This action will render a template
sub welcome ($self) {
    $self->render(text => 'Hello, World!');
}

sub test ($self) {
    $self->render(text => 'Test Hello, World!');
}

1;
