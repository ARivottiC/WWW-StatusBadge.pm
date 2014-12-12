
[![Build Status](https://travis-ci.org/ARivottiC/WWW-StatusBadge.pm.svg)](https://travis-ci.org/ARivottiC/WWW-StatusBadge.pm)
[![Coverage Status](https://img.shields.io/coveralls/ARivottiC/WWW-StatusBadge.pm.svg)](https://coveralls.io/r/ARivottiC/WWW-StatusBadge.pm?branch=master)
[![CPAN version](https://badge.fury.io/pl/WWW-StatusBadge.svg)](http://badge.fury.io/pl/WWW-StatusBadge)

# NAME

WWW::StatusBadge - Plugin based Status Badge generator

# VERSION

version 0.0.1

# SYNOPSIS

    use WWW::StatusBadge;

    my $badge = WWW::StatusBadge->new(
        'repo'   => 'WWW-StatusBadge.pm',
        'dist'   => 'WWW-StatusBadge',
        'user'   => 'ARivottiC',
        'branch' => 'develop',
    );

    my $travis_markdown   = $badge->travis->markdown;
    my $coveralls_textile = $badge->coveralls->textile;
    my $cpan_rst          = $badge->badgefury( 'for' => 'perl' )->rst;

# DESCRIPTION

`WWW::StatusBadge` .

# ATTRIBUTES

## args

Returns the original args used in the constructor.

# METHODS

## new

    my $badge = WWW::StatusBadge->new(
        'repo'   => 'WWW-StatusBadge.pm',
        'dist'   => 'WWW-StatusBadge',
        'user'   => 'ARivottiC',
        'branch' => 'develop',
    );

None of the following are required and may vary depending on the plugin used.

- _repo => $repo\_name_

    The repository name.

- _dist => $dist\_name_

    The distribution name.

- _user => $user\_name_

    The user name.

- _branch => $branch\_name_

    The branch name.

See [WWW::StatusBadge::Service](https://metacpan.org/pod/WWW::StatusBadge::Service) for more info.

# PLUGINS

    package WWW::StatusBadge::Plugin::Travis;

    use WWW::StatusBadge::Service::TravisCI;

    sub service {
        return WWW::StatusBadge::Service::TravisCI->new( shift->args, @_ );
    }

    1;

# SEE ALSO

- [WWW::StatusBadge::Plugin::Travis](https://metacpan.org/pod/WWW::StatusBadge::Plugin::Travis)
- [WWW::StatusBadge::Plugin::Coveralls](https://metacpan.org/pod/WWW::StatusBadge::Plugin::Coveralls)
- [WWW::StatusBadge::Plugin::BadgeFury](https://metacpan.org/pod/WWW::StatusBadge::Plugin::BadgeFury)
- [WWW::StatusBadge::Plugin::CPAN](https://metacpan.org/pod/WWW::StatusBadge::Plugin::CPAN)
- [WWW::StatusBadge::Service](https://metacpan.org/pod/WWW::StatusBadge::Service)

# AUTHOR

André Rivotti Casimiro <rivotti@cpan.org>

# COPYRIGHT AND LICENSE

This software is Copyright (c) 2014 by André Rivotti Casimiro.

This is free software, licensed under:

    The Artistic License 2.0 (GPL Compatible)
