#!/usr/bin/perl
package WWW::StatusBadge::Render::Plugin::HTML;

use strict;
use warnings;

sub render {
    my $self = shift;

    return sprintf(
        '<a href="%s"><img src="%s" alt="%s" /></a>',
        $self->url, $self->img, $self->txt,
    );
}

1;
# ABSTRACT: HTML Status Badge renderer
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

    my $badge = $service->html;

=for Pod::Coverage render

=head1 SEE ALSO

=for :list
* L<WWW::StatusBadge>
* L<WWW::StatusBadge::Service>

=cut
