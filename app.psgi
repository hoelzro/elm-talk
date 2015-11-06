#!/usr/bin/env perl

# A stupid PSGI Perl application that serves up the Fibonacci
# sequence on /fibonacci, and forwards everything else to Elm
# reactor.  You'll need Plack and Plack::App::Proxy installed
# to run this, but you'll only need it for OneTimeRequest.elm
# and RepeatedRequest.elm.

use strict;
use warnings;

use Plack::Builder;
use Plack::App::Proxy;

sub fib {
    my ( $n ) = @_;

    my $a = 1;
    my $b = 0;

    for(1..$n) {
        ($a, $b) = ($a + $b, $a);
    }

    return $a;
}

sub fib_app {
    my ( $env ) = @_;

    my $answer = 0;

    if($env->{'PATH_INFO'} =~ m{/(\d+)}) {
        my $param = $1;
        $answer = fib($param);
    }

    [
        200,
        ['Content-Type' => 'text/plain'],
        [$answer],
    ]
}

my $proxy = Plack::App::Proxy->new(remote => 'http://localhost:8000');

builder {
    mount '/fibonacci' => \&fib_app;
    mount '/'          => $proxy->to_app;
};
