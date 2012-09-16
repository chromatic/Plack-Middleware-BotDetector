package Plack::Middleware::BotDetector;
# ABSTRACT: Plack middleware to identify bots and spiders

use Modern::Perl;

use parent 'Plack::Middleware';
use Plack::Util::Accessor 'bot_regex';

sub call
{
    my ($self, $env) = @_;
    my $user_agent   = $env->{HTTP_USER_AGENT};
    my $bot_regex    = $self->bot_regex;

    if ($user_agent)
    {
        $env->{'BotDetector.looks-like-bot'}++ if $user_agent =~ qr/$bot_regex/;
    }

    return $self->app->( $env );
}

1;
