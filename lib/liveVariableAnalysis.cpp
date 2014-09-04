#include "passes.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Constants.h"
#include "llvm/ADT/DepthFirstIterator.h"
#include "llvm/IR/CFG.h"
#include <algorithm>
#include <cstring>
#include <string>
#include <vector>
#include <map>

namespace cs565 {
    bool LiveVariableAnalysis::runOnFunction(Function &F) {
        errs() << "FUNCTION ";
        errs().write_escaped(F.getName()) << "\n\n";
        unsigned instr_no = 1;
        std::map< const llvm::Instruction*, unsigned > insts;
        for (llvm::Function::iterator iter = F.begin(); iter != F.end(); iter++) {
            for (llvm::BasicBlock::iterator iter2 = iter->begin(); iter2 != iter->end(); iter2++) {
                insts[iter2] = instr_no;
                instr_no++;
            }
        }
        int j = 1;
        std::map<std::string, int> vars;
        for (llvm::Function::iterator iter = F.begin(); iter != F.end(); iter++) {
            for (llvm::BasicBlock::iterator iter2 = iter->begin(); iter2 != iter->end(); iter2++) {
                for (unsigned i = 0; i < iter2->getNumOperands(); i++) {
                    if (insts.find((dyn_cast<llvm::Instruction>)(iter2->getOperand(i))) != insts.end()) {
                        if (!iter2->getOperand(i)->getName().empty() && vars.find(iter2->getOperand(i)->getName()) == vars.end()) {
                            errs() << j << ": " << iter2->getOperand(i)->getName() << "\n";
                            vars[iter2->getOperand(i)->getName()] = j;
                            j++;
                        }
                    }
                }
            }
        }
        llvm::Function::ArgumentListType *args = &F.getArgumentList();
        for (llvm::Function::ArgumentListType::iterator iter = args->begin(); iter != args->end(); iter++) {
            errs() << j << ": " << iter->getName() << "\n";
            vars[iter->getName()] = j;
            j++;
        }
        errs() << '\n';

        std::string *tab = new std::string[vars.size() + 1];
        for (std::map<std::string, int>::iterator iter = vars.begin(); iter != vars.end(); iter++) {
            tab[iter->second] = iter->first;
        }

        std::map< const llvm::BasicBlock*, std::set<int>* > inB;
        std::map< const llvm::BasicBlock*, std::set<int>* > outB;
        std::map< const llvm::BasicBlock*, std::set<int>* > genB;
        std::map< const llvm::BasicBlock*, std::set<int>* > killB;
        for (llvm::Function::iterator iter = F.begin(); iter != F.end(); iter++) {
            inB[iter] = new std::set<int>();
            outB[iter] = new std::set<int>();
            genB[iter] = new std::set<int>();
            killB[iter] = new std::set<int>();
            std::set<int> outI;
            for (llvm::BasicBlock::reverse_iterator iter2 = iter->rbegin(); iter2 != iter->rend(); iter2++) {
                if (strncmp(iter2->getOpcodeName(), "store", 5) == 0) {
                    if (!iter2->getOperand(1)->getName().empty()) {
                        int var = vars[iter2->getOperand(1)->getName()];
                        outI.erase(var);
                        killB[iter]->insert(var);
                        genB[iter]->erase(var);
                    }
                } else if (strncmp(iter2->getOpcodeName(), "load", 4) == 0) {
                    if (!iter2->getOperand(0)->getName().empty()) {
                        int var = vars[iter2->getOperand(0)->getName()];
                        outI.insert(var);
                        genB[iter]->insert(var);
                    }
                }
            }
        }

        llvm::BasicBlock *entry = &F.getEntryBlock();
        for (llvm::Function::ArgumentListType::iterator iter = args->begin(); iter != args->end(); iter++) {
            outB[entry]->insert(vars[iter->getName()]);
        }

        bool change = true;
        while (change) {
            change = false;
            for (llvm::Function::iterator iter = F.begin(); iter != F.end(); iter++) {
                std::pair<std::set<int>::iterator, bool> ret;
                for (llvm::succ_iterator iter2 = llvm::succ_begin(iter); iter2 != llvm::succ_end(iter); iter2++) {
                    llvm::BasicBlock *succ = *iter2;
                    std::vector<int> temp(inB[succ]->size() + outB[iter]->size());
                    std::set_union(outB[iter]->begin(), outB[iter]->end(), inB[succ]->begin(), inB[succ]->end(), temp.begin());
                    for (std::vector<int>::iterator iter3 = temp.begin(); iter3 != temp.end(); iter3++) {
                        ret = outB[iter]->insert(*iter3);
                        if (ret.second == true) {
                            change = true;
                        }
                    }
                }
                std::vector<int> temp(outB[iter]->size());
                std::set_difference(outB[iter]->begin(), outB[iter]->end(), killB[iter]->begin(), killB[iter]->end(), temp.begin());
                std::vector<int> temp1(genB[iter]->size() + temp.size());
                std::set_union(genB[iter]->begin(), genB[iter]->end(), temp.begin(), temp.end(), temp1.begin());

                for (std::vector<int>::iterator iter2 = temp1.begin(); iter2 != temp1.end(); iter2++) {
                    ret = inB[iter]->insert(*iter2);
                    if (ret.second == true) {
                        change = true;
                    }
                }
            }
        }
        for (llvm::Function::iterator iter = F.begin(); iter != F.end(); iter++) {
            errs() << "BASIC BLOCK ";
            errs().write_escaped(iter->getName());

            // errs() << "\nIN: ";
            // for (std::set<int>::iterator iter2 = inB[iter]->begin(); iter2 != inB[iter]->end(); iter2++) {
            //     if (*iter2 != 0) {
            //         errs() << tab[*iter2] << " ";
            //     }
            // }
            errs() << "\nOUT: ";
            for (std::set<int>::iterator iter2 = outB[iter]->begin(); iter2 != outB[iter]->end(); iter2++) {
                if (*iter2 != 0) {
                    errs() << tab[*iter2] << " ";
                }
            }
            // errs() << "\nGEN: ";
            // for (std::set<int>::iterator iter2 = genB[iter]->begin(); iter2 != genB[iter]->end(); iter2++) {
            //     if (*iter2 != 0) {
            //         errs() << tab[*iter2] << " ";
            //     }
            // }
            // errs() << "\nKILL: ";
            // for (std::set<int>::iterator iter2 = killB[iter]->begin(); iter2 != killB[iter]->end(); iter2++) {
            //     if (*iter2 != 0) {
            //         errs() << tab[*iter2] << " ";
            //     }
            // }
            errs() << '\n';
        }
        errs() << '\n';
        return false;
    }

    void LiveVariableAnalysis::getAnalysisUsage(AnalysisUsage &Info) const {
        Info.setPreservesAll();
    }
}

char cs565::LiveVariableAnalysis::ID = 0;
static RegisterPass<cs565::LiveVariableAnalysis> X("liveVariableAnalysis", "(CS 565) - Live Variable Analysis", false, false);
