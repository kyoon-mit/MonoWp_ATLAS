#!/bin/bash 

function create_channel_single() {
# args: (1)run_number

declare -a masses=(100 200 300 400 500 600 700 800 900 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000)
declare -a cross_section=(1.66e-05 1.39e-05 3.793e-05 3.867e-05 3.368e-05 2.82e-05 2.34e-05 1.935e-05 1.601e-05 1.327e-05 1.104e-05 9.227e-06 7.713e-06 6.471e-06 5.439e-06 4.574e-06 3.86e-06 3.259e-06 2.756e-06 2.335e-06)

mwp=${masses[(($1-1))]}
xsec=${cross_section[(($1-1))]}

touch ${DIRCONFIG_MONOWP}/channels/single/mwp_$mwp.xml

cat << EndXML > ${DIRCONFIG_MONOWP}/channels/single/mwp_$mwp.xml

<!-- Single channel configuration for mwp = $mwp -->

<!DOCTYPE Channel  SYSTEM 'HistFactorySchema.dtd'>

  <Channel Name="mwp_$mwp" InputFile="${DIRDATA_MONOWP}/Selection/DATA_lincut1.root" >

    <!-- Set the StatError type to Poisson. -->
    <StatErrorConfig RelErrorThreshold="0" ConstraintType="Poisson" />

    <!-- Signal -->
    <Sample Name="signal" HistoPath="lincut1/mwp${mwp}/" HistoName="signal" NormalizeByTheory="True">
      <NormFactor Name="xsec" Val="${xsec}" High="2" Low="0" Const="False"/>
      <NormFactor Name="nevent_signal" Val="1e-05" High="1e-02" Low="0" Const="True"/>
      <NormFactor Name="pb_to_fb" Val="1000" High="1001" Low="999" Const="True"/>
      <OverallSys Name="syst_signal" High="1.50" Low="0.50"/> <!--xsec-->
    </Sample>

    <!-- Background -->
    <Sample Name="background" HistoPath="lincut1/mwp${mwp}/" HistoName="bkg1_pp_ttbar" NormalizeByTheory="True" >
      <NormFactor Name="xsec_b" Val="544.7" High="550" Low="540" Const="True"/>
      <NormFactor Name="nevent_bkg1" Val="1.01206e-06" High="1e-04" Low="0" Const="True"/>
      <NormFactor Name="pb_to_fb" Val="1000" High="1001" Low="999" Const="True"/>
      <OverallSys Name="syst_bkg1" High="1.50" Low="0.50"/>
    </Sample>

  </Channel>
EndXML

}


