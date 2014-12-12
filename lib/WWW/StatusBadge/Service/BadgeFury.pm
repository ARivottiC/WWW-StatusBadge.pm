#!/usr/bin/perl
package WWW::StatusBadge::Service::BadgeFury;

use strict;
use warnings;

use parent 'WWW::StatusBadge::Service';

# for internal functions
my ($croak_missing, $require, $user_and_repo_to_dist);

my %for_to_text = (
    'bo' => 'Bower version',
    'co' => 'Pod version',
    'gh' => 'GitHub version',
    'js' => 'npn version',
    'nu' => 'NuGet version',
    'pl' => 'CPAN version',
    'py' => 'PyPI version',
    'rb' => 'Gem version',
);

sub new {
    my $class = shift;
    my %arg   = @_;

    $user_and_repo_to_dist->( \%arg );

    for my $key ( qw(for dist) ) {
        $key->$croak_missing
            unless $arg{ $key };
    }

    my ($for, $dist) = @arg{ qw(for dist) };
    my $txt = $for_to_text{ $for };

    Carp::croak( sprintf 'not suported: %s', $for )
        unless $txt;

    my $url = sprintf 'http://badge.fury.io/%s/%s', $for, $dist;
    my $img = sprintf 'https://badge.fury.io/%s/%s.svg', $for, $dist;

    return $class->SUPER::new(
        'txt' => $txt,
        'url' => $url,
        'img' => $img,
    );
}

# Internal Functions
$croak_missing = sub {
    Carp::croak( sprintf 'missing required parameter %s!', shift );
};

$require = sub { $_[0]{ $_[1] } || $croak_missing->( $_[1] ); };

$user_and_repo_to_dist = sub {
    my %arg = %{ $_[0] };
    my ($user, $repo) = $arg{ qw(user repo) };

    if ( $user || $repo ) {
        $require->( \%arg, 'user' );
        $require->( \%arg, 'repo' );

        $_[0]{'dist'} = join '/', $user, $repo;
    }
};

1;
# ABSTRACT: Badge Fury Status Badge generator
# vim:ts=4:sw=4:syn=perl
__END__
=pod

=head1 SYNOPSIS

    use WWW::StatusBadge::Service::BadgeFury;

    my $service = WWW::StatusBadge::Service::BadgeFury->new(
        'dist' => 'Sidekick-Accessor',
        'for'  => 'pl',
    );

    my $markdown = $service->markdown;

=head1 DESCRIPTION

Generates Badge Fury Status Badges in several formats.

=method new

    my $service = WWW::StatusBadge::Service::BadgeFury->new(
        'dist' => 'Sidekick-Accessor',
        'for'  => 'pl',
    );

=over 4

=item I<dist =E<gt> $dist_name>

The distribution name. Required.

=item I<for =E<gt> $language_extension>

Allowed extensions:

=for :list
* I<bo =E<gt> Bower>
* I<co =E<gt> Pod>
* I<gh =E<gt> GitHub>
* I<js =E<gt> npn>
* I<nu =E<gt> NuGet>
* I<pl =E<gt> CPAN>
* I<py =E<gt> PyPI>
* I<rb =E<gt> Gem>

Required.

=item I<repo =E<gt> $repo_name>
=item I<user =E<gt> $user_name>

If both are set, I<dist> will be override with "$user_name/$repo_name".
Optional unless one of them is defined.

=back

=head1 SEE ALSO

=for :list
* L<WWW::StatusBadge>
* L<WWW::StatusBadge::Service>

=cut
