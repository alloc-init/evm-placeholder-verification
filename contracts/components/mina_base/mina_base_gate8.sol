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
library mina_base_gate8 {
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

            // TODO: insert generated code for gate argument evaluation here
            let x1 := add(gate_params, CONSTRAINT_EVAL_OFFSET)
            let x2 := add(gate_params, WITNESS_EVALUATIONS_OFFSET)
            mstore(add(gate_params, GATE_EVAL_OFFSET), 0)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x7f42fc47bf3b73745c7cf1835318d0707f696da7ceb8686b064748482ade923,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x25642daf8a81d610b6a646410a64b19f403c42cb8be86733e1431140986386fe,mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),get_eval_i_by_rotation_idx(0,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x7b55f6050c5b78c81d29b095fcf55dbf3d93bb6ae6857e50278a679df3af934,mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),get_eval_i_by_rotation_idx(1,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x2d484fdf643cf7ff9b2a31b585fc9ac2a1233f549a628a5931b192e6193012c,mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),get_eval_i_by_rotation_idx(2,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(3,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x1391a8223e2837e5fd6612b63c28b8a6e0dad0b99a1c166c430aa790ace4b1e5,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x3611a838f43caeddf4ef867c503054417aae305760a767dd747585f94b40c5bf,mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),get_eval_i_by_rotation_idx(0,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x1f67666943d65692e897b2c52b37a67ef131727cd42a9b9d7a92d598c95dba72,mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),get_eval_i_by_rotation_idx(1,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x2b1c6524d1e8e51dcdee9be61180d9270927bb1363e9d68364b055783c4d1964,mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),get_eval_i_by_rotation_idx(2,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(4,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x2e2c57e4d9d038910af91192771a66e3145dcd5e37ea1f9f407bbb0943ba7b0e,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x28babbca8497809a56a6f3e209de7e74cdf3c327c7f37e8763ae1fc9e9109836,mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),get_eval_i_by_rotation_idx(0,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x356d9c23e5e62e83040ea4fe9944da08c669ca8e81f47139c3efafcd3d3beca,mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),get_eval_i_by_rotation_idx(1,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x30e04108a2b549c4857ed07f484fc8c6f6a77299f927ccf4bc7af17f551eeb5,mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),get_eval_i_by_rotation_idx(2,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(5,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x36494d7c1450ba044e1bb76965316419f767311e13c6e48941eb52365e458212,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x25642daf8a81d610b6a646410a64b19f403c42cb8be86733e1431140986386fe,mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),get_eval_i_by_rotation_idx(3,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x7b55f6050c5b78c81d29b095fcf55dbf3d93bb6ae6857e50278a679df3af934,mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),get_eval_i_by_rotation_idx(4,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x2d484fdf643cf7ff9b2a31b585fc9ac2a1233f549a628a5931b192e6193012c,mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),get_eval_i_by_rotation_idx(5,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(6,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x2a2af6ae9b377a89c057c3208892bc9c9fc47ee44cf79575e236511f53afb523,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x3611a838f43caeddf4ef867c503054417aae305760a767dd747585f94b40c5bf,mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),get_eval_i_by_rotation_idx(3,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x1f67666943d65692e897b2c52b37a67ef131727cd42a9b9d7a92d598c95dba72,mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),get_eval_i_by_rotation_idx(4,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x2b1c6524d1e8e51dcdee9be61180d9270927bb1363e9d68364b055783c4d1964,mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),get_eval_i_by_rotation_idx(5,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(7,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0xbd8024035c315dcf9c14ec73afaa39374aa56a9570fe65a769a005e00826edd,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x28babbca8497809a56a6f3e209de7e74cdf3c327c7f37e8763ae1fc9e9109836,mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),get_eval_i_by_rotation_idx(3,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x356d9c23e5e62e83040ea4fe9944da08c669ca8e81f47139c3efafcd3d3beca,mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),get_eval_i_by_rotation_idx(4,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x30e04108a2b549c4857ed07f484fc8c6f6a77299f927ccf4bc7af17f551eeb5,mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),get_eval_i_by_rotation_idx(5,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(8,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x18d0ed18cef8848bce810dabc3cc479e8d6b7b5612a5172cb8c7ca7a37e97a03,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x25642daf8a81d610b6a646410a64b19f403c42cb8be86733e1431140986386fe,mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),get_eval_i_by_rotation_idx(6,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x7b55f6050c5b78c81d29b095fcf55dbf3d93bb6ae6857e50278a679df3af934,mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),get_eval_i_by_rotation_idx(7,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x2d484fdf643cf7ff9b2a31b585fc9ac2a1233f549a628a5931b192e6193012c,mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),get_eval_i_by_rotation_idx(8,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(9,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x3acdc07a21473f83e6c3c858c28909eed8df07c1dd701802033bad05960bd69a,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x3611a838f43caeddf4ef867c503054417aae305760a767dd747585f94b40c5bf,mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),get_eval_i_by_rotation_idx(6,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x1f67666943d65692e897b2c52b37a67ef131727cd42a9b9d7a92d598c95dba72,mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),get_eval_i_by_rotation_idx(7,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x2b1c6524d1e8e51dcdee9be61180d9270927bb1363e9d68364b055783c4d1964,mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),get_eval_i_by_rotation_idx(8,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(10,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x2a31bea1351b45bd4be815c5afe4bb98d5229fe2959fc510402276dc7ad2c29,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x28babbca8497809a56a6f3e209de7e74cdf3c327c7f37e8763ae1fc9e9109836,mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),get_eval_i_by_rotation_idx(6,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x356d9c23e5e62e83040ea4fe9944da08c669ca8e81f47139c3efafcd3d3beca,mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),get_eval_i_by_rotation_idx(7,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x30e04108a2b549c4857ed07f484fc8c6f6a77299f927ccf4bc7af17f551eeb5,mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),get_eval_i_by_rotation_idx(8,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(11,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x31713e7384ad3aeb2bdfb80e0f4d56f36985d1c2ec53b17ec12fd4eee2c2470f,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x25642daf8a81d610b6a646410a64b19f403c42cb8be86733e1431140986386fe,mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),get_eval_i_by_rotation_idx(9,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x7b55f6050c5b78c81d29b095fcf55dbf3d93bb6ae6857e50278a679df3af934,mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),get_eval_i_by_rotation_idx(10,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x2d484fdf643cf7ff9b2a31b585fc9ac2a1233f549a628a5931b192e6193012c,mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),get_eval_i_by_rotation_idx(11,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(12,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x3ea6e379a158f9a2abcfbae60744d9744487e9c10e67aa3ec912adae2f5610e7,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x3611a838f43caeddf4ef867c503054417aae305760a767dd747585f94b40c5bf,mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),get_eval_i_by_rotation_idx(9,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x1f67666943d65692e897b2c52b37a67ef131727cd42a9b9d7a92d598c95dba72,mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),get_eval_i_by_rotation_idx(10,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x2b1c6524d1e8e51dcdee9be61180d9270927bb1363e9d68364b055783c4d1964,mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),get_eval_i_by_rotation_idx(11,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(13,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x12241111a135a2111b40e8763bca1ede065c1ea827408256bb8be4f03cee606,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x28babbca8497809a56a6f3e209de7e74cdf3c327c7f37e8763ae1fc9e9109836,mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),get_eval_i_by_rotation_idx(9,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x356d9c23e5e62e83040ea4fe9944da08c669ca8e81f47139c3efafcd3d3beca,mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),get_eval_i_by_rotation_idx(10,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x30e04108a2b549c4857ed07f484fc8c6f6a77299f927ccf4bc7af17f551eeb5,mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),get_eval_i_by_rotation_idx(11,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(14,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x1c96e38ff646d7c4d97899172b6e8e92e62d05151c58a03ca035ce3dc1caa8fa,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x25642daf8a81d610b6a646410a64b19f403c42cb8be86733e1431140986386fe,mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),get_eval_i_by_rotation_idx(12,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x7b55f6050c5b78c81d29b095fcf55dbf3d93bb6ae6857e50278a679df3af934,mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),get_eval_i_by_rotation_idx(13,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x2d484fdf643cf7ff9b2a31b585fc9ac2a1233f549a628a5931b192e6193012c,mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),get_eval_i_by_rotation_idx(14,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(0,1, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x193254d37c814153a415b41e290fb77fedb62587313297784a10e339682b3f66,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x3611a838f43caeddf4ef867c503054417aae305760a767dd747585f94b40c5bf,mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),get_eval_i_by_rotation_idx(12,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x1f67666943d65692e897b2c52b37a67ef131727cd42a9b9d7a92d598c95dba72,mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),get_eval_i_by_rotation_idx(13,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x2b1c6524d1e8e51dcdee9be61180d9270927bb1363e9d68364b055783c4d1964,mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),get_eval_i_by_rotation_idx(14,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(1,1, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x12ddf98cf99b2a741f989252e011f16716204e87f8aa2b64e3d6dd2b208d10ab,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x28babbca8497809a56a6f3e209de7e74cdf3c327c7f37e8763ae1fc9e9109836,mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),get_eval_i_by_rotation_idx(12,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x356d9c23e5e62e83040ea4fe9944da08c669ca8e81f47139c3efafcd3d3beca,mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),get_eval_i_by_rotation_idx(13,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x30e04108a2b549c4857ed07f484fc8c6f6a77299f927ccf4bc7af17f551eeb5,mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),get_eval_i_by_rotation_idx(14,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(2,1, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(add(gate_params, GATE_EVAL_OFFSET),mulmod(mload(add(gate_params, GATE_EVAL_OFFSET)),get_selector_i(8,mload(add(gate_params, SELECTOR_EVALUATIONS_OFFSET))),modulus))
            gates_evaluation := addmod(gates_evaluation,mload(add(gate_params, GATE_EVAL_OFFSET)),modulus)

        }
    }
}
