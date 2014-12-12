#!/usr/bin/perl
package WWW::StatusBadge::Service;

use strict;
use warnings;

use Carp ();
use Hash::Util::FieldHash ();
use Module::Pluggable::Object ();

Hash::Util::FieldHash::fieldhashes \my( %Img, %Txt, %Url, );

sub new {
    my $class = shift;
    my %arg   = @_;

    for my $key ( qw(img txt url) ) {
        Carp::croak( sprintf 'missing required parameter %s!', $key )
            unless $arg{ $key };
    }

    my $self = do {
        my $o; bless \( $o ), ref $class || $class || __PACKAGE__;
    };

    $Img{ $self } = $arg{'img'};
    $Txt{ $self } = $arg{'txt'};
    $Url{ $self } = $arg{'url'};

    return $self;
}

sub txt { return $Txt{ shift() }; }
sub img { return $Img{ shift() }; }
sub url { return $Url{ shift() }; }

my $package = __PACKAGE__;
my $finder  = Module::Pluggable::Object->new(
        'package' => 'WWW::StatusBadge::Render', 'require' => 1,
    );

{
    no strict 'refs';
    for my $plugin ( $finder->plugins ) {
        my $service = $plugin->can('render')
            || next;
        my $method = join( '_', ( split '::', lc $plugin )[4,] );
        *{ sprintf '%s::%s', $package, $method } = $service;
    }
}

1;
# ABSTRACT: Service agnostic Status Badge generator
# vim:ts=4:sw=4:syn=perl
__END__
=pod

=head1 SYNOPSIS

    use WWW::StatusBadge::Service;

    my $service = WWW::StatusBadge::Service->new(
        'txt' => 'Build Status',
        'url' => 'https://travis-ci.org/ARivottiC/Sidekick-Accessor.pm',
        'img' => 'https://travis-ci.org/ARivottiC/Sidekick-Accessor.pm.svg',
    );

    my $markdown = $service->markdown;

=head1 DESCRIPTION

Generates Status Badges in several formats.

=method new

    my $service = WWW::StatusBadge::Service->new(
        'txt' => 'Build Status',
        'url' => 'https://travis-ci.org/ARivottiC/Sidekick-Accessor.pm',
        'img' => 'https://travis-ci.org/ARivottiC/Sidekick-Accessor.pm.svg',
    );

=over 4

=item I<txt =E<gt> $text>

The status text. Required.

=item I<url =E<gt> $url>

The project/distribution URL. Required.

=item I<img =E<gt> $img_url>

The status image URL. Required.

=back

=attr txt

Returns the status text.

=attr url

Returns the URL.

=attr img

Returns the image URL.

=for Pod::Coverage asciidoc html markdown pod rdoc rst textile

=head1 PLUGINS

    package WWW::StatusBadge::Render::Plugin::Markdown;

    sub render {
        my $self = shift;

        return sprintf('[![%s](%s)](%s)', $self->txt, $self->url, $self->img,)
    }

    1;

=head1 SEE ALSO

=for :list
* L<WWW::StatusBadge>
* L<WWW::StatusBadge::Service::TravisCI>
* L<WWW::StatusBadge::Service::Coveralls>
* L<WWW::StatusBadge::Service::BadgeFury>
* L<WWW::StatusBadge::Render::Plugin::AsciiDoc>
* L<WWW::StatusBadge::Render::Plugin::HTML>
* L<WWW::StatusBadge::Render::Plugin::Markdown>
* L<WWW::StatusBadge::Render::Plugin::Pod>
* L<WWW::StatusBadge::Render::Plugin::RDoc>
* L<WWW::StatusBadge::Render::Plugin::RST>
* L<WWW::StatusBadge::Render::Plugin::Textile>

=cut
