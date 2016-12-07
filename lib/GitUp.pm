package GitUp;

our $VERSION = 0.1.0;

use Carp;
use GitError;
use Scalar::Util "blessed";
use Term::ANSIColor;

my $config = {};

sub new {
    my ($this) = @_;

    my $obj = {};
    bless $obj, $this;

    return $obj;
}

sub run {
    my ($this, @args) = @_;

    eval {
        $this->{fetch} = 1;

        $this->process_args(@args);

        if ($this->{fetch}) {
            my @command = qw/ git fetch --multiple /;
            push @command, qw/ --prune / if $this->_prune();
            push @command, $config->{fetch.all} ? qw/ --all / : @{$this->{remotes}};

            system(@command);
            confess GitError->new("`git fetch` failed") if $?;
        }

        $this->{remote_map} = undef;

        $this->with_stash(sub {$this->returning_to_current_branch(sub {$this->rebase_all_branches()})});

        $me->check_bundler();
    };
    if (my $e = $@) {
        if (blessed($e) && $e->isa("GitError")) {
            print $e->message(), "\n";
            exit(1);
        }
        else {
            die "Unknown Expection: ".$e;
        }
    }
}

sub process_args {
    my ($this, @args) = @_;

    my $banner = <<BANNER;
Fetch and rebase all remotely-tracked branches.

    $ git up
    master         #{"up to date".green}
    development    #{"rebasing...".yellow}
    staging        #{"fast-forwarding...".yellow}
    production     #{"up to date".green}

    $ git up --version    # print version info
    $ git up --help       # print this message

There are no interesting command-line options, but
there are a few `git config` variables you can set.
For info on those and more, check out the man page:

    $ git up man

Or install it to your system, so you can get to it with
`man git-up` or `git help up`:

    $ git up install-man

BANNER

    my $man_path = '../../man/git-up.1';

    foreach my $arg (@args) {
        if ($arg eq "-v" || $arg eq "--version") {
            print "git-up " . $VERSION . "\n";
            exit(0);
        }
        elsif ($arg eq "man") {
            system("man", $man_path);
            exit(0);
        }
        elsif ($arg eq "install-man") {
            print STDERR "TBC\n";
            exit(1);
        }
        elsif ($arg eq "-h" || $arg eq "--help") {
            print STDERR $banner;
            exit(0)
        }
        else {
            print STDERR $banner;
            exit(1)
        }
    }
}

sub rebase_all_branches {
    my ($this, $proc) = @_;

    print "TBC: rebase_all_branches\n";
}

sub repo {
    my ($this) = @_;

    return $this->{repo} ||= $this->get_repo();
}

sub get_repo {
    my ($this) = @_;

    my ($repo_dir) = `git rev-parse --show-toplevel`;
    my $err = $?;
    chomp $repo_dir;

    if ($err == 0) {
        chdir $repo_dir;
        #$this->{repo} = Grit::Repo.new(repo_dir)
    }
    else {
        confess GitError->new("We don't seem to be in a git repository.");
    }
}

sub branches {
    my ($this, $proc) = @_;

    print "TBC: branches\n";
}

sub remotes {
    my ($this, $proc) = @_;

    print "TBC: remotes\n";
}

sub remote_map {
    my ($this, $proc) = @_;

    print "TBC: remote_map\n";
}

sub remote_for_branch {
    my ($this, $proc) = @_;

    print "TBC: remote_for_branch\n";
}

sub with_stash {
    my ($this, $proc) = @_;

    my $stashed = 0;

    if ($this->_change_count() > 0) {
        print color('magenta') . "stashing " . $this->{change_count} . " change(s)". color('reset') . "\n";
        `git stash`;
        $stashed = true
    }

    $proc->();

    if ($stashed) {
        print color('magenta') . "unstashing" . color('reset') . "\n";
        `git stash pop`;
    }
}

sub returning_to_current_branch {
    my ($this, $proc) = @_;

    print "TBC: returning_to_current_branch\n";

    $proc->();

    print "TBC: returning_to_current_branch\n";
}

sub checkout {
    my ($this, $proc) = @_;

    print "TBC: checkout\n";
}

sub log {
    my ($this, $proc) = @_;

    print "TBC: log\n";
}

sub rebase {
    my ($this, $proc) = @_;

    print "TBC: rebase\n";
}

sub check_bundler {
    my ($this, $proc) = @_;

    print "TBC: check_bundler\n";
}

sub is_fast_forward {
    my ($this, $proc) = @_;

    print "TBC: is_fast_forward\n";
}

sub merge_base {
    my ($this, $proc) = @_;

    print "TBC: merge_base\n";
}

sub on_branch {
    my ($this, $proc) = @_;

    print "TBC: on_branch\n";
}

#-----------------------------------------------------------------------
# private methods
#-----------------------------------------------------------------------

sub _use_bundler {
    my ($this, $proc) = @_;

    print "TBC: _use_bundler\n";
}

sub _use_bundler_config {
    my ($this, $proc) = @_;

    print "TBC: _use_bundler_config\n";
}

sub _prune {
    my ($this, $proc) = @_;

    print "TBC: _prune\n";
}

sub _change_count {
    my ($this) = @_;

    my @status = `git status --porcelain --untracked=no`;
    return $this->{change_count} = 0 || scalar(@status);
}

sub _config {
    my ($this, $proc) = @_;

    print "TBC: _config\n";
}

sub _git_version_at_least {
    my ($this, $proc) = @_;

    print "TBC: _git_version_at_least\n";
}

sub _version_array {
    my ($this, $proc) = @_;

    print "TBC: _version_array\n";
}

sub _git_version {
    my ($this) = @_;

    my $vers_str = `git --version`;
    chomp $vers_str;
    $vers_str =~ /(\d+(\.\d+)+)/;
    $vers_str = $1;
    
    return $vers_str;
}

1;
