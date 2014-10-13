#!/usr/bin/perl -U

use 5.010;
use IO::File;
use warnings;
use strict 'vars';
use Data::Dumper;
use Net::OpenSSH;
use Term::ANSIColor;    

BEGIN:

my $Pass;
my $File  ="Malware_retro_analysis.pl";
my $Path="/scripts/Metascan/";

print "\nUpdating $Path with $File file ...";
my $PasswdFile = IO::File->new("passwd.txt",'r') || die $!;

while (my $Reading = $PasswdFile->getline()) {
	chomp($Reading);
	$Pass=$Reading;
}
		
		    
my $ssh = Net::OpenSSH->new(
	'10.0.0.25',
	 user => 'root',
	 password => $Pass,
	 strict_mode => 0, 
	 ctl_dir => "/tmp/.libnet-openssh-perl",
	 );
	 
$ssh->scp_put({glob => 1},$File,$Path )
	or die colored "scp failed: " . $ssh->error,'bold red';
print colored("[OK]\n",'bold green');
say "\n[+] Repository is now up to date !\n";

__END__
