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
library mina_base_gate9 {
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
    uint256 constant PUBLIC_INPUT_EVALUATIONS_OFFSET = 0x1c0;
    uint256 constant CONSTANT_EVALUATIONS_OFFSET = 0x1a0;

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
            mstore(x1,addmod(mload(x1),0x1448b44e7ac8dccb5b10a092e71d131ae1bfb2d104b49b4404761f71f416de82,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x25642daf8a81d610b6a646410a64b19f403c42cb8be86733e1431140986386fe,mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),get_eval_i_by_rotation_idx(0,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x7b55f6050c5b78c81d29b095fcf55dbf3d93bb6ae6857e50278a679df3af934,mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),get_eval_i_by_rotation_idx(1,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x2d484fdf643cf7ff9b2a31b585fc9ac2a1233f549a628a5931b192e6193012c,mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),get_eval_i_by_rotation_idx(2,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(3,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x99daf016d73ba272a55ca0f5ebd8ab71a475ca2853cdf804092081f7ae4ddfd,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x3611a838f43caeddf4ef867c503054417aae305760a767dd747585f94b40c5bf,mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),get_eval_i_by_rotation_idx(0,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x1f67666943d65692e897b2c52b37a67ef131727cd42a9b9d7a92d598c95dba72,mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),get_eval_i_by_rotation_idx(1,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x2b1c6524d1e8e51dcdee9be61180d9270927bb1363e9d68364b055783c4d1964,mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),get_eval_i_by_rotation_idx(2,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(4,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x279707ee7b7d394b5a59e57e375535ed98f3815fe855bed796ff9776423cb510,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x28babbca8497809a56a6f3e209de7e74cdf3c327c7f37e8763ae1fc9e9109836,mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(0,0, mload(x2)),get_eval_i_by_rotation_idx(0,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x356d9c23e5e62e83040ea4fe9944da08c669ca8e81f47139c3efafcd3d3beca,mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(1,0, mload(x2)),get_eval_i_by_rotation_idx(1,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x30e04108a2b549c4857ed07f484fc8c6f6a77299f927ccf4bc7af17f551eeb5,mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(2,0, mload(x2)),get_eval_i_by_rotation_idx(2,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(5,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x3486fe398f1e28a28d914772fff6af4c58e2a8046282d4824d51293ed0874b2e,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x25642daf8a81d610b6a646410a64b19f403c42cb8be86733e1431140986386fe,mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),get_eval_i_by_rotation_idx(3,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x7b55f6050c5b78c81d29b095fcf55dbf3d93bb6ae6857e50278a679df3af934,mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),get_eval_i_by_rotation_idx(4,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x2d484fdf643cf7ff9b2a31b585fc9ac2a1233f549a628a5931b192e6193012c,mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),get_eval_i_by_rotation_idx(5,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(6,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x3cd3b427548f1e0da508850a822cbf373b7df7fa2987103e95fbeb86246f4791,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x3611a838f43caeddf4ef867c503054417aae305760a767dd747585f94b40c5bf,mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),get_eval_i_by_rotation_idx(3,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x1f67666943d65692e897b2c52b37a67ef131727cd42a9b9d7a92d598c95dba72,mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),get_eval_i_by_rotation_idx(4,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x2b1c6524d1e8e51dcdee9be61180d9270927bb1363e9d68364b055783c4d1964,mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),get_eval_i_by_rotation_idx(5,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(7,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x231c924ce01915c326cf724655bc5750c604f00b62fc5d1d983c4938793f5477,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x28babbca8497809a56a6f3e209de7e74cdf3c327c7f37e8763ae1fc9e9109836,mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(3,0, mload(x2)),get_eval_i_by_rotation_idx(3,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x356d9c23e5e62e83040ea4fe9944da08c669ca8e81f47139c3efafcd3d3beca,mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(4,0, mload(x2)),get_eval_i_by_rotation_idx(4,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x30e04108a2b549c4857ed07f484fc8c6f6a77299f927ccf4bc7af17f551eeb5,mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(5,0, mload(x2)),get_eval_i_by_rotation_idx(5,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(8,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x19a691561e6ea1ac25cb86162ec3c36e1d40b6b76b1aa10a99c0889701b48393,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x25642daf8a81d610b6a646410a64b19f403c42cb8be86733e1431140986386fe,mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),get_eval_i_by_rotation_idx(6,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x7b55f6050c5b78c81d29b095fcf55dbf3d93bb6ae6857e50278a679df3af934,mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),get_eval_i_by_rotation_idx(7,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x2d484fdf643cf7ff9b2a31b585fc9ac2a1233f549a628a5931b192e6193012c,mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),get_eval_i_by_rotation_idx(8,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(9,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0xf0d695d967975803570a4e1d963fee9f1f8a5e4dff75ef48abbfbe32c592a25,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x3611a838f43caeddf4ef867c503054417aae305760a767dd747585f94b40c5bf,mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),get_eval_i_by_rotation_idx(6,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x1f67666943d65692e897b2c52b37a67ef131727cd42a9b9d7a92d598c95dba72,mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),get_eval_i_by_rotation_idx(7,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x2b1c6524d1e8e51dcdee9be61180d9270927bb1363e9d68364b055783c4d1964,mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),get_eval_i_by_rotation_idx(8,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(10,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x3da7769e1008768278149538dcaf1060cfe292b43d7ac7e50792979f02e6862c,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x28babbca8497809a56a6f3e209de7e74cdf3c327c7f37e8763ae1fc9e9109836,mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(6,0, mload(x2)),get_eval_i_by_rotation_idx(6,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x356d9c23e5e62e83040ea4fe9944da08c669ca8e81f47139c3efafcd3d3beca,mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(7,0, mload(x2)),get_eval_i_by_rotation_idx(7,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x30e04108a2b549c4857ed07f484fc8c6f6a77299f927ccf4bc7af17f551eeb5,mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(8,0, mload(x2)),get_eval_i_by_rotation_idx(8,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(11,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x295b61968de17f96f2be1f9dd61643d2674cf65014946592be08ab93abf629d6,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x25642daf8a81d610b6a646410a64b19f403c42cb8be86733e1431140986386fe,mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),get_eval_i_by_rotation_idx(9,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x7b55f6050c5b78c81d29b095fcf55dbf3d93bb6ae6857e50278a679df3af934,mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),get_eval_i_by_rotation_idx(10,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x2d484fdf643cf7ff9b2a31b585fc9ac2a1233f549a628a5931b192e6193012c,mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),get_eval_i_by_rotation_idx(11,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(12,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x28535fd3fae03527f8c30298def32bde81510710d02b4cdfbf251af93a25842,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x3611a838f43caeddf4ef867c503054417aae305760a767dd747585f94b40c5bf,mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),get_eval_i_by_rotation_idx(9,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x1f67666943d65692e897b2c52b37a67ef131727cd42a9b9d7a92d598c95dba72,mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),get_eval_i_by_rotation_idx(10,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x2b1c6524d1e8e51dcdee9be61180d9270927bb1363e9d68364b055783c4d1964,mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),get_eval_i_by_rotation_idx(11,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(13,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x16642b758bf4886ff8ad97ced547f8d3b0047b1663097975b6d8fefd6ae7b84d,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x28babbca8497809a56a6f3e209de7e74cdf3c327c7f37e8763ae1fc9e9109836,mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(9,0, mload(x2)),get_eval_i_by_rotation_idx(9,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x356d9c23e5e62e83040ea4fe9944da08c669ca8e81f47139c3efafcd3d3beca,mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(10,0, mload(x2)),get_eval_i_by_rotation_idx(10,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x30e04108a2b549c4857ed07f484fc8c6f6a77299f927ccf4bc7af17f551eeb5,mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(11,0, mload(x2)),get_eval_i_by_rotation_idx(11,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(14,0, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x2e59647982615dd13e4d0d71699e8ed63ed7a94d5f64e6afbcc2ee336f8d6fd6,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x25642daf8a81d610b6a646410a64b19f403c42cb8be86733e1431140986386fe,mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),get_eval_i_by_rotation_idx(12,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x7b55f6050c5b78c81d29b095fcf55dbf3d93bb6ae6857e50278a679df3af934,mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),get_eval_i_by_rotation_idx(13,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x2d484fdf643cf7ff9b2a31b585fc9ac2a1233f549a628a5931b192e6193012c,mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),get_eval_i_by_rotation_idx(14,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(0,1, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x1a43e50c6e0c3e0dd7b56a256d4a77c3070c5882be29a068b1862122dd259b33,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x3611a838f43caeddf4ef867c503054417aae305760a767dd747585f94b40c5bf,mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),get_eval_i_by_rotation_idx(12,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x1f67666943d65692e897b2c52b37a67ef131727cd42a9b9d7a92d598c95dba72,mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),get_eval_i_by_rotation_idx(13,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x2b1c6524d1e8e51dcdee9be61180d9270927bb1363e9d68364b055783c4d1964,mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),get_eval_i_by_rotation_idx(14,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(1,1, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(x1, 0)
            mstore(x1,addmod(mload(x1),0x9e54c7bc0b272252121c627d44e57ef82bce2225f3b7d8c62cf4cb46a21f457,modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x28babbca8497809a56a6f3e209de7e74cdf3c327c7f37e8763ae1fc9e9109836,mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(12,0, mload(x2)),get_eval_i_by_rotation_idx(12,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x356d9c23e5e62e83040ea4fe9944da08c669ca8e81f47139c3efafcd3d3beca,mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(13,0, mload(x2)),get_eval_i_by_rotation_idx(13,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),mulmod(0x30e04108a2b549c4857ed07f484fc8c6f6a77299f927ccf4bc7af17f551eeb5,mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),mulmod(get_eval_i_by_rotation_idx(14,0, mload(x2)),get_eval_i_by_rotation_idx(14,0, mload(x2)), modulus), modulus), modulus), modulus), modulus), modulus),modulus),modulus))
            mstore(x1,addmod(mload(x1),get_eval_i_by_rotation_idx(2,1, mload(x2)),modulus))
            mstore(add(gate_params, GATE_EVAL_OFFSET),addmod(mload(add(gate_params, GATE_EVAL_OFFSET)),mulmod(mload(x1),theta_acc,modulus),modulus))
            theta_acc := mulmod(theta_acc,mload(add(gate_params, THETA_OFFSET)),modulus)
            mstore(add(gate_params, GATE_EVAL_OFFSET),mulmod(mload(add(gate_params, GATE_EVAL_OFFSET)),get_selector_i(9,mload(add(gate_params, SELECTOR_EVALUATIONS_OFFSET))),modulus))
            gates_evaluation := addmod(gates_evaluation,mload(add(gate_params, GATE_EVAL_OFFSET)),modulus)

        }
    }
}
