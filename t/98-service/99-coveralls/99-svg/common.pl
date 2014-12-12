#!/usr/bin/perl

use strict;
use warnings;

use WWW::StatusBadge::Service;

no warnings 'redefine';

sub common_args {(
        'user'   => 'USER',
        'repo'   => 'REPO',
        'branch' => 'BRANCH',
        'svg'    => 1,
);}

sub common_img { 'https://img.shields.io/coveralls/USER/REPO.svg'; }

1;
