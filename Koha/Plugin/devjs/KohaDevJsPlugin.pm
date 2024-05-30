package Koha::Plugin::devjs::KohaDevJsPlugin;
use Modern::Perl;

use base qw(Koha::Plugins::Base);
use File::Slurp qw(read_file);
use Cwd qw(abs_path);

our $VERSION = "0.0.5";

our $metadata = {
    name            => 'Magnus Demo js med filer',
    author          => 'Magnus Pettersson',
    date_authored   => '2024-05-19',
    date_updated    => "2025-05-19",
    minimum_version => '21.11.00.000',
    maximum_version => undef,
    version         => $VERSION,
    description     => 'Det här pluginet lägger till css, och js filer till Koha',
};

sub new {
    my ( $class, $args ) = @_;

    $args->{'metadata'} = $metadata;
    $args->{'metadata'}->{'class'} = $class;
    my $self = $class->SUPER::new($args);

    return $self;
}

sub opac_head {
    my ( $self ) = @_;
    return "<style>".read_file( abs_path( $self->mbf_path('opac.css') ) )."</style>";
}

sub intranet_head {
    return "
        <style>
          body {
            background-color: orange;
          }
        </style>
    ";
}

sub opac_js {
    my ( $self ) = @_;
    return "<script>".read_file( abs_path( $self->mbf_path('opac.js') ) )."</script>";
}

sub intranet_js {
    return "<script>console.log('Hello World from JS, intranet');</script>";
}

1;