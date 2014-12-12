#!/usr/bin/perl
package WWW::StatusBadge::Plugin::CPAN;

use strict;
use warnings;

sub service {
    return shift->badgefury( @_, 'for' => 'pl' );
}

1;
# ABSTRACT: StatusBadge plugin for CPAN
# vim:ts=4:sw=4:syn=perl
__END__
=pod

=head1 SYNOPSIS

    use WWW::StatusBadge;

    my $badge = WWW::StatusBadge->new(
        'dist'   => 'WWW-StatusBadge',
        'branch' => 'develop',
    );

    my $service = $badge->cpan;

=for Pod::Coverage service

=head1 SEE ALSO

=for :list
* L<WWW::StatusBadge>
* L<WWW::StatusBadge::Service::BadgeFury>

=cut
