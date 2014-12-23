#!/usr/bin/perl
package WWW::StatusBadge::Service::TravisCI;

use strict;
use warnings;

use parent 'WWW::StatusBadge::Service';

sub new {
    my $class = shift;
    my %arg   = @_;

    for my $key ( qw(user repo) ) {
        Carp::croak( sprintf 'missing required parameter %s!', $key )
            unless $arg{ $key };
    }

    my $url = sprintf 'https://travis-ci.org/%s/%s', @arg{ qw(user repo) };
    my $img = join( '.', $url, 'svg' );

    if ( my $branch = $arg{'branch'} ) {
        $img = sprintf '%s?branch=%s', $img, $branch;
    }

    return $class->SUPER::new(
        'txt' => 'Build Status',
        'url' => $url,
        'img' => $img,
    );
}

1;
# ABSTRACT: Travis Status Badge generator
# vim:ts=4:sw=4:syn=perl
__END__
=pod

=head1 SYNOPSIS

    use WWW::StatusBadge::Service::TravisCI;

    my $service = WWW::StatusBadge::Service::TravisCI->new(
        'repo'   => 'Sidekick-Accessor.pm',
        'user'   => 'ARivottiC',
        'branch' => 'develop',
    );

    my $markdown = $service->markdown;

=head1 DESCRIPTION

Generates Travis Status Badges in several formats.

=method new

    my $service = WWW::StatusBadge::Service::TravisCI->new(
        'repo'   => 'Sidekick-Accessor.pm',
        'user'   => 'ARivottiC',
        'branch' => 'develop',
    );

=over 4

=item I<repo =E<gt> $repo_name>

The repository name. Required.

=item I<user =E<gt> $user_name>

The user name. Required.

=item I<branch =E<gt> $branch_name>

The branch name. Optional.

=back

=head1 SEE ALSO

=for :list
* L<WWW::StatusBadge>
* L<WWW::StatusBadge::Service>

=cut
