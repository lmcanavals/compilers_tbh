#include "llvm/IR/Module.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Type.h"

#include <memory>
#include <vector>

using namespace llvm;

int main() {
	std::unique_ptr<LLVMContext> TheContext = std::make_unique<LLVMContext>();
	std::unique_ptr<Module> TheModule = std::make_unique<Module>("my cool jit", *TheContext);
	std::unique_ptr<IRBuilder<>> Builder = std::make_unique<IRBuilder<>>(*TheContext);

	//Function* TheFunction = TheModule->getFunction("test");
	std::vector<Type*> Doubles(0, Type::getDoubleTy(*TheContext));
	FunctionType* FT = FunctionType::get(Type::getDoubleTy(*TheContext), Doubles, false);
	Function* TheFunction = Function::Create(FT, Function::ExternalLinkage, "testfunc", TheModule.get());
	

	BasicBlock* BB = BasicBlock::Create(*TheContext, "entry", TheFunction);
	Builder->SetInsertPoint(BB);

	TheModule->print(errs(), nullptr);

	return 0;
}
