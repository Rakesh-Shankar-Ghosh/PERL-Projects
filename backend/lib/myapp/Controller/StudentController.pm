package myapp::Controller::StudentController;
use Mojo::Base 'Mojolicious::Controller', -signatures;

use MongoDB::OID;
use myapp::Model::User;
use myapp::Config::DatabaseCon;
use Mojo::JSON qw(decode_json);


my $database_con = myapp::Config::DatabaseCon->new;
my $client = $database_con->{client};
my $db = $client->get_database('perl');


sub updateStudentById ($self) {
    eval {
        my $student_id = $self->param('id');
        my $json_input = $self->req->json;

        my $collection = $db->get_collection('users');
        
        # Convert the student ID string to MongoDB::OID
        my $oid = MongoDB::OID->new(value => $student_id);

        my $student = $collection->find_one({ _id => $oid });

        unless ($student) {
            $self->render(json => { success => 0, message => 'Student not found' }, status => 404);
            return;
        }

        # Update the student data
        foreach my $field (keys %$json_input) {
            $student->{$field} = $json_input->{$field};
        }

        # Save the updated student data
        $collection->replace_one({ _id => $oid }, $student);

        $self->render(json => { success => 1, message => 'Student updated successfully' }, status => 200);
    };

    if ($@) {
        $self->render(json => { success => 0, message => 'Error while updating student', error => "$@" }, status => 500);
    }
}

1;

sub deleteStudentById ($self) {
    eval {
        my $student_id = $self->param('id');
        my $collection = $db->get_collection('users');
        
        # Convert the student ID string to MongoDB::OID
        my $oid = MongoDB::OID->new(value => $student_id);

        my $delete_result = $collection->delete_one({ _id => $oid });

        if ($delete_result->deleted_count > 0) {
            $self->render(json => { success => 1, message => 'Student deleted successfully' }, status => 200);
        } else {
            $self->render(json => { success => 0, message => 'Student not found' }, status => 404);
        }
    };

    if ($@) {
        $self->render(json => { success => 0, message => 'Error while deleting student', error => "$@" }, status => 500);
    }
}


sub getStudentById ($self) {
    eval {
        my $student_id = $self->param('id');
        my $collection = $db->get_collection('users');
        
        # Convert the student ID string to MongoDB::OID
        my $oid = MongoDB::OID->new(value => $student_id);

        my $student = $collection->find_one({ _id => $oid });

        if ($student) {
            my %student_data;
            foreach my $field (keys %$student) {
                $student_data{$field} = $student->{$field};
            }
            
            $self->render(json => { success => 1, student => \%student_data }, status => 200);
        } else {
            $self->render(json => { success => 0, message => 'Student not found' }, status => 404);
        }
    };

    if ($@) {
        $self->render(json => { success => 0, message => 'Error while retrieving student', error => "$@" }, status => 500);
    }
}

1;


sub getStudents ($self) {
    eval {
        my $collection = $db->get_collection('users');
        my $cursor = $collection->find({});  # Retrieve all documents

        my @students;
        while (my $student = $cursor->next) {
            my %student_data;
            foreach my $field (keys %$student) {
                $student_data{$field} = $student->{$field};
            }
            push @students, \%student_data;
        }

        if (@students) {
            $self->render(json => { success => 1, students => \@students }, status => 200);
        } else {
            $self->render(json => { success => 0, message => 'No students found' }, status => 404);
        }
    };

    if ($@) {
        $self->render(json => { success => 0, message => 'Error while retrieving students', error => "$@" }, status => 500);
    }
}


# USES Eval which is equvalent to try catch procedue 2
sub addStudent ($self) {
    eval {
        my $json_input = $self->req->json;
     
        unless ($json_input) {
            $self->render(json => { error => 'Invalid JSON data' }, status => 400);
            return;
        }

        my $name = $json_input->{name};
        my $email = $json_input->{email};

        unless ($name && $email) {
            $self->render(json => { error => 'Name and email are required fields' }, status => 400);
            return;
        }

        my $user = myapp::Model::User->new(name => $name, email => $email);;

        my $collection = $db->get_collection('users');
        my $inserted_result = $collection->insert_one($user);

        if ($inserted_result->inserted_id) {
            $self->render(json => { message => 'Student added successfully', success => 1 }, status => 200);
        } else {
            $self->render(json => { message => 'Failed to add student' }, status => 500);
        }
    };

    if ($@) {
        $self->render(json => { message => 'Error while adding student', error => "$@" }, status => 500);
    }
}

1;


# # //*************************** # USES Eval which is equvalent to try catch procedue 3 {first success execution }
# sub addStudent ($self) {
#     my $json_input = $self->req->json;

#     unless ($json_input) {
#         $self->render(json => { error => 'Invalid JSON data' }, status => 400);
#         return;
#     }

#     # Extract name and email from JSON input
#     my $name = $json_input->{name};
#     my $email = $json_input->{email};

#     unless ($name && $email) {
#         $self->render(json => { error => 'Name and email are required fields' }, status => 400);
#         return;
#     }

#     # Create a new user model instance
#     my $user = myapp::Model::User->new(name => $name, email => $email);

#     # Get a reference to the MongoDB client from the DatabaseCon module


#     # Get a reference to the 'users' collection within the 'perl' database
#     my $collection = $db->get_collection('users');

#     # Insert the user data into the 'users' collection
#     my $inserted_result = $collection->insert_one($user);

#     if ($inserted_result->inserted_id) {
#        $self->render(text => 'Student added successfully');
#     } else {
#        $self->render(text => 'Failed to add student', status => 500);
#     }
# }

# 1;








# JUST TEST POST METHDO WORKS OR NOT
sub testaddStudent ($self) {
    # Get the JSON data from the request body
    my $json_data = $self->req->body;
            
    eval {
        # Decode the JSON data
        my $student_data = decode_json($json_data);
        
        my $result = {
            success => 1,
            message => "Student added successfully",
            data    => $student_data,
        };

        $self->render(
            json   => $result,
            status => 200,
        );
    };

    if ($@) {
        $self->render(
            json   => {
                success => 0,
                message => "Error while adding student",
                error   => "$@",
            },
            status => 500,
        );
    }
}

1;






#DUMMYYY
# # Import necessary modules
# use Mojo::JSON qw(decode_json);

# # Add the method to the controller
# sub addStudent ($self) {
#     my $user_model = $self->app->model('User'); # Load the user model

#     # Get the JSON data from the request body
#     my $json_data = $self->req->body;

#     eval {
#         # Decode the JSON data
#         my $student_data = decode_json($json_data);

#         # Use the model to add the student
#         my $result = $user_model->add_student($student_data);

#         if ($result->{success}) {
#             $self->render(
#                 json   => {
#                     success => 1,
#                     message => "Student added successfully",
#                     data    => $student_data,
#                 },
#                 status => 200,
#             );
#         } else {
#             $self->render(
#                 json   => {
#                     success => 0,
#                     message => "Failed to add student",
#                 },
#                 status => 500,
#             );
#         }
#     };

#     if ($@) {
#         $self->render(
#             json   => {
#                 success => 0,
#                 message => "Error while adding student",
#                 error   => "$@",
#             },
#             status => 500,
#         );
#     }
# }

# 1;






sub StudentTest ($self) {
    $self->render(text => 'I am from stdent Controller Test');
}


sub test ($self) {
    my $data = 5;

    eval {
        if ($data == 5) {
            $self->render(
                json => {
                    success => 1,
                    message => "perfectly done",
                    data    => $data,
                },
                status => 200,
            );
        } else {
            $self->render(
                json => {
                    success => 0,
                    message => "failed",
                },
                status => 500,
            );
        }
    };
    
    if ($@) {
        $self->render(
            json => {
                success => 0,
                message => "Error while getting",
                error   => "$@",
            },
            status => 500,
        );
    }
}


# sub StudentTest {
 
#     my $res = shift;

#     $res->render(text => 'This is the temp route');
# }






1;