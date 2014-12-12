#!/usr/bin/perl
package WWW::StatusBadge::Render::Plugin::POD;

use strict;
use warnings;

sub render {
    my $self   = shift;
    my $render = shift || 'html';

    return sprintf(
        '=for %s %s', $render, $self->$render,
    );
}

1;
# ABSTRACT: Plain Old Documentation Status Badge renderer
# vim:ts=4:sw=4:syn=perl
__END__
=pod

=head1 SYNOPSIS

    use WWW::StatusBadge::Service;

    my $service = WWW::StatusBadge::Service->new(
        'txt' => 'Build Status',
        'url' => 'https://travis-ci.org/ARivottiC/WWW-StatusBadge.pm',
        'img' => 'https://travis-ci.org/ARivottiC/WWW-StatusBadge.pm.svg',
    );

    my $badge = $service->pod('html');

=for Pod::Coverage render

=head1 ARGUMENTS

Expect a render. Default is html;

=head1 SEE ALSO

=for :list
* L<WWW::StatusBadge>
* L<WWW::StatusBadge::Service>

=cut
