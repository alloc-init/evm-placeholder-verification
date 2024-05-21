
// SPDX-License-Identifier: Apache-2.0.
//---------------------------------------------------------------------------//
// Copyright (c) 2023 Generated by ZKLLVM-transpiler
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
import "../../basic_marshalling.sol";
import "../../interfaces/modular_gate_argument.sol";
import "hardhat/console.sol";


contract modular_gate_argument_circuit2 is IGateArgument{
    uint256 constant modulus = 52435875175126190479447740508185965837690552500527637822603658699938581184513;

    // Append commitments
    function verify(
        bytes calldata blob,
        uint256 theta
    ) external view returns (uint256 F){
        uint256 theta_acc = 1;
        uint256 eval;
        uint256 x;

		uint256 prod;
		uint256 sum;
		uint256 gate;
// gate === 0 ===
		gate = 0;
// constraint 0
		sum = 0;
		prod = basic_marshalling.get_uint256_be(blob, 192);
		sum = addmod(sum, prod, modulus);
		prod = basic_marshalling.get_uint256_be(blob, 224);
		prod = mulmod(prod, 52435875175126190479447740508185965837690552500527637822603658699938581184512, modulus);
		sum = addmod(sum, prod, modulus);
		prod = basic_marshalling.get_uint256_be(blob, 160);
		sum = addmod(sum, prod, modulus);
		sum = mulmod(sum, theta_acc, modulus);
		theta_acc = mulmod(theta, theta_acc, modulus);
		gate = addmod(gate, sum, modulus);
		gate = mulmod(gate, basic_marshalling.get_uint256_be(blob, 0), modulus);
		F = addmod(F, gate, modulus);
// gate === 1 ===
		gate = 0;
// constraint 0
		sum = 0;
		prod = basic_marshalling.get_uint256_be(blob, 128);
		sum = addmod(sum, prod, modulus);
		prod = basic_marshalling.get_uint256_be(blob, 224);
		prod = mulmod(prod, 52435875175126190479447740508185965837690552500527637822603658699938581184512, modulus);
		sum = addmod(sum, prod, modulus);
		prod = basic_marshalling.get_uint256_be(blob, 160);
		prod = mulmod(prod, basic_marshalling.get_uint256_be(blob, 192), modulus);
		sum = addmod(sum, prod, modulus);
		sum = mulmod(sum, theta_acc, modulus);
		theta_acc = mulmod(theta, theta_acc, modulus);
		gate = addmod(gate, sum, modulus);
		gate = mulmod(gate, basic_marshalling.get_uint256_be(blob, 64), modulus);
		F = addmod(F, gate, modulus);

    }
}        