package Repo;

use File::Spec;

sub new {
    my ($this, @args) = @_;

    my $obj = {};
    bless $obj, $this;

    $obj->initialize(@args);

    return $obj;
}

sub initialize {
    my ($this, $path, $options) = @_;
    $options ||= {};
    
    my $abs_path = File::Spec->rel2abs( $path ) ;
    
    warn "TBC: initialize";
}

1;
