# package myapp::Config::DatabaseCon;
# use Mojo::Base -base;

# use strict;
# use warnings;
# use Mango;
# use Dotenv;  # Load the Dotenv module

# sub new {
#     my $class = shift;
#     my $self = bless {}, $class;

#     Dotenv->load;
    
#     my $mongodb_uri = 'mongodb://rakesh:MErN123@blogpostbd.9eshkbo.mongodb.net/';

#     # Establish Mango connection to MongoDB
#     $self->{mango} = Mango->new($mongodb_uri);

#     return $self;
# }
# 1;

# sub is_connected {
#     my $self = shift;

#     eval {
#         my $collection = $self->{mango}->db('pqerl')->collection('users');
        
#     };

#     if ($@) {
#         warn "Error while checking connection: $@";
#         return 0;
#     }

#     return 1;
# }


# sub check_connection {
#     my $self = shift;

#     if ($self->is_connected) {
#         print "Database connected.\n";
#     } else {
#         print "Database not connected.\n";
#     }
# }

# 1;











package myapp::Config::DatabaseCon;
use Mojo::Base -base;


use strict;
use warnings;
use MongoDB;
use Dotenv;  # Load the Dotenv module


sub new {
    my $class = shift;
    my $self = bless {}, $class;

    Dotenv->load;
    # Access environment variables
    my $mongodb_uri = $ENV{MONGODB_URI};
    # Establish MongoDB connection
    
    $self->{client} = MongoDB->connect($mongodb_uri);  # Replace with your MongoDB connection URI

    my $data = MongoDB->connect($mongodb_uri);


    return $self;
}

sub is_connected {
    my $self = shift;
    return $self->{client}->connected;
}

sub check_connection {
    my $self = shift;
    
    if ($self->is_connected) {
        
        print "Database connected.\n";
    } else {
        print "Database not connected.\n";
    }
}

1;
