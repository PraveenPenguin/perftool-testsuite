#!/usr/bin/perl

$quiet = 1;
$quiet = 0 if (defined $ENV{TESTLOG_VERBOSITY} && $ENV{TESTLOG_VERBOSITY} ge 2);

$passed = 1;

$koef = 0.003;

$k = -1;
$u = -1;
$ku = -1;

while (<STDIN>)
{
	s/\n//;

	$k = int($1) if (/(\d+);;?[\w\-]+:k;/);
	$u = int($1) if (/(\d+);;?[\w\-]+:u;/);
	$ku = int($1) if (/(\d+);;?[\w\-]+(?::ku)?;/);
}

$passed = 0 if (($k == -1) || ($u == -1) || ($ku == -1));

if ($ku != 0)
{
	$diff = ($k + $u - $ku) / $ku;
	$diff *= -1 if $diff < 0;
	if ($diff > $koef)
	{
		print "FAIL ($k + $u - $ku) / $ku = $diff ; it should be $diff < $koef\n" unless $quiet;
		$passed = 0;
	}
}
else
{
	if ($k + $u > 0)
	{
		print "FAIL ($k + $u) > 0 while $ku = 0\n" unless $quiet;
		$passed = 0;
	}
}

exit ($passed == 0);
