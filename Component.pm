package Maypole::Plugin::Component;

use strict;
use URI;
use URI::QueryParam;
use NEXT;

our $VERSION = '0.05';

Maypole->mk_accessors('parent');

sub component {
    my ( $r, $path ) = @_;
    my $self = bless { parent => $r }, ref $r;
    my $url = URI->new($path);
    $self->{path} = $url->path;
    $self->parse_path;
    $self->params( $url->query_form_hash );
    $self->query( $r->params );
    $self->handler_guts;
    return $self->output;
}

sub get_template_root {
    my $self = shift;
    my $r    = shift;
    return $r->parent->get_template_root if $r->{parent};
    return $self->NEXT::DISTINCT::get_template_root( $r, @_ );
}

sub view_object {
    my $self = shift;
    my $r    = shift;
    return $r->parent->view_object if $r->{parent};
    return $self->NEXT::DISTINCT::view_object( $r, @_ );
}

1;
__END__

=head1 NAME

Maypole::Plugin::Component - Run Maypole sub-requests as components

=head1 SYNOPSIS

    package MyApp;
    use Maypole::Application qw(Component);

    [% request.component("/beer/view_as_component/20") %]

=head1 DESCRIPTION

This subclass of Maypole allows you to integrate the results of a Maypole
request into an existing request. You'll need to set up actions and templates
which return fragments of HTML rather than entire pages, but once you've
done that, you can use the C<component> method of the Maypole request object
to call those actions. You may pass a query string in the usual URL style.
You should not fully qualify the Maypole URLs.

Note that you need Maypole 2.0 or newer to use this module.

=head1 AUTHOR

Sebastian Riedel <sri@oook.de>

Original version by Simon Cozens

=head1 LICENSE

This library is free software. You can redistribute it and/or modify it under
the same terms as perl itself.
