package myapp::Model::User;
use Mojo::Base -base, -signatures;

# The table name and primary key
my $table = 'users';
# my $primary_key = 'id';

# The columns in the table
my @columns = ('name', 'email');

# Define accessors

has 'name';
has 'email';

sub new {
    my ($class, $name, $email) = @_;
    my $self = bless {}, $class;

    $self->{name} = $name;
    $self->{email} = $email;

    return $self;
}

1;
