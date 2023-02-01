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
library mina_scalar_gate11 {
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
            terms:=0x35c82871c6d5a37bbe06716242ae56eb03cd9d74910ebc25069667d4af3015b4
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
            terms:=0x214481da6dedd32e92d81ecbef4d4b72d0390a6236088b56dd3c29eb9a201479
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
            terms:=0x1b59bab4f5963a66e929b0acd4a9dd9094fd0267d6dcd7edc5d0f5873c4249b2
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
            terms:=0x1969974c187ca20d07a47d161079b83bf040b162f637c27466daf5c1f8bb7df8
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
            terms:=0x2a378c8a2baeb442224027b1ae0db9bbb32b8240b0d75d039216f5a295599faa
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
            terms:=0x2e319d441edbdccb3d9f5987e8416f758e23bf4242a6121d84d3ee5803afe24b
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
            terms:=0x1fcb748294c7e402c536dc29f469af794fc4c055b4e749ab7b7473a869be0169
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
            terms:=0x2c672f6f02eebb2e17b8671c5f1056bd764833f2c1b0050de83cec0c4abe0518
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
            terms:=0x1b9e5e5d291c5f4d1ae7a51937bb01d5e719131c57c51fbe8fcd3ca022889414
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
            terms:=0x1e0e216b3b50ff7e7745a1510e256548ab3caa71bef3d27e72d44c427f777a6
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
            terms:=0x22119152f8043f0177c0b2c6866b28a47e819ff4e8ad5dfab233e4b53c5823c6
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
            terms:=0x1782f9c694349caaa34d00bf715f8a30e21b8858438ca4a07f5407b8a1391d54
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
            terms:=0x927b36ac2a7b9f8b87259e7c23b258e6487257ec3995107e70b3d5fdc51f8e5
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
            terms:=0x1b3702ec2d9785606f39e25d97dc2b6cd7118c01c10756590a0d4d10958f538d
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
            terms:=0x3ad1fad595b6cba836b89333b0266db1c5d451427b3c050de5be2a28ceb41599
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
            mstore(add(gate_params, GATE_EVAL_OFFSET),mulmod(mload(add(gate_params, GATE_EVAL_OFFSET)),get_selector_i(11,mload(add(gate_params, SELECTOR_EVALUATIONS_OFFSET))),modulus))
            gates_evaluation := addmod(gates_evaluation,mload(add(gate_params, GATE_EVAL_OFFSET)),modulus)
        }
    }
}
