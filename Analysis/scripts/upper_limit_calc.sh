#! /bin/bash

declare -a masses=(100 200 300 400 500 600 700 800 900 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000)

L=150

source create_default_top_config
source create_default_channel

for i in {2..20}
do
mwp=${masses[(($i-1))]}
  create_default_top_config $i $L
  create_default_channel $i $L

  hist2workspace ./create_workspace/config/wpzp_final_L$L/wpzp_final.xml

  if (( $i < 4 )); then 
  root -l -b -q StandardHypoTestInvDemo.C'("config/histworkspaces/lumi_'$L'/wpzp_final_combined_mwp_model.root", "lincut1_mwp_upper_limit_L'$L'.root", "combined", "ModelConfig", "", "asimovData", 3, 3, true, 3000, 0.05, 1.5, 1000, '$mwp')'

  elif (( $i < 10 )); then
  root -l -b -q StandardHypoTestInvDemo.C'("config/histworkspaces/lumi_'$L'/wpzp_final_combined_mwp_model.root", "lincut1_mwp_upper_limit_L'$L'.root", "combined", "ModelConfig", "", "asimovData", 3, 3, true, 1200, 0.01, 0.6, 1000, '$mwp')'

  elif (( $i < 15 )); then
  root -l -b -q StandardHypoTestInvDemo.C'("config/histworkspaces/lumi_'$L'/wpzp_final_combined_mwp_model.root", "lincut1_mwp_upper_limit_L'$L'.root", "combined", "ModelConfig", "", "asimovData", 3, 3, true, 400, 0.001, 0.2, 1000, '$mwp')'

  else
  root -l -b -q StandardHypoTestInvDemo.C'("config/histworkspaces/lumi_'$L'/wpzp_final_combined_mwp_model.root", "lincut1_mwp_upper_limit_L'$L'.root", "combined", "ModelConfig", "", "asimovData", 3, 3, true, 160, 0.001, 0.04, 1000, '$mwp')'

  fi

done
