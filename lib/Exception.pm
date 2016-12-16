package Exception;

use Term::ANSIColor;

sub new {
    my ($this, @args) = @_;

    my $obj = {};
    bless $obj, $this;

    $obj->initialize(@args);

    return $obj;
}

sub initialize {
    my ($this, $message) = @_;

    $this->{msg} = color('red') . $message . color('reset');
}

sub message {
    my ($this) = @_;

    return $this->{msg};
}

1;
