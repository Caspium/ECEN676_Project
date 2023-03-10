// © 2015 Synopsys, Inc.
// This Synopsys ZeBu Lab source code and all associated documentation are proprietary and
// confidential to Synopsys, Inc. and may only be used pursuant to the terms and conditions
// of a written license agreement with Synopsys, Inc. All other use, reproduction,
// modification, or distribution of the Synopsys ZeBu Lab source code or the associated
// documentation is strictly prohibited.

#ifndef _COLLECT_HH_

#define _COLLECT_HH_

#include <vector>
#include <string>

class Collect {
  private:
    int _min;
    std::string _name;

  public:
    Collect (std::string name);
    ~Collect();
    void setMin (int m);
    void WriteStats();
//    static void WriteStatsEnd();
};

class SCollect
{
  private:
    std::vector<Collect*> _fabric;

  public:
    void Add(Collect*);
    ~SCollect();
};

#endif
