#!/usr/bin/perl
package WWW::StatusBadge;

use strict;
use warnings;

use Carp ();
use Hash::Util::FieldHash ();
use Module::Pluggable::Object ();

Hash::Util::FieldHash::fieldhash my %Arg;

sub new {
    my $class = shift;
    my %arg   = @_;

    my $self = do {
        my $o; bless \( $o ), ref $class || $class || __PACKAGE__
    };

    $Arg{ $self } = { %arg };

    return $self;
}

sub args { return %{ $Arg{ shift() } }; }

my $package = __PACKAGE__;
my $finder = Module::Pluggable::Object->new(
        'package' => $package, 'require' => 1,
    );

{
    no strict 'refs';
    for my $plugin ( $finder->plugins ) {
        my $service = $plugin->can('service')
            || next;
        my $method = join( '_', ( split '::', lc $plugin )[3,] );
        *{ sprintf '%s::%s', $package, $method } = $service;
    }
}

1;
# ABSTRACT: Plugin based Status Badge generator
# vim:ts=4:sw=4:syn=perl
__END__
=pod

=for :Badges
=for markdown
[![Build Status](https://travis-ci.org/ARivottiC/WWW-StatusBadge.pm.svg)](https://travis-ci.org/ARivottiC/WWW-StatusBadge.pm)
[![Coverage Status](https://img.shields.io/coveralls/ARivottiC/WWW-StatusBadge.pm.svg)](https://coveralls.io/r/ARivottiC/WWW-StatusBadge.pm?branch=master)
[![CPAN version](https://badge.fury.io/pl/WWW-StatusBadge.svg)](http://badge.fury.io/pl/WWW-StatusBadge)

=head1 SYNOPSIS

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

=head1 DESCRIPTION

C<WWW::StatusBadge> .

=method new

    my $badge = WWW::StatusBadge->new(
        'repo'   => 'WWW-StatusBadge.pm',
        'dist'   => 'WWW-StatusBadge',
        'user'   => 'ARivottiC',
        'branch' => 'develop',
    );

None of the following are required and may vary depending on the plugin used.

=over 4

=item I<repo =E<gt> $repo_name>

The repository name.

=item I<dist =E<gt> $dist_name>

The distribution name.

=item I<user =E<gt> $user_name>

The user name.

=item I<branch =E<gt> $branch_name>

The branch name.

=back

See L<WWW::StatusBadge::Service> for more info.

=attr args

Returns the original args used in the constructor.

=for Pod::Coverage travis coveralls badgefury cpan github

=head1 PLUGINS

    package WWW::StatusBadge::Plugin::Travis;

    use WWW::StatusBadge::Service::TravisCI;

    sub service {
        return WWW::StatusBadge::Service::TravisCI->new( shift->args, @_ );
    }

    1;

=head1 SEE ALSO

=for :list
* L<WWW::StatusBadge::Plugin::Travis>
* L<WWW::StatusBadge::Plugin::Coveralls>
* L<WWW::StatusBadge::Plugin::BadgeFury>
* L<WWW::StatusBadge::Plugin::CPAN>
* L<WWW::StatusBadge::Service>

=cut
