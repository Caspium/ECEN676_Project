// © 2015-2017 Synopsys, Inc.
// This Synopsys ZeBu Lab source code and all associated documentation are proprietary and
// confidential to Synopsys, Inc. and may only be used pursuant to the terms and conditions
// of a written license agreement with Synopsys, Inc. All other use, reproduction,
// modification, or distribution of the Synopsys ZeBu Lab source code or the associated
// documentation is strictly prohibited.

#include <iostream>
#include <vector>
#include "Collect.hh"

static SCollect scollect;

Collect::Collect (std::string name)
{
  _min = -1;
  _name = name;
  scollect.Add(this);
}

Collect::~Collect()
{
}

void Collect::setMin (int min)
{
  if (_min < 0)
    _min = min;
  else if (_min > min)
    _min = min;
}

void Collect::WriteStats()
{
  std::cout << "##### Collect : " << "  " << _name << " : " << std::dec << _min << std::endl;
}

void SCollect::Add(Collect* c)
{
  _fabric.push_back(c);
}

SCollect::~SCollect() {
  std::cout << "##### Collect : " << "###############################" << std::endl;
  std::cout << "##### Collect : " << "  Statistics Summary" << std::endl;
  std::cout << std::endl;

  std::vector<Collect*>::iterator it;
  for (it = _fabric.begin(); it != _fabric.end(); it++)
  {
    (*it)->WriteStats();
  }
  std::cout << "##### Collect : " << "###############################" << std::endl;
}
