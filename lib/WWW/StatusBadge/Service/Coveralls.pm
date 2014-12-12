#!/usr/bin/perl
package WWW::StatusBadge::Service::Coveralls;

use strict;
use warnings;

use parent 'WWW::StatusBadge::Service';

sub new {
    my $class = shift;
    my %arg   = @_;

    for my $key ( qw(user repo branch) ) {
        Carp::croak( sprintf 'missing required parameter %s!', $key )
            unless $arg{ $key };
    }

    my @values = @arg{ qw(user repo branch) };

    my $url = sprintf 'https://coveralls.io/r/%s/%s?branch=%s', @values;

    my $format = 'https://coveralls.io/repos/%s/%s/badge.png?branch=%s';
    if ( $arg{'svg'} ) {
        $format = 'https://img.shields.io/coveralls/%s/%s.svg';
        pop @values;
    }

    return $class->SUPER::new(
        'txt' => 'Coverage Status',
        'url' => $url,
        'img' => sprintf( $format, @values ),
    );
}

1;
# ABSTRACT: Coveralls Status Badge generator
# vim:ts=4:sw=4:syn=perl
__END__
=pod

=head1 SYNOPSIS

    use WWW::StatusBadge::Service::Coveralls;

    my $service = WWW::StatusBadge::Service::Coveralls->new(
        'repo'   => 'Sidekick-Accessor.pm',
        'user'   => 'ARivottiC',
        'branch' => 'master',
    );

    my $markdown = $service->markdown;

=head1 DESCRIPTION

Generates Coveralls Status Badges in several formats.

=method new

    my $service = WWW::StatusBadge::Service::Coveralls->new(
        'repo'   => 'Sidekick-Accessor.pm',
        'user'   => 'ARivottiC',
        'branch' => 'master',
    );

=over 4

=item I<repo =E<gt> $repo_name>

The repository name. Required.

=item I<user =E<gt> $user_name>

The user name. Required.

=item I<branch =E<gt> $branch_name>

The branch name. Required.

=back

=head1 SEE ALSO

=for :list
* L<WWW::StatusBadge>
* L<WWW::StatusBadge::Service>

=cut
