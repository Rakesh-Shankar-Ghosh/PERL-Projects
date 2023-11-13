package myapp::Plugin::CORS;
use Mojo::Base 'Mojolicious::Plugin';

sub register {
    my ($self, $app) = @_;

    # Add a "before_dispatch" hook to set CORS headers
    $app->hook(
        before_dispatch => sub {
            my $c = shift;
            
            if ($c->req->method eq 'OPTIONS') {
                # Handle preflight request
                $c->res->headers->header('Access-Control-Allow-Origin' => 'http://localhost:3001');
                $c->res->headers->header('Access-Control-Allow-Methods' => 'GET, POST, PUT, DELETE, OPTIONS');
                $c->res->headers->header('Access-Control-Allow-Headers' => 'Origin, X-Requested-With, Content-Type, Accept');
                $c->res->headers->header('Access-Control-Max-Age' => 600);  # Optional: Set max age for preflight request caching
                $c->res->headers->header('Content-Type' => 'application/json');  # Set appropriate Content-Type header
                $c->render(data => '', status => 204);  # Return empty response with 204 status
            }
            else {
                # Set CORS headers for other requests
                $c->res->headers->header('Access-Control-Allow-Origin' => 'http://localhost:3001');
                $c->res->headers->header('Access-Control-Allow-Methods' => 'GET, POST, PUT, DELETE, OPTIONS');
                $c->res->headers->header('Access-Control-Allow-Headers' => 'Origin, X-Requested-With, Content-Type, Accept');
            }
        }
    );
}

1;







# package myapp::Plugin::CORS;
# use Mojo::Base 'Mojolicious::Plugin';

# sub register {
#     my ($self, $app) = @_;

#     # Add a "before_dispatch" hook to set CORS headers
#     $app->hook(
#         before_dispatch => sub {
#             my $c = shift;
            
#             # Set CORS headers
#             $c->res->headers->header('Access-Control-Allow-Origin' => 'http://localhost:3001');
#             $c->res->headers->header('Access-Control-Allow-Methods' => 'GET, POST, PUT, DELETE, OPTIONS');
#             $c->res->headers->header('Access-Control-Allow-Headers' => 'Origin, X-Requested-With, Content-Type, Accept');
#             $c->res->headers->header('Content-Type' => 'application/json');
#         }
#     );
# }

# 1;
