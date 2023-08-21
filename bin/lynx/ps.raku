#=====================================================================
# SQL-Ledger
# Copyright (c) DWS Systems Inc.
#
#  Author: DWS Systems Inc.
#     Web: http://www.sql-ledger.com
#
#=====================================================================
#
# point of sale script
#
#=====================================================================

use SL::AA;
use SL::IS;
use SL::RP;

require "$form->{path}/rp.raku";
require "$form->{path}/ar.raku";
require "$form->{path}/is.raku";
require "$form->{path}/pos.raku";

# customizations
if (-f "$form->{path}/custom/pos.raku") {
  eval { require "$form->{path}/custom/pos.raku"; };
}
if (-f "$form->{path}/custom/$form->{login}/pos.raku") {
  eval { require "$form->{path}/custom/$form->{login}/pos.raku"; };
}

1;
# end
