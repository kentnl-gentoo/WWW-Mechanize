use warnings;
use strict;
use Test::More tests=>12;

use_ok( 'WWW::Mechanize' );

my $agent = WWW::Mechanize->new;
isa_ok( $agent, 'WWW::Mechanize', 'Created object' );

FIRST_GET: {
    my $r = $agent->get("http://www.google.com/intl/en/");
    isa_ok( $r, "HTTP::Response" );
    ok( $r->is_success, "Get google webpage");
    is( ref $agent->uri, "", "URI should be string, not an object" );
    ok( $agent->is_html );
    is( $agent->title, "Google" );
}

INVALIDATE: {
    undef $agent->{content};
    undef $agent->{ct};
    isnt( $agent->title, "Google" );
    ok( !$agent->is_html );
}

RELOAD: {
    my $r = $agent->reload;
    isa_ok( $r, "HTTP::Response" );
    ok( $agent->is_html );
    ok( $agent->title, "Google" );
}
