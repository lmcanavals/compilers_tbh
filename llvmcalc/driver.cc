#include "driver.hh"
#include "parser.hh"

driver::driver() : trace_parsing(false), trace_scanning(false) {
	variables["one"] = 1;
	variables["two"] = 2;

	TheContext = std::make_unique<LLVMContext>();
	TheModule = std::make_unique<Module>("my cool jit calc", *TheContext);
	Builder = std::make_unique<IRBuilder<>>(*TheContext);

	FunctionType *FT = FunctionType::get(Type::getDoubleTy(*TheContext), false);
	Function *TheFunction = Function::Create(FT, Function::ExternalLinkage,
			"hidden_main", TheModule.get());

	BasicBlock *BB = BasicBlock::Create(*TheContext, "entry", TheFunction);
	Builder->SetInsertPoint(BB);
}

int driver::parse(const std::string &f) {
	file = f;
	location.initialize(&file);
	scan_begin();
	yy::parser parse(*this);
	parse.set_debug_level(trace_parsing);
	int res = parse();
	scan_end();
	TheModule->print(errs(), nullptr);
	return res;
}
