#=====================================================================
# Racoon-SQL-Ledger
# Copyright (c) DWS Systems Inc.
#
#  Author: DWS Systems Inc.
#     Web: https://github.com/BonzaiBrains/Racoon-SQL-Ledger
#
#======================================================================
#
# Accounts Receivable
#
#======================================================================

use SL::PE;
use SL::IS;

require "$form->{path}/arap.raku";
require "$form->{path}/arapprn.raku";
require "$form->{path}/aa.raku";

$form->{vc} = 'customer';
$form->{ARAP} = 'AR';

1;
# end of main

