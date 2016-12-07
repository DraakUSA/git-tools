package GitError;

use Term::ANSIColor;

sub new {
    my ($this, @args) = @_;

    my $obj = {};
    bless $obj, $this;

    $obj->initialize(@args);

    return $obj;
}

sub initialize {
    my ($this, $message, $output) = @_;

    $this->{msg} = color('red') . $message . color('reset');

    if ($output) {
        $this->{msg} .= "\n";
        $this->{msg} .= color('red') . "Here's what Git said:" . color('reset');
        $this->{msg} .= "\n";
        $this->{msg} .= $output;
    }
}

sub message {
    my ($this) = @_;

    return $this->{msg};
}

1;
