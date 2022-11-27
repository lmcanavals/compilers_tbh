#ifndef __DRIVER_H__
#define __DRIVER_H__

#include "llvm/ADT/APInt.h"
#include "llvm/ADT/STLExtras.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/Verifier.h"

#include "parser.hh"

#include <map>
#include <memory>
#include <string>

#define YY_DECL yy::parser::symbol_type yylex(driver &drv)

using namespace llvm;

class driver {
public:
	std::map<std::string, int> variables;
	int result;
	std::string file;
	bool trace_parsing;
	bool trace_scanning;
	yy::location location;

	std::unique_ptr<LLVMContext> TheContext;
	std::unique_ptr<Module> TheModule;
	std::unique_ptr<IRBuilder<>> Builder;

public:
  driver();
	int parse(const std::string& f);
	void scan_begin();
	void scan_end();
};

YY_DECL;

#endif
