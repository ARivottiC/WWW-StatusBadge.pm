#!/usr/bin/perl
package WWW::StatusBadge::Plugin::Travis;

use strict;
use warnings;

use WWW::StatusBadge::Service::TravisCI;

sub service {
    return WWW::StatusBadge::Service::TravisCI->new( shift->args, @_ );
}

1;
# ABSTRACT: StatusBadge plugin for Travis
# vim:ts=4:sw=4:syn=perl
__END__
=pod

=head1 SYNOPSIS

    use WWW::StatusBadge;

    my $badge = WWW::StatusBadge->new(
        'repo'   => 'WWW-StatusBadge.pm',
        'user'   => 'ARivottiC',
        'branch' => 'develop',
    );

    my $service = $badge->travis;

=for Pod::Coverage service

=head1 SEE ALSO

=for :list
* L<WWW::StatusBadge>
* L<WWW::StatusBadge::Service::TravisCI>

=cut
