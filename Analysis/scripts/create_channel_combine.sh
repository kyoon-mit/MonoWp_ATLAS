#!/bin/bash 

function create_channel_combine() {
# Input: (1) run (2) Lumi

declare -a masses=(100 200 300 400 500 600 700 800 900 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000)

mwp=${masses[(($1-1))]}

xml=${DIRCONFIG_MONOWP}/channels/combine/lumi_${2}/mwp_${mwp}.xml

mkdir -p ${DIRCONFIG_MONOWP}/channels/combine/lumi_${2}
cp ${DIRCONFIG_MONOWP}/HistFactorySchema.dtd ${DIRCONFIG_MONOWP}/channels/combine/lumi_${2}  # Need DTD file for the xml to work
touch $xml

cat << EndXML > $xml     # Recreate new xml file if exists

<!-- run hist2workspace ${DIRCONFIG_MONOWP}/channels/single/mwp_${mwp}.xml -->

<!DOCTYPE Combination  SYSTEM 'HistFactorySchema.dtd'>

<Combination OutputFilePrefix="${DIRCONFIG_MONOWP}/histworkspaces/lumi_${2}" >
EndXML

cat << EndXML >> $xml   # Append remaining information
<Input>./create_workspace/config/wpzp_final_L${L}/mwp_$mwp.xml</Input>
  <Measurement Name="mwp" Lumi="${2}" LumiRelErr="0.05" >
    <POI>xsec</POI>
    <ParamSetting Const="True">nevent_signal nevent_bkg1 pb_to_fb alpha_syst_signal alpha_syst_bkg1</ParamSetting>
  </Measurement>

</Combination>
EndXML

}


