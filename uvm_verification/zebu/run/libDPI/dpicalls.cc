// © 2015 Synopsys, Inc.
// This Synopsys ZeBu Lab source code and all associated documentation are proprietary and
// confidential to Synopsys, Inc. and may only be used pursuant to the terms and conditions
// of a written license agreement with Synopsys, Inc. All other use, reproduction,
// modification, or distribution of the Synopsys ZeBu Lab source code or the associated
// documentation is strictly prohibited.

// Standard C libraries
#include <svdpi.h>
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <iomanip>
#include <string>
#include "Collect.hh"

extern "C" void fifo_usage_spy_notify (const svBitVecVal* _arg_min)
{
// to retrieve the scope, the function must be declared as 'context'
  svScope scope = svGetScope ();

  void *ctx = svGetUserData(scope, (void*)(fifo_usage_spy_notify));
  if (ctx == NULL)
  {
    // first call
    const char *i_name = svGetNameFromScope (scope);
    ctx = new Collect(i_name);
    svPutUserData(scope, (void*)fifo_usage_spy_notify, ctx);
  }

  ((Collect*)ctx)->setMin(_arg_min[0]);
}
