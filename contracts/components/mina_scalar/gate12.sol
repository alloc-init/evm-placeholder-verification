// SPDX-License-Identifier: Apache-2.0.
//---------------------------------------------------------------------------//
// Copyright (c) 2022 Mikhail Komarov <nemo@nil.foundation>
// Copyright (c) 2022 Ilias Khairullin <ilias@nil.foundation>
// Copyright (c) 2022 Aleksei Moskvin <alalmoskvin@nil.foundation>
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//---------------------------------------------------------------------------//
pragma solidity >=0.8.4;

import "../../types.sol";
import "../../logging.sol";

// TODO: name component
library mina_scalar_gate12 {
    uint256 constant MODULUS_OFFSET = 0x0;
    uint256 constant THETA_OFFSET = 0x20;
    uint256 constant CONSTRAINT_EVAL_OFFSET = 0x40;
    uint256 constant GATE_EVAL_OFFSET = 0x60;
    uint256 constant GATES_EVALUATIONS_OFFSET = 0x80;
    uint256 constant THETA_ACC_OFFSET = 0xa0;
    uint256 constant WITNESS_EVALUATIONS_OFFSET = 0xc0;
    uint256 constant CONSTANT_EVALUATIONS_OFFSET = 0xe0;
    uint256 constant SELECTOR_EVALUATIONS_OFFSET =0x100;

    // TODO: columns_rotations could be hard-coded
    function evaluate_gate_be(
        types.gate_argument_local_vars memory gate_params
    ) external pure returns (uint256 gates_evaluation, uint256 theta_acc) {
        gates_evaluation = gate_params.gates_evaluation;
        theta_acc = gate_params.theta_acc;
        uint256 terms;
        assembly {
            let modulus := mload(gate_params)
            mstore(add(gate_params, GATE_EVAL_OFFSET), 0)

            function get_eval_i_by_rotation_idx(idx, rot_idx, ptr) -> result {
                result := mload(
                    add(
                        add(mload(add(add(ptr, 0x20), mul(0x20, idx))), 0x20),
                        mul(0x20, rot_idx)
                    )
                )
            }

            function get_selector_i(idx, ptr) -> result {
                result := mload(add(add(ptr, 0x20), mul(0x20, idx)))
            }


            function get_constant_i(idx, ptr) -> result {
                result := mload(add(add(ptr, 0x20), mul(0x20, idx)))
            }
            
            mstore(add(gate_params, GATE_EVAL_OFFSET), 0)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET), 0)
            terms:=0x102cd45175bf54b670945d6f8cc447db1d687d1486d2daed5263ef58bc5fe1af
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x1d70822e80b8581cfb5ab2c8822851174db06f98c33edea8c227e30dc22a6b3
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(0,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(0,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(0,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(0,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(0,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(0,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(0,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0xf24f954496903346d4d753deb0b76c2e26e4dbebf04906842d108dc883cda01
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(1,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(1,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(1,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(1,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(1,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(1,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(1,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x28beef43e4fa739fe900a17ead54c004b4182caf07ae3e235c20915be480a9c7
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(2,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(2,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(2,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(2,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(2,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(2,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(2,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x1
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(3,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET), 0)
            terms:=0x3b17182cbec37373301eab23ae0ce3899fe41c8a0f495802e11ef87c2d9dc15b
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x2d2c9057cafceb967f3fa5e2b7432af2f3a9556b26410784eb48b2a2d4b514f5
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(0,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(0,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(0,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(0,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(0,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(0,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(0,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x154e83714c9641589160f3c7a17450390d0fda1f7b8dd86db5ead4b016b263ac
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(1,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(1,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(1,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(1,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(1,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(1,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(1,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x3f336eacd7e9a3ec67950ed81ef7461a48a08c9e40666a67558e2746a4b57aca
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(2,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(2,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(2,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(2,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(2,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(2,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(2,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x1
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(4,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET), 0)
            terms:=0x1f3e92ff6831414c7aaf749f9b784550e69947a060f3ef659aea361ec6be71c9
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x3b26592d8f96997714bcb9eac4c7f39ee808ce0b0e3a8a5a0c0650405ebc2ce6
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(0,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(0,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(0,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(0,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(0,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(0,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(0,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x3d57fa111cce837451e082ea541b2d8033e6ed2c6f61740c012db87dc88b3cdd
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(1,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(1,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(1,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(1,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(1,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(1,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(1,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x264f6d16392002e14e4920d243ff44dd9e8cf174e256dd2ff0b96153afd48444
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(2,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(2,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(2,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(2,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(2,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(2,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(2,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x1
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(5,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET), 0)
            terms:=0xb0e209fca5538adfbc97eda4f3b313f1a639f11098f57606570d9e2e0c99d90
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x1d70822e80b8581cfb5ab2c8822851174db06f98c33edea8c227e30dc22a6b3
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(3,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(3,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(3,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(3,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(3,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(3,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(3,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0xf24f954496903346d4d753deb0b76c2e26e4dbebf04906842d108dc883cda01
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(4,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(4,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(4,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(4,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(4,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(4,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(4,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x28beef43e4fa739fe900a17ead54c004b4182caf07ae3e235c20915be480a9c7
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(5,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(5,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(5,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(5,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(5,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(5,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(5,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x1
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(6,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET), 0)
            terms:=0x8a68c4a61284b424cc9bd2df19c9b0ca7b2696bf09dec37e085e41bb7ebda21
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x2d2c9057cafceb967f3fa5e2b7432af2f3a9556b26410784eb48b2a2d4b514f5
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(3,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(3,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(3,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(3,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(3,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(3,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(3,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x154e83714c9641589160f3c7a17450390d0fda1f7b8dd86db5ead4b016b263ac
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(4,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(4,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(4,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(4,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(4,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(4,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(4,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x3f336eacd7e9a3ec67950ed81ef7461a48a08c9e40666a67558e2746a4b57aca
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(5,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(5,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(5,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(5,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(5,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(5,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(5,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x1
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(7,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET), 0)
            terms:=0x1961736877fc1ae2bcbc6483e73bd9f1a0a88f1430cbd5568600af657ee39675
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x3b26592d8f96997714bcb9eac4c7f39ee808ce0b0e3a8a5a0c0650405ebc2ce6
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(3,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(3,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(3,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(3,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(3,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(3,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(3,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x3d57fa111cce837451e082ea541b2d8033e6ed2c6f61740c012db87dc88b3cdd
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(4,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(4,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(4,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(4,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(4,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(4,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(4,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x264f6d16392002e14e4920d243ff44dd9e8cf174e256dd2ff0b96153afd48444
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(5,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(5,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(5,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(5,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(5,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(5,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(5,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x1
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(8,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET), 0)
            terms:=0x1e41e6ec078b0c124775e09f32ea8034ab4778471e810e2f6beb90f99bf6787f
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x1d70822e80b8581cfb5ab2c8822851174db06f98c33edea8c227e30dc22a6b3
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(6,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(6,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(6,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(6,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(6,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(6,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(6,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0xf24f954496903346d4d753deb0b76c2e26e4dbebf04906842d108dc883cda01
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(7,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(7,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(7,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(7,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(7,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(7,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(7,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x28beef43e4fa739fe900a17ead54c004b4182caf07ae3e235c20915be480a9c7
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(8,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(8,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(8,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(8,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(8,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(8,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(8,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x1
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(9,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET), 0)
            terms:=0x85f57457c2477b08de3dafd82e773856a7f14f091344182586521e2bfdc6d82
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x2d2c9057cafceb967f3fa5e2b7432af2f3a9556b26410784eb48b2a2d4b514f5
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(6,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(6,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(6,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(6,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(6,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(6,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(6,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x154e83714c9641589160f3c7a17450390d0fda1f7b8dd86db5ead4b016b263ac
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(7,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(7,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(7,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(7,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(7,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(7,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(7,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x3f336eacd7e9a3ec67950ed81ef7461a48a08c9e40666a67558e2746a4b57aca
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(8,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(8,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(8,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(8,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(8,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(8,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(8,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x1
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(10,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET), 0)
            terms:=0x3a92f1980218864841a0cf75c31ee61de44195152ed6ed0873ab36d339590f5d
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x3b26592d8f96997714bcb9eac4c7f39ee808ce0b0e3a8a5a0c0650405ebc2ce6
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(6,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(6,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(6,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(6,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(6,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(6,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(6,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x3d57fa111cce837451e082ea541b2d8033e6ed2c6f61740c012db87dc88b3cdd
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(7,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(7,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(7,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(7,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(7,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(7,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(7,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x264f6d16392002e14e4920d243ff44dd9e8cf174e256dd2ff0b96153afd48444
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(8,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(8,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(8,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(8,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(8,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(8,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(8,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x1
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(11,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET), 0)
            terms:=0x2bb8dcbc95cd625a9bb33169011b6ad51be606389dc380a4d74716f8c3017d3d
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x1d70822e80b8581cfb5ab2c8822851174db06f98c33edea8c227e30dc22a6b3
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(9,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(9,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(9,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(9,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(9,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(9,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(9,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0xf24f954496903346d4d753deb0b76c2e26e4dbebf04906842d108dc883cda01
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(10,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(10,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(10,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(10,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(10,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(10,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(10,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x28beef43e4fa739fe900a17ead54c004b4182caf07ae3e235c20915be480a9c7
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(11,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(11,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(11,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(11,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(11,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(11,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(11,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x1
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(12,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET), 0)
            terms:=0x313f4a0eb45af55d4fdd2f90446df5d572923343419c891c730fd0d44495300a
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x2d2c9057cafceb967f3fa5e2b7432af2f3a9556b26410784eb48b2a2d4b514f5
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(9,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(9,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(9,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(9,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(9,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(9,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(9,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x154e83714c9641589160f3c7a17450390d0fda1f7b8dd86db5ead4b016b263ac
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(10,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(10,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(10,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(10,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(10,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(10,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(10,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x3f336eacd7e9a3ec67950ed81ef7461a48a08c9e40666a67558e2746a4b57aca
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(11,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(11,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(11,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(11,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(11,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(11,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(11,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x1
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(13,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET), 0)
            terms:=0x397a21e7265cb95ca3bb5d5b538d7c2924184e5e493beb8a15462efc6ad8e8e0
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x3b26592d8f96997714bcb9eac4c7f39ee808ce0b0e3a8a5a0c0650405ebc2ce6
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(9,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(9,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(9,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(9,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(9,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(9,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(9,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x3d57fa111cce837451e082ea541b2d8033e6ed2c6f61740c012db87dc88b3cdd
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(10,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(10,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(10,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(10,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(10,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(10,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(10,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x264f6d16392002e14e4920d243ff44dd9e8cf174e256dd2ff0b96153afd48444
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(11,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(11,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(11,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(11,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(11,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(11,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(11,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x1
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(14,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET), 0)
            terms:=0x2872348b4ab95215be502a26c10a9b34e76b8a06e992a702a23740d0d9447345
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x1d70822e80b8581cfb5ab2c8822851174db06f98c33edea8c227e30dc22a6b3
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(12,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(12,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(12,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(12,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(12,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(12,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(12,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0xf24f954496903346d4d753deb0b76c2e26e4dbebf04906842d108dc883cda01
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(13,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(13,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(13,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(13,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(13,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(13,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(13,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x28beef43e4fa739fe900a17ead54c004b4182caf07ae3e235c20915be480a9c7
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(14,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(14,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(14,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(14,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(14,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(14,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(14,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x1
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(0,1, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET), 0)
            terms:=0x23e234e10930a0fc951ffcf40870e9bc5e0d14c2afb733e3635cb4bd8ca336de
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x2d2c9057cafceb967f3fa5e2b7432af2f3a9556b26410784eb48b2a2d4b514f5
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(12,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(12,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(12,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(12,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(12,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(12,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(12,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x154e83714c9641589160f3c7a17450390d0fda1f7b8dd86db5ead4b016b263ac
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(13,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(13,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(13,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(13,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(13,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(13,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(13,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x3f336eacd7e9a3ec67950ed81ef7461a48a08c9e40666a67558e2746a4b57aca
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(14,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(14,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(14,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(14,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(14,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(14,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(14,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x1
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(1,2, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET), 0)
            terms:=0x33051936666b3a08fd345c4cd5b1c70cac04913c21c70ce814e3afdf7bc15ec9
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x3b26592d8f96997714bcb9eac4c7f39ee808ce0b0e3a8a5a0c0650405ebc2ce6
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(12,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(12,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(12,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(12,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(12,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(12,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(12,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x3d57fa111cce837451e082ea541b2d8033e6ed2c6f61740c012db87dc88b3cdd
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(13,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(13,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(13,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(13,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(13,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(13,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(13,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x264f6d16392002e14e4920d243ff44dd9e8cf174e256dd2ff0b96153afd48444
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(14,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(14,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(14,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(14,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(14,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(14,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(14,0, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            terms:=0x1
            terms:=mulmod(terms, get_eval_i_by_rotation_idx(2,1, mload(add(gate_params, WITNESS_EVALUATIONS_OFFSET))), modulus)
            mstore(add(gate_params, CONSTRAINT_EVAL_OFFSET),addmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),terms,modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(add(gate_params, CONSTRAINT_EVAL_OFFSET)),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(add(gate_params, GATE_EVAL_OFFSET),mulmod(mload(add(gate_params, GATE_EVAL_OFFSET)),get_selector_i(12,mload(add(gate_params, SELECTOR_EVALUATIONS_OFFSET))),modulus))
            gates_evaluation := addmod(gates_evaluation,mload(add(gate_params, GATE_EVAL_OFFSET)),modulus)
        }
    }
}
