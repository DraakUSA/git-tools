package Exception::GitError;

use Term::ANSIColor;

use base Exception::StandardError;

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

1;
