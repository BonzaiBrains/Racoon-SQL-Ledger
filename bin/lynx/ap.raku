#=====================================================================
# Racoon-SQL-Ledger
# Copyright (c) DWS Systems Inc.
#
#  Author: DWS Systems Inc.
#     Web: https://github.com/BonzaiBrains/Racoon-SQL-Ledger
#
#======================================================================
#
# Accounts Payable
#
#======================================================================

use SL::IR;

require "$form->{path}/arap.raku";
require "$form->{path}/arapprn.raku";
require "$form->{path}/aa.raku";

$form->{vc} = 'vendor';
$form->{ARAP} = 'AP';

1;
# end of main

