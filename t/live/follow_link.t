use warnings;
use strict;
use Test::More tests=>6;
use constant START => 'http://www.google.com/intl/en/';

use_ok( 'WWW::Mechanize' );

my $agent = WWW::Mechanize->new;
isa_ok( $agent, 'WWW::Mechanize' );

my $response = $agent->get( START );
ok( $response->is_success, 'Got some page' ) or die "Can't even get Google";
is( $agent->uri, START, 'Got Google' );

$response = $agent->follow_link( text_regex => qr/tools/i, n=>2 );
ok( $response->is_success, 'Got the page' );
is( $agent->uri, 'http://www.google.com/options/', "Got the correct page" );
