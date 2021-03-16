
//------------------------------------------------------------------------------
// (c) Copyright 2014 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//------------------------------------------------------------------------------ 
//
// C Model configuration for the "fir_compiler_0" instance.
//
//------------------------------------------------------------------------------
//
// coefficients: 0.008504686,-1.81366E-05,-0.011693625,7.98143E-07,0.019430789,-2.89953E-05,-0.03058495,6.3898E-06,0.046659575,-2.75159E-05,-0.07108406,1.11987E-05,0.112461926,-3.19411E-05,-0.203034939,1.46767E-05,0.633502936,0.999968889,0.633502936,1.46767E-05,-0.203034939,-3.19411E-05,0.112461926,1.11987E-05,-0.07108406,-2.75159E-05,0.046659575,6.3898E-06,-0.03058495,-2.89953E-05,0.019430789,7.98143E-07,-0.011693625,-1.81366E-05,0.008504686
// chanpats: 173
// name: fir_compiler_0
// filter_type: 0
// rate_change: 0
// interp_rate: 1
// decim_rate: 1
// zero_pack_factor: 1
// coeff_padding: 0
// num_coeffs: 35
// coeff_sets: 1
// reloadable: 0
// is_halfband: 0
// quantization: 1
// coeff_width: 32
// coeff_fract_width: 31
// chan_seq: 0
// num_channels: 1
// num_paths: 1
// data_width: 16
// data_fract_width: 0
// output_rounding_mode: 0
// output_width: 49
// output_fract_width: 31
// config_method: 0

const double fir_compiler_0_coefficients[35] = {0.008504686,-1.81366E-05,-0.011693625,7.98143E-07,0.019430789,-2.89953E-05,-0.03058495,6.3898E-06,0.046659575,-2.75159E-05,-0.07108406,1.11987E-05,0.112461926,-3.19411E-05,-0.203034939,1.46767E-05,0.633502936,0.999968889,0.633502936,1.46767E-05,-0.203034939,-3.19411E-05,0.112461926,1.11987E-05,-0.07108406,-2.75159E-05,0.046659575,6.3898E-06,-0.03058495,-2.89953E-05,0.019430789,7.98143E-07,-0.011693625,-1.81366E-05,0.008504686};

const xip_fir_v7_2_pattern fir_compiler_0_chanpats[1] = {P_BASIC};

static xip_fir_v7_2_config gen_fir_compiler_0_config() {
  xip_fir_v7_2_config config;
  config.name                = "fir_compiler_0";
  config.filter_type         = 0;
  config.rate_change         = XIP_FIR_INTEGER_RATE;
  config.interp_rate         = 1;
  config.decim_rate          = 1;
  config.zero_pack_factor    = 1;
  config.coeff               = &fir_compiler_0_coefficients[0];
  config.coeff_padding       = 0;
  config.num_coeffs          = 35;
  config.coeff_sets          = 1;
  config.reloadable          = 0;
  config.is_halfband         = 0;
  config.quantization        = XIP_FIR_QUANTIZED_ONLY;
  config.coeff_width         = 32;
  config.coeff_fract_width   = 31;
  config.chan_seq            = XIP_FIR_BASIC_CHAN_SEQ;
  config.num_channels        = 1;
  config.init_pattern        = fir_compiler_0_chanpats[0];
  config.num_paths           = 1;
  config.data_width          = 16;
  config.data_fract_width    = 0;
  config.output_rounding_mode= XIP_FIR_FULL_PRECISION;
  config.output_width        = 49;
  config.output_fract_width  = 31,
  config.config_method       = XIP_FIR_CONFIG_SINGLE;
  return config;
}

const xip_fir_v7_2_config fir_compiler_0_config = gen_fir_compiler_0_config();

