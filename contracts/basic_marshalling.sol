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

library basic_marshalling {
    uint256 constant LENGTH_OCTETS = 8;
    // 256 - 8 * LENGTH_OCTETS
    uint256 constant LENGTH_RESTORING_SHIFT = 0xc0;
    uint256 constant LENGTH_OCTETS_ADD_32 = 40;

    //================================================================================================================
    // Bounds non-checking functions
    //================================================================================================================
    // TODO: general case
    function skip_octet_vector_32_be(uint256 offset)
    internal pure returns (uint256 result_offset) {
        unchecked { result_offset = offset + LENGTH_OCTETS_ADD_32; }
    }

    function skip_uint256_be(uint256 offset)
    internal pure returns (uint256 result_offset) {
        unchecked { result_offset = offset + 32; }
    }

    function skip_vector_of_uint256_be(bytes calldata blob, uint256 offset)
    internal pure returns (uint256 result_offset) {
        assembly {
            result_offset := add(
                add(
                    offset,
                    mul(
                        0x20,
                        shr(
                            LENGTH_RESTORING_SHIFT,
                            calldataload(add(blob.offset, offset))
                        )
                    )
                ),
                LENGTH_OCTETS
            )
        }
    }

    function skip_vector_of_vectors_of_uint256_be(bytes calldata blob, uint256 offset)
    internal pure returns (uint256 result_offset) {
        unchecked { result_offset = offset + LENGTH_OCTETS; }
        uint256 n;
        assembly {
            n := shr(
                LENGTH_RESTORING_SHIFT,
                calldataload(add(blob.offset, offset))
            )
        }
        for (uint256 i = 0; i < n;) {
            result_offset = skip_vector_of_uint256_be(blob, result_offset);
            unchecked{ i++; }
        }
    }

    function skip_length(uint256 offset)
    internal pure returns (uint256 result_offset) {
        unchecked { result_offset = offset + LENGTH_OCTETS; }
    }

    function get_length(bytes calldata blob, uint256 offset)
    internal pure returns (uint256 result_length){
        assembly {
            result_length := shr(LENGTH_RESTORING_SHIFT, calldataload(add(blob.offset, offset)))
        }
    }

    function get_skip_length(bytes calldata blob, uint256 offset)
    internal pure returns (uint256 result_length, uint256 result_offset){
        assembly {
            result_length := shr(LENGTH_RESTORING_SHIFT, calldataload(add(blob.offset, offset)))
        }
        unchecked { result_offset = offset + LENGTH_OCTETS; }
    }

    function get_i_uint256_from_vector(bytes calldata blob, uint256 offset, uint256 i)
    internal pure returns (uint256 result) {
        assembly {
            result := calldataload(add(blob.offset, add(add(offset, LENGTH_OCTETS), mul(i, 0x20))))
        }
    }

    function get_i_j_uint256_from_vector_of_vectors(bytes calldata blob, uint256 offset, uint256 i, uint256 j)
    internal pure returns (uint256 result) {
        offset = skip_length(offset);
        for (uint256 _i = 0; _i < i;) {
            offset = skip_vector_of_uint256_be(blob, offset);
            unchecked{ _i++; }
        }
        result = get_i_uint256_from_vector(blob, offset, j);
    }


    function get_uint256_be(bytes calldata blob, uint256 offset)
    internal pure returns (uint256 result) {
        assembly {
            result := calldataload(add(blob.offset, offset))
        }
    }

    //================================================================================================================
    // Bounds checking functions
    //================================================================================================================
    // TODO: general case
    function skip_octet_vector_32_be_check(bytes calldata blob, uint256 offset)
    internal pure returns (uint256 result_offset) {
        unchecked { result_offset = offset + LENGTH_OCTETS_ADD_32; }
        require(result_offset <= blob.length);
    }


    function skip_uint256_be_check(bytes calldata blob, uint256 offset)
    internal pure returns (uint256 result_offset) {
        unchecked { result_offset = offset + 32; }
        require(result_offset <= blob.length);
    }

    function skip_vector_of_uint256_be_check(bytes calldata blob, uint256 offset)
    internal pure returns (uint256 result_offset) {
        assembly {
            result_offset := add(
                add(
                    offset,
                    mul(
                        0x20,
                        shr(
                            LENGTH_RESTORING_SHIFT,
                            calldataload(add(blob.offset, offset))
                        )
                    )
                ),
                LENGTH_OCTETS
            )
        }
        require(result_offset <= blob.length);
    }

    function skip_vector_of_vectors_of_uint256_be_check(bytes calldata blob, uint256 offset)
    internal pure returns (uint256 result_offset) {
        unchecked { result_offset = offset + LENGTH_OCTETS; }
        require(result_offset <= blob.length);
        uint256 n;
        assembly {
            n := shr(
                LENGTH_RESTORING_SHIFT,
                calldataload(add(blob.offset, offset))
            )
        }
        for (uint256 i = 0; i < n;) {
            result_offset = skip_vector_of_uint256_be_check(blob, result_offset);
            unchecked{ i++; }
        }
    }

    function skip_length_check(bytes calldata blob, uint256 offset)
    internal pure returns (uint256 result_offset){
        unchecked { result_offset = offset + LENGTH_OCTETS; }
        require(result_offset < blob.length);
    }

    function write_bytes(bytes memory sink , uint256 start_offset, bytes memory src)
    internal pure {
        for(uint256 idx=0 ; idx < src.length ; ++idx) {
            sink[start_offset + idx] = src[idx];
        }
    }

    function to_bytes(uint256 x)
    internal pure returns (bytes memory c) {
        bytes32 b = bytes32(x);
        c = new bytes(32);
        for (uint i=0; i < 32; i++) {
            c[i] = b[i];
        }
    }
}
