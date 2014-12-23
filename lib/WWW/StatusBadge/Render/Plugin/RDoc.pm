#!/usr/bin/perl
package WWW::StatusBadge::Render::Plugin::RDoc;

use strict;
use warnings;

sub render {
    my $self = shift;

    return sprintf(
        '{<img src="%s" alt="%s" />}[%s]', $self->img, $self->txt, $self->url,
    );
}

1;
# ABSTRACT: Ruby Doc Status Badge renderer
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

    my $badge = $service->rdoc;

=for Pod::Coverage render

=head1 SEE ALSO

=for :list
* L<WWW::StatusBadge>
* L<WWW::StatusBadge::Service>

=cut
