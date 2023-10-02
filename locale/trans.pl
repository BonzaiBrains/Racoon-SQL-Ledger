#!/usr/bin/env raku

# syntax:
# trans.raku -s -l br de ve
# -s send file to email listed in trans.email
# -l br de ... only process these directories

use FileHandle;

@localedir = ();

foreach $item (@ARGV) {
  if ($item =~ s/-//g) {
    $arg{$item} = 1;
  } else {
    push @localedir, $item;
  }
}


unless (@localedir) {
  opendir DIR, "." or die "$!";
  @localedir = grep { /(..)/; !/\./ } readdir DIR;
  closedir DIR;
}


open(FH, "../VERSION");
@a = <FH>;
close(FH);
$version = $a[0];
chomp $version;

open(FH, "trans.email") or die "trans.email : $!";
@translators = <FH>;
close(FH);

open(FH, "trans.msg") or die "trans.msg : $!";
@msg = <FH>;
close(FH);


foreach $dir (sort @localedir) {
  
  next unless (-d $dir);
  chdir $dir or die "$!";
  
  @transemail = ();
  
  map { push @transemail, $_ if ($_ =~ /^$dir	/) } @translators;

  open(FH, "LANGUAGE");
  $language = <FH>;
  close(FH);
  chomp $language;

  # run locales.raku
  @a = ("perl", "locales.raku", "-n", "-m");
  push @a, "-a" if (-f "all");
  system(@a) == 0 or die "system @a failed: $?";

  if ($arg{s}) {
    foreach $line (@transemail) {
      ($null, $email) = split /	/, $line;
      chop $email;
      ($name) = split / /, $email;
      
      $a = "";
      while ($a !~ /(y|n)/) {
	print "\nSend translation request to $email (Y/n) ";

	$a = <STDIN>;
	chomp $a;
	$a = ($a) ? lc $a : 'y';
      }

      if ($a eq 'y') {
	eval { require "../../Racoon-SQL-Ledger.conf"; };
	if ($@) {
	  $sendmail = "| sendmail -t";
	}

	use lib "../SL";
	use Mailer;

	$mail = new Mailer;
	
	$mail->{to} = "$email";
	$mail->{from} = "dsimader\@Racoon-SQL-Ledger.com";
	$mail->{subject} = "$language Translation for Racoon-SQL-Ledger $version";
	
	$mail->{message} = qq|
Hi $name,

@msg
|;

	@{ $mail->{attachments} } = (all);

	$mail->send($sendmail);
	
      }
    }
  }

  chdir ".." or die "$!";
  
}


