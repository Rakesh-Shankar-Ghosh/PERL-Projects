package myapp::Route::StudentRoute;
use Mojo::Base -base;
use myapp::Controller::StudentController;
use Mojo::Base 'Mojolicious', -signatures;



sub register {
    my ($self, $r) = @_;
   
    $r->get('/')->to('StudentController#test');
    $r->get('/temp')->to('StudentController#StudentTest');
    $r->post('/addStudent')->to('StudentController#addStudent');
    $r->get('/getStudents')->to('StudentController#getStudents');
    $r->post('/testaddStudent')->to('StudentController#testaddStudent');
    $r->get('/getStudentById/:id')->to('StudentController#getStudentById');
    $r->put('/updateStudentById/:id')->to('StudentController#updateStudentById');
    $r->delete('/deleteStudentById/:id')->to('StudentController#deleteStudentById');
}

1;

