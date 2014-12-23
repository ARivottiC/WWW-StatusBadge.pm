#!/usr/bin/perl
package WWW::StatusBadge::Plugin::BadgeFury;

use strict;
use warnings;

use WWW::StatusBadge::Service::BadgeFury;

sub service {
    return WWW::StatusBadge::Service::BadgeFury->new( shift->args, @_ );
}

1;
# ABSTRACT: StatusBadge plugin for Badge Fury
# vim:ts=4:sw=4:syn=perl
__END__
=pod

=head1 SYNOPSIS

    use WWW::StatusBadge;

    my $badge = WWW::StatusBadge->new(
        'dist'   => 'WWW-StatusBadge',
        'branch' => 'develop',
    );

    my $service = $badge->coveralls;

=for Pod::Coverage service

=head1 SEE ALSO

=for :list
* L<WWW::StatusBadge>
* L<WWW::StatusBadge::Service::BadgeFury>

=cut
