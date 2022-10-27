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

// TODO: name component
library mina_base_gate6 {
    uint256 constant MODULUS_OFFSET = 0x0;
    uint256 constant THETA_OFFSET = 0x20;
    uint256 constant CONSTRAINT_EVAL_OFFSET = 0x40;
    uint256 constant GATE_EVAL_OFFSET = 0x60;
    uint256 constant WITNESS_EVALUATIONS_OFFSET_OFFSET = 0x80;
    uint256 constant SELECTOR_EVALUATIONS_OFFSET = 0xa0;
    uint256 constant EVAL_PROOF_WITNESS_OFFSET_OFFSET = 0xc0;
    uint256 constant EVAL_PROOF_SELECTOR_OFFSET_OFFSET = 0xe0;
    uint256 constant GATES_EVALUATION_OFFSET = 0x100;
    uint256 constant THETA_ACC_OFFSET = 0x120;
    uint256 constant SELECTOR_EVALUATIONS_OFFSET_OFFSET = 0x140;
    uint256 constant OFFSET_OFFSET = 0x160;
    uint256 constant WITNESS_EVALUATIONS_OFFSET = 0x180;
    uint256 constant CONSTANT_EVALUATIONS_OFFSET = 0x1a0;
    uint256 constant PUBLIC_INPUT_EVALUATIONS_OFFSET = 0x1c0;

    // TODO: columns_rotations could be hard-coded
    function evaluate_gate_be(
        types.gate_argument_local_vars memory gate_params,
        int256[][] memory columns_rotations
    ) external pure returns (uint256 gates_evaluation, uint256 theta_acc) {
        gates_evaluation = gate_params.gates_evaluation;
        theta_acc = gate_params.theta_acc;
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
            let x1 := add(gate_params, CONSTRAINT_EVAL_OFFSET)
            let x2 := add(gate_params, WITNESS_EVALUATIONS_OFFSET)
            // TODO: insert generated code for gate argument evaluation here
            mstore(add(gate_params, GATE_EVAL_OFFSET), 0)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x22103342cc8bf7fc52d7b43b7546a60cd88d4ae331d9325ad3a2e5596f33cff2,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x25642daf8a81d610b6a646410a64b19f403c42cb8be86733e1431140986386fe,mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),get_eval_i_by_rotation_idx(0,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x7b55f6050c5b78c81d29b095fcf55dbf3d93bb6ae6857e50278a679df3af934,mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),get_eval_i_by_rotation_idx(1,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x2d484fdf643cf7ff9b2a31b585fc9ac2a1233f549a628a5931b192e6193012c,mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),get_eval_i_by_rotation_idx(2,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(3,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x12d9c33d1650ed92897261e2d40d340d01e2da78ec9ba48b9bbbc529118fcb03,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x3611a838f43caeddf4ef867c503054417aae305760a767dd747585f94b40c5bf,mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),get_eval_i_by_rotation_idx(0,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x1f67666943d65692e897b2c52b37a67ef131727cd42a9b9d7a92d598c95dba72,mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),get_eval_i_by_rotation_idx(1,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x2b1c6524d1e8e51dcdee9be61180d9270927bb1363e9d68364b055783c4d1964,mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),get_eval_i_by_rotation_idx(2,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(4,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x2ee1ceb24904e5d71dbefd731c2cb83afcedf5c09e3bd0c1012d36d1b8616964,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x28babbca8497809a56a6f3e209de7e74cdf3c327c7f37e8763ae1fc9e9109836,mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),get_eval_i_by_rotation_idx(0,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x356d9c23e5e62e83040ea4fe9944da08c669ca8e81f47139c3efafcd3d3beca,mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),get_eval_i_by_rotation_idx(1,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x30e04108a2b549c4857ed07f484fc8c6f6a77299f927ccf4bc7af17f551eeb5,mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),get_eval_i_by_rotation_idx(2,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(5,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x3d8bf6bfe16dffe2bcb345d797161c8eb214ff39d21fd52c668edd71aec0bac3,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x25642daf8a81d610b6a646410a64b19f403c42cb8be86733e1431140986386fe,mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),get_eval_i_by_rotation_idx(3,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x7b55f6050c5b78c81d29b095fcf55dbf3d93bb6ae6857e50278a679df3af934,mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),get_eval_i_by_rotation_idx(4,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x2d484fdf643cf7ff9b2a31b585fc9ac2a1233f549a628a5931b192e6193012c,mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),get_eval_i_by_rotation_idx(5,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(6,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x1b57ad420634d570122a17a5a67982b70b8df3802bed743a94afefe58f000061,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x3611a838f43caeddf4ef867c503054417aae305760a767dd747585f94b40c5bf,mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),get_eval_i_by_rotation_idx(3,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x1f67666943d65692e897b2c52b37a67ef131727cd42a9b9d7a92d598c95dba72,mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),get_eval_i_by_rotation_idx(4,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x2b1c6524d1e8e51dcdee9be61180d9270927bb1363e9d68364b055783c4d1964,mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),get_eval_i_by_rotation_idx(5,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(7,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x1fa2e4f11ca609de7ba539b0081c7c5c36c4b8bedf2392c621e65ed1b8cd6293,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x28babbca8497809a56a6f3e209de7e74cdf3c327c7f37e8763ae1fc9e9109836,mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),get_eval_i_by_rotation_idx(3,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x356d9c23e5e62e83040ea4fe9944da08c669ca8e81f47139c3efafcd3d3beca,mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),get_eval_i_by_rotation_idx(4,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x30e04108a2b549c4857ed07f484fc8c6f6a77299f927ccf4bc7af17f551eeb5,mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),get_eval_i_by_rotation_idx(5,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(8,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x1a3cd81d336c1390f0dc4a1be36ce40463fa86218bf75669d010b71167d206fe,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x25642daf8a81d610b6a646410a64b19f403c42cb8be86733e1431140986386fe,mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),get_eval_i_by_rotation_idx(6,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x7b55f6050c5b78c81d29b095fcf55dbf3d93bb6ae6857e50278a679df3af934,mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),get_eval_i_by_rotation_idx(7,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x2d484fdf643cf7ff9b2a31b585fc9ac2a1233f549a628a5931b192e6193012c,mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),get_eval_i_by_rotation_idx(8,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(9,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x620c1dd2dd4f64bd9a25af10e8a6f633aa809f073b3192b7c35227c77b67d48,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x3611a838f43caeddf4ef867c503054417aae305760a767dd747585f94b40c5bf,mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),get_eval_i_by_rotation_idx(6,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x1f67666943d65692e897b2c52b37a67ef131727cd42a9b9d7a92d598c95dba72,mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),get_eval_i_by_rotation_idx(7,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x2b1c6524d1e8e51dcdee9be61180d9270927bb1363e9d68364b055783c4d1964,mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),get_eval_i_by_rotation_idx(8,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(10,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x364f72a77ac27536f73a4eb1a1479ee4dc52895163b0403b9f9d7dde03205600,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x28babbca8497809a56a6f3e209de7e74cdf3c327c7f37e8763ae1fc9e9109836,mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),get_eval_i_by_rotation_idx(6,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x356d9c23e5e62e83040ea4fe9944da08c669ca8e81f47139c3efafcd3d3beca,mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),get_eval_i_by_rotation_idx(7,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x30e04108a2b549c4857ed07f484fc8c6f6a77299f927ccf4bc7af17f551eeb5,mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),get_eval_i_by_rotation_idx(8,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(11,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x21319dc8b28618e824b59706322550ad29be49c295d73827d36b554263a85f5b,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x25642daf8a81d610b6a646410a64b19f403c42cb8be86733e1431140986386fe,mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),get_eval_i_by_rotation_idx(9,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x7b55f6050c5b78c81d29b095fcf55dbf3d93bb6ae6857e50278a679df3af934,mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),get_eval_i_by_rotation_idx(10,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x2d484fdf643cf7ff9b2a31b585fc9ac2a1233f549a628a5931b192e6193012c,mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),get_eval_i_by_rotation_idx(11,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(12,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x42f7648d85f11f71d9c05a1ca49e7249a6edc2e0608e4a5b52fe78964605e40,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x3611a838f43caeddf4ef867c503054417aae305760a767dd747585f94b40c5bf,mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),get_eval_i_by_rotation_idx(9,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x1f67666943d65692e897b2c52b37a67ef131727cd42a9b9d7a92d598c95dba72,mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),get_eval_i_by_rotation_idx(10,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x2b1c6524d1e8e51dcdee9be61180d9270927bb1363e9d68364b055783c4d1964,mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),get_eval_i_by_rotation_idx(11,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(13,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x12158a0c85263036b36aebe404b8e633ab66439493bb4bd8611df7e584d502,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x28babbca8497809a56a6f3e209de7e74cdf3c327c7f37e8763ae1fc9e9109836,mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),get_eval_i_by_rotation_idx(9,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x356d9c23e5e62e83040ea4fe9944da08c669ca8e81f47139c3efafcd3d3beca,mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),get_eval_i_by_rotation_idx(10,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x30e04108a2b549c4857ed07f484fc8c6f6a77299f927ccf4bc7af17f551eeb5,mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),get_eval_i_by_rotation_idx(11,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(14,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x9205e75645e4e6bdd7b6b575350f9975702ec52346c56c9e71e6daab2f19a34,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x25642daf8a81d610b6a646410a64b19f403c42cb8be86733e1431140986386fe,mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),get_eval_i_by_rotation_idx(12,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x7b55f6050c5b78c81d29b095fcf55dbf3d93bb6ae6857e50278a679df3af934,mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),get_eval_i_by_rotation_idx(13,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x2d484fdf643cf7ff9b2a31b585fc9ac2a1233f549a628a5931b192e6193012c,mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),get_eval_i_by_rotation_idx(14,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(0,1, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x2e616724c0b6328034c4f9cda98263357cfd0deec832e4e3a3b0cb5dbe6ce2f5,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x3611a838f43caeddf4ef867c503054417aae305760a767dd747585f94b40c5bf,mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),get_eval_i_by_rotation_idx(12,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x1f67666943d65692e897b2c52b37a67ef131727cd42a9b9d7a92d598c95dba72,mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),get_eval_i_by_rotation_idx(13,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x2b1c6524d1e8e51dcdee9be61180d9270927bb1363e9d68364b055783c4d1964,mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),get_eval_i_by_rotation_idx(14,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(1,1, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x2eff4de3cf9b8a27e94c10328a3c51ecc5f1ebbf43e056f0db91b1a7192fd3e8,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x28babbca8497809a56a6f3e209de7e74cdf3c327c7f37e8763ae1fc9e9109836,mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),get_eval_i_by_rotation_idx(12,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x356d9c23e5e62e83040ea4fe9944da08c669ca8e81f47139c3efafcd3d3beca,mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),get_eval_i_by_rotation_idx(13,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x30e04108a2b549c4857ed07f484fc8c6f6a77299f927ccf4bc7af17f551eeb5,mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),get_eval_i_by_rotation_idx(14,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(2,1, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(add(gate_params, GATE_EVAL_OFFSET),mulmod(mload(add(gate_params, GATE_EVAL_OFFSET)),get_selector_i(6,mload(add(gate_params, SELECTOR_EVALUATIONS_OFFSET))),modulus))
            gates_evaluation := addmod(gates_evaluation,mload(add(gate_params, GATE_EVAL_OFFSET)),modulus)
        }
    }
}
