package myapp::Plugin::MyHook;

use Mojo::Base -strict;

sub before_dispatch_hook {
    my ($c) = @_;

    # Your hook logic here
    if ($c->req->url->path->contains('/test')) {
        $c->render(text => 'This request did not reach the router.');
    }
}

1;


sub after_dispatch_hook {
    my ($c) = @_;

    # Your 'after_dispatch' hook logic here
    $c->app->log->debug("After dispatch hook was triggered");
}

1;

