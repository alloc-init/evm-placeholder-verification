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
library mina_scalar_gate15 {
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
            terms:=0x39f3a9577b3295e2caeb0d76a7e947b1b0e5b9ab02abd8ac1b3f8162e53a3fb5
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
            terms:=0x1c1ea0c83ded993791526675b91bd0918a4ac32a460fb3c000f21acf57f28ac4
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
            terms:=0x1a14d6eefcb549410b56969ac0a33cc1b931e045c875a28ecc2b1c0b8015b1ac
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
            terms:=0x216a3fb3afa8542e4bc5d0436bd4dc6e5165be0c825c702a42f87dc14f985eea
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
            terms:=0x2ab89fd037caa755ecd8dde02ddf05dd6594a20fc6a6f1118656f61839a77c36
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
            terms:=0x294996153ce18d5618c604fc02815c77f2811fe0f423654af165bb5e010174c4
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
            terms:=0x38fcb0b1dae59a3bbdcb862362ad785ce085901b54267f39fa4d4aa6f357dd10
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
            terms:=0x2062a8ce45fbf23a9719e47a8e156a3773b05cfefc522abb1c6c991bc0a97e
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
            terms:=0xc0d320969fec65f04b5c57ed866d1d5667270b4971083bb0210fcae42a4fe3a
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
            terms:=0x3ca9e92aafcc2703f6dc67093a7403917753ac5e349496b87552614539ceba86
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
            terms:=0x21357fe769bc20eb8c167256c01a756aab67a82a76c0939ddd8a196eef3e9fc2
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
            terms:=0x19ddc35b50d27278735aacf3c19800e38c918d5fae1212fbfaf62eef106f4569
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
            terms:=0x26e7f05a05349b1164b7d83328999dd543339a7b5e7ce1a43bd1b492ef5d5ca0
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
            terms:=0x3e960e9a7aa1f68afe0da294c5517ea33b5df739800f9fa6b2f085a1f1266bbb
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
            terms:=0x9c57076e21a68b0f9451fbc4395d94bd0b97781133b9a4a7363c525dea32601
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
            mstore(add(gate_params, GATE_EVAL_OFFSET),mulmod(mload(add(gate_params, GATE_EVAL_OFFSET)),get_selector_i(15,mload(add(gate_params, SELECTOR_EVALUATIONS_OFFSET))),modulus))
            gates_evaluation := addmod(gates_evaluation,mload(add(gate_params, GATE_EVAL_OFFSET)),modulus)
        }
    }
}
