#include "passes.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Instructions.h"
#include <map>

namespace cs565 {
	bool PrettyPrint::runOnFunction(Function &F) {
		unsigned instr_no = 1;
		std::map< const llvm::Instruction*, unsigned > insts;
		for (llvm::Function::iterator iter = F.begin(); iter != F.end(); iter++) {
			for (llvm::BasicBlock::iterator iter2 = iter->begin(); iter2 != iter->end(); iter2++) {
				insts[iter2] = instr_no;
				instr_no++;
			}
		}
		errs() << "FUNCTION ";
		errs().write_escaped(F.getName()) << "\n\n";
		for (llvm::Function::iterator iter = F.begin(); iter != F.end(); iter++) {
			errs() << "BASIC BLOCK ";
			errs().write_escaped(iter->getName()) << "\n";
			for (llvm::BasicBlock::iterator iter2 = iter->begin(); iter2 != iter->end(); iter2++) {
				errs() << "%" << insts[iter2] << ":\t";
				errs().write_escaped(iter2->getOpcodeName()) << "\t";
				for (unsigned i = 0; i < iter2->getNumOperands(); i++) {
					if (insts.find((dyn_cast<llvm::Instruction>)(iter2->getOperand(i))) != insts.end()) {
						errs() << "%" << insts[(dyn_cast<llvm::Instruction>)(iter2->getOperand(i))] << "\t";
					} else {
						if (!iter2->getOperand(i)->getName().empty()) {
							errs() << iter2->getOperand(i)->getName() << "\t";
						} else {
							if (!(dyn_cast<ConstantInt>)(iter2->getOperand(i))) {
								errs() << "XXX\t";
							} else {
								errs() << ((dyn_cast<ConstantInt>)(iter2->getOperand(i)))->getValue() << "\t";
							}
						}
					}

					// errs() << iter2->getOperand(i)->getValueID() << "\t";
				}
				errs() << "\n";
			}
			errs() << "\n";
		}
		return false;
	}

	void PrettyPrint::getAnalysisUsage(AnalysisUsage &Info) const {
		Info.setPreservesAll();
	}
}

char cs565::PrettyPrint::ID = 0;
static RegisterPass<cs565 :: PrettyPrint> X("prettyPrint", "(CS 565) - Print Function LLVM IR", false, false);
