// SPDX-License-Identifier: Apache-2.0.
//---------------------------------------------------------------------------//
// Copyright (c) 2021 Mikhail Komarov <nemo@nil.foundation>
// Copyright (c) 2021 Ilias Khairullin <ilias@nil.foundation>
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

import "../types.sol";
import "../containers/merkle_verifier.sol";
import "../cryptography/transcript.sol";
import "../algebra/field.sol";
import "../algebra/polynomial.sol";
import "../basic_marshalling.sol";

library batched_fri_verifier {
    struct local_vars_type {
        uint256 colinear_value;
        // 0x20
        uint256 T_root_offset;
        // 0x40
        uint256 final_poly_offset;
        // 0x60
        uint256 x;
        // 0x80
        uint256 x_next;
        // 0xa0
        uint256 alpha;
        // 0xc0
        uint256[] y;
        // round proof verification variables
        // 0xe0
        bytes verified_data;
        // 0x100
        uint256 round_proof_offset;
        // 0x120
        uint256 round_proof_y_offset;
        // 0x140
        uint256 round_proof_p_offset;
        // 0x160
        uint256 y_polynom_index_j;
        // 0x180
        bool status;
    }

    uint256 constant VERIFIED_DATA_OFFSET = 0xe0;
    uint256 constant ROUND_PROOF_OFFSET_OFFSET = 0x100;
    uint256 constant ROUND_PROOF_Y_OFFSET_OFFSET = 0x120;
    uint256 constant ROUND_PROOF_P_OFFSET_OFFSET = 0x140;
    uint256 constant Y_POLYNOM_INDEX_J_OFFSET = 0x160;

    uint256 constant m = 2;

    function skip_round_proof_be(bytes calldata blob, uint256 offset)
        internal
        pure
        returns (uint256 result_offset)
    {
        // colinear_value
        result_offset = basic_marshalling.skip_vector_of_uint256_be(
            blob,
            offset
        );
        // T_root
        result_offset = basic_marshalling.skip_octet_vector_32_be(
            blob,
            result_offset
        );
        // y
        result_offset = basic_marshalling.skip_vector_of_vectors_of_uint256_be(
            blob,
            result_offset
        );
        // colinear_path
        result_offset = merkle_verifier.skip_merkle_proof_be(
            blob,
            result_offset
        );
        // p
        uint256 value_len;
        (value_len, result_offset) = basic_marshalling.get_skip_length(
            blob,
            result_offset
        );
        for (uint256 i = 0; i < value_len; i++) {
            result_offset = merkle_verifier.skip_merkle_proof_be(
                blob,
                result_offset
            );
        }
    }

    function skip_proof_be(bytes calldata blob, uint256 offset)
        internal
        pure
        returns (uint256 result_offset)
    {
        // final_polynomial
        result_offset = basic_marshalling.skip_vector_of_vectors_of_uint256_be(
            blob,
            offset
        );
        // round_proofs
        uint256 value_len;
        (value_len, result_offset) = basic_marshalling.get_skip_length(
            blob,
            result_offset
        );
        for (uint256 i = 0; i < value_len; i++) {
            result_offset = skip_round_proof_be(blob, result_offset);
        }
    }

    function get_round_proofs_n_be(bytes calldata blob, uint256 offset)
        internal
        pure
        returns (uint256 n)
    {
        // final_polynomial
        offset = basic_marshalling.skip_vector_of_vectors_of_uint256_be(
            blob,
            offset
        );
        // round_proofs
        n = basic_marshalling.get_length(blob, offset);
    }

    function get_round_proof_y_n_be(bytes calldata blob, uint256 offset)
        internal
        pure
        returns (uint256 n)
    {
        // colinear_value
        uint256 result_offset = basic_marshalling.skip_vector_of_uint256_be(
            blob,
            offset
        );
        // T_root
        result_offset = basic_marshalling.skip_octet_vector_32_be(
            blob,
            result_offset
        );
        // y
        n = basic_marshalling.get_length(blob, result_offset);
    }

    function get_round_proof_p_n_be(bytes calldata blob, uint256 offset)
        internal
        pure
        returns (uint256 n)
    {
        // colinear_value
        uint256 result_offset = basic_marshalling.skip_vector_of_uint256_be(
            blob,
            offset
        );
        // T_root
        result_offset = basic_marshalling.skip_octet_vector_32_be(
            blob,
            result_offset
        );
        // y
        result_offset = basic_marshalling.skip_vector_of_vectors_of_uint256_be(
            blob,
            result_offset
        );
        // colinear_path
        result_offset = merkle_verifier.skip_merkle_proof_be(
            blob,
            result_offset
        );
        // p
        n = basic_marshalling.get_length(blob, result_offset);
    }

    function skip_to_round_proof_T_root_be(bytes calldata blob, uint256 offset)
        internal
        pure
        returns (uint256 result_offset)
    {
        // colinear_value
        result_offset = basic_marshalling.skip_vector_of_uint256_be(
            blob,
            offset
        );
        // T_root
        result_offset = basic_marshalling.skip_length(blob, result_offset);
    }

    function skip_to_first_round_proof_be(bytes calldata blob, uint256 offset)
        internal
        pure
        returns (uint256 result_offset)
    {
        // final_polynomial
        result_offset = basic_marshalling.skip_vector_of_vectors_of_uint256_be(
            blob,
            offset
        );
        result_offset = basic_marshalling.skip_length(blob, result_offset);
    }

    function skip_to_first_round_proof_y_be(bytes calldata blob, uint256 offset)
        internal
        pure
        returns (uint256 result_offset)
    {
        // colinear_value
        result_offset = basic_marshalling.skip_vector_of_uint256_be(
            blob,
            offset
        );
        // T_root
        result_offset = basic_marshalling.skip_octet_vector_32_be(
            blob,
            result_offset
        );
        // y
        result_offset = basic_marshalling.skip_length(blob, result_offset);
    }

    function skip_to_first_round_proof_p_be(bytes calldata blob, uint256 offset)
        internal
        pure
        returns (uint256 result_offset)
    {
        // colinear_value
        result_offset = basic_marshalling.skip_vector_of_uint256_be(
            blob,
            offset
        );
        // T_root
        result_offset = basic_marshalling.skip_octet_vector_32_be(
            blob,
            result_offset
        );
        // y
        result_offset = basic_marshalling.skip_vector_of_vectors_of_uint256_be(
            blob,
            result_offset
        );
        // colinear_path
        result_offset = merkle_verifier.skip_merkle_proof_be(
            blob,
            result_offset
        );
        // p
        result_offset = basic_marshalling.skip_length(blob, result_offset);
    }

    function skip_to_round_proof_colinear_path_be(
        bytes calldata blob,
        uint256 offset
    ) internal pure returns (uint256 result_offset) {
        // colinear_value
        result_offset = basic_marshalling.skip_vector_of_uint256_be(
            blob,
            offset
        );
        // T_root
        result_offset = basic_marshalling.skip_octet_vector_32_be(
            blob,
            result_offset
        );
        // y
        result_offset = basic_marshalling.skip_vector_of_vectors_of_uint256_be(
            blob,
            result_offset
        );
    }

    function skip_round_proof_be_check(bytes calldata blob, uint256 offset)
        internal
        pure
        returns (uint256 result_offset)
    {
        // colinear_value
        result_offset = basic_marshalling.skip_vector_of_uint256_be_check(
            blob,
            offset
        );
        // T_root
        result_offset = basic_marshalling.skip_octet_vector_32_be_check(
            blob,
            result_offset
        );
        // y
        result_offset = basic_marshalling
            .skip_vector_of_vectors_of_uint256_be_check(blob, result_offset);
        // colinear_path
        result_offset = merkle_verifier.skip_merkle_proof_be_check(
            blob,
            result_offset
        );
        // p
        uint256 value_len;
        (value_len, result_offset) = basic_marshalling.get_skip_length_check(
            blob,
            result_offset
        );
        for (uint256 i = 0; i < value_len; i++) {
            result_offset = merkle_verifier.skip_merkle_proof_be_check(
                blob,
                result_offset
            );
        }
    }

    function skip_proof_be_check(bytes calldata blob, uint256 offset)
        internal
        pure
        returns (uint256 result_offset)
    {
        // final_polynomial
        result_offset = basic_marshalling
            .skip_vector_of_vectors_of_uint256_be_check(blob, offset);
        // round_proofs
        uint256 value_len;
        (value_len, result_offset) = basic_marshalling.get_skip_length_check(
            blob,
            result_offset
        );
        for (uint256 i = 0; i < value_len; i++) {
            result_offset = skip_round_proof_be_check(blob, result_offset);
        }
    }

    function eval_y_from_blob(
        bytes calldata blob,
        local_vars_type memory local_vars,
        uint256 i,
        uint256 j,
        uint256 polynom_index,
        types.batched_fri_params_type memory fri_params
    ) internal view returns (uint256 result) {
        result = basic_marshalling.get_i_uint256_from_vector(
            blob,
            local_vars.round_proof_y_offset,
            j
        );
        if (i == 0) {
            uint256 U_evaluated_neg;
            uint256 V_evaluated_inv;
            if (j == 0) {
                U_evaluated_neg =
                    fri_params.modulus -
                    polynomial.evaluate(
                        fri_params.U[polynom_index],
                        local_vars.x,
                        fri_params.modulus
                    );
                V_evaluated_inv = field.inverse_static(
                    polynomial.evaluate(
                        fri_params.V[polynom_index],
                        local_vars.x,
                        fri_params.modulus
                    ),
                    fri_params.modulus
                );
            } else if (j == 1) {
                U_evaluated_neg =
                    fri_params.modulus -
                    polynomial.evaluate(
                        fri_params.U[polynom_index],
                        fri_params.modulus - local_vars.x,
                        fri_params.modulus
                    );
                V_evaluated_inv = field.inverse_static(
                    polynomial.evaluate(
                        fri_params.V[polynom_index],
                        fri_params.modulus - local_vars.x,
                        fri_params.modulus
                    ),
                    fri_params.modulus
                );
            }
            assembly {
                result := mulmod(
                    addmod(result, U_evaluated_neg, mload(fri_params)),
                    V_evaluated_inv,
                    mload(fri_params)
                )
            }
        }
    }

    function store_i_chunk_in_verified_data(
        local_vars_type memory local_vars,
        uint256 chunk,
        uint256 i
    ) internal pure {
        assembly {
            mstore(
                add(
                    add(mload(add(local_vars, VERIFIED_DATA_OFFSET)), 0x20),
                    mul(0x20, i)
                ),
                chunk
            )
        }
    }

    function parse_verify_round_proof_be(
        bytes calldata blob,
        uint256 round_proof_offset,
        types.batched_fri_params_type memory fri_params,
        local_vars_type memory local_vars
    ) internal pure returns (bool result) {
        require(
            fri_params.leaf_size ==
                get_round_proof_y_n_be(blob, round_proof_offset),
            "Round proof y size is not equal to params.leaf_size!"
        );
        require(
            m == get_round_proof_p_n_be(blob, round_proof_offset),
            "Round proof p size is not equal to m!"
        );

        local_vars.round_proof_p_offset = skip_to_first_round_proof_p_be(
            blob,
            round_proof_offset
        );

        for (uint256 j = 0; j < m; j++) {
            local_vars.round_proof_y_offset = skip_to_first_round_proof_y_be(
                blob,
                round_proof_offset
            );
            for (
                uint256 polynom_index = 0;
                polynom_index < fri_params.leaf_size;
                polynom_index++
            ) {
                require(
                    m ==
                        basic_marshalling.get_length(
                            blob,
                            local_vars.round_proof_y_offset
                        ),
                    "y[polynom_index] size is not equal to m!"
                );
                local_vars.y_polynom_index_j = basic_marshalling
                    .get_i_uint256_from_vector(
                        blob,
                        local_vars.round_proof_y_offset,
                        j
                    );
                store_i_chunk_in_verified_data(
                    local_vars,
                    local_vars.y_polynom_index_j,
                    polynom_index
                );
                local_vars.round_proof_y_offset = basic_marshalling
                    .skip_vector_of_uint256_be(
                        blob,
                        local_vars.round_proof_y_offset
                    );
            }
            (local_vars.status, ) = merkle_verifier
                .parse_verify_merkle_proof_bytes_be(
                    blob,
                    local_vars.round_proof_p_offset,
                    local_vars.verified_data
                );
            if (!local_vars.status) {
                return false;
            }
            local_vars.round_proof_p_offset = merkle_verifier
                .skip_merkle_proof_be(blob, local_vars.round_proof_p_offset);
        }
        result = true;
    }

    function parse_verify_proof_be(
        bytes calldata blob,
        uint256 offset,
        types.transcript_data memory tr_state,
        types.batched_fri_params_type memory fri_params
    ) internal view returns (bool result) {
        result = false;

        require(
            fri_params.r == get_round_proofs_n_be(blob, offset),
            "Round proofs number is not equal to params.r!"
        );

        local_vars_type memory local_vars;
        local_vars.y = new uint256[](2);
        local_vars.x = field.expmod_static(
            fri_params.D_omegas[0],
            transcript.get_integral_challenge_be(tr_state, 8),
            fri_params.modulus
        );
        local_vars.round_proof_offset = skip_to_first_round_proof_be(
            blob,
            offset
        );
        local_vars.verified_data = new bytes(0x20 * fri_params.leaf_size);

        for (uint256 i = 0; i < fri_params.r; i++) {
            local_vars.alpha = transcript.get_field_challenge(
                tr_state,
                fri_params.modulus
            );
            local_vars.x_next = polynomial.evaluate(
                fri_params.q,
                local_vars.x,
                fri_params.modulus
            );

            local_vars.status = parse_verify_round_proof_be(
                blob,
                local_vars.round_proof_offset,
                fri_params,
                local_vars
            );
            if (!local_vars.status) {
                return false;
            }

            local_vars.round_proof_y_offset = skip_to_first_round_proof_y_be(
                blob,
                local_vars.round_proof_offset
            );
            for (
                uint256 polynom_index = 0;
                polynom_index < fri_params.leaf_size;
                polynom_index++
            ) {
                for (uint256 j = 0; j < m; j++) {
                    local_vars.y[j] = eval_y_from_blob(
                        blob,
                        local_vars,
                        i,
                        j,
                        polynom_index,
                        fri_params
                    );
                }
                local_vars.colinear_value = basic_marshalling
                    .get_i_uint256_from_vector(
                        blob,
                        local_vars.round_proof_offset,
                        polynom_index
                    );
                store_i_chunk_in_verified_data(
                    local_vars,
                    local_vars.colinear_value,
                    polynom_index
                );
                if (
                    polynomial.interpolate_evaluate_by_2_points_neg_x(
                        local_vars.x,
                        field.inverse_static(
                            field.double(local_vars.x, fri_params.modulus),
                            fri_params.modulus
                        ),
                        local_vars.y[0],
                        local_vars.y[1],
                        local_vars.alpha,
                        fri_params.modulus
                    ) != local_vars.colinear_value
                ) {
                    return false;
                }
                local_vars.round_proof_y_offset = basic_marshalling
                    .skip_vector_of_uint256_be(
                        blob,
                        local_vars.round_proof_y_offset
                    );
            }

            if (i < fri_params.r - 1) {
                // get round_proofs[i + 1].T_root
                local_vars.T_root_offset = skip_to_round_proof_T_root_be(
                    blob,
                    skip_round_proof_be(blob, local_vars.round_proof_offset)
                );
                transcript.update_transcript_b32_by_offset_calldata(
                    tr_state,
                    blob,
                    local_vars.T_root_offset
                );
                (local_vars.status, ) = merkle_verifier
                    .parse_verify_merkle_proof_bytes_be(
                        blob,
                        skip_to_round_proof_colinear_path_be(
                            blob,
                            local_vars.round_proof_offset
                        ),
                        local_vars.verified_data
                    );
                if (!local_vars.status) {
                    return false;
                }
                local_vars.round_proof_offset = skip_round_proof_be(
                    blob,
                    local_vars.round_proof_offset
                );
            }

            local_vars.x = local_vars.x_next;
        }

        require(
            fri_params.leaf_size == basic_marshalling.get_length(blob, offset),
            "Final poly array size is not equal to params.leaf_size!"
        );
        local_vars.final_poly_offset = offset + basic_marshalling.LENGTH_OCTETS;
        for (
            uint256 polynom_index = 0;
            polynom_index < fri_params.leaf_size;
            polynom_index++
        ) {
            if (
                basic_marshalling.get_length(
                    blob,
                    local_vars.final_poly_offset
                ) -
                    1 >
                uint256(2) **
                    (field.log2(fri_params.max_degree + 1) - fri_params.r) -
                    1
            ) {
                return false;
            }

            if (
                polynomial.evaluate_by_ptr(
                    blob,
                    local_vars.final_poly_offset +
                        basic_marshalling.LENGTH_OCTETS,
                    basic_marshalling.get_length(
                        blob,
                        local_vars.final_poly_offset
                    ),
                    local_vars.x,
                    fri_params.modulus
                ) !=
                // colinear_value[polynom_index]
                basic_marshalling.get_i_uint256_from_vector(
                    blob,
                    local_vars.round_proof_offset,
                    polynom_index
                )
            ) {
                return false;
            }
            local_vars.final_poly_offset = basic_marshalling
                .skip_vector_of_uint256_be(blob, local_vars.final_poly_offset);
        }

        result = true;
    }
}
