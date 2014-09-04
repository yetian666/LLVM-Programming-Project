#include "passes.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Constants.h"
#include "llvm/ADT/DepthFirstIterator.h"
#include "llvm/IR/CFG.h"
#include <map>

namespace cs565 {
	bool CFGNaive::runOnFunction(Function &F) {
		std::map< BasicBlock*, bool > bbs;
		for (llvm::Function::iterator iter = F.begin(); iter != F.end(); iter++) {
			bbs[iter] = false;
		}

		for (df_iterator<BasicBlock *> iter = df_begin(&F.getEntryBlock()); iter != df_end(&F.getEntryBlock()); iter++) {
			bbs[*iter] = true;
		}

		for (llvm::Function::iterator iter = F.begin(); iter != F.end(); iter++) {
			if (!bbs[iter]) {
				errs() << iter->getName() << " is unreachable\n";
				for (llvm::BasicBlock::iterator iter2 = iter->begin(); iter2 != iter->end(); iter2++) {
					iter2->dropAllReferences();
				}
			}
		}
		for (std::map< BasicBlock*, bool>::iterator iter = bbs.begin(); iter != bbs.end(); iter++) {
			if (!iter->second) {
				iter->first->removeFromParent();
			}
		}
/*
		for (llvm::Function::iterator iter = F.begin(); iter != F.end(); iter++) {
			if (bbs.find(iter) == bbs.end()) {
				llvm::BasicBlock* bb = iter;
				bbs.erase(iter);
				bb->eraseFromParent();
			}
		}
*/
		return true;
	}

	void CFGNaive::getAnalysisUsage(AnalysisUsage &Info) const {
		Info.setPreservesAll();
	}
}

char cs565::CFGNaive::ID = 0;
static RegisterPass<cs565::CFGNaive> X("cfgNaive", "(CS 565) - Naive Unreachable Basic Blocks Removal", false, false);
