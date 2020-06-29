import ROOT
from ROOT import TFile, TTree, TCanvas, TGraph, TMultiGraph, TGraphErrors, TLegend
import subprocess # to execute shell command
ROOT.gROOT.SetBatch(ROOT.kTRUE)
 
# CMS style
#CMS_lumi.Text = "CMS"
#CMS_lumi.extraText = "Preliminary"
#CMS_lumi.TextSize = 0.65
#CMS_lumi.outOfFrame = True
#tdrstyle.setTDRStyle()
 
 
# GET limits from root file
def getLimits(file_name):

    myfile = TFile.Open(file_name, "READ")
    tree = myfile.upper_limit

    limits = [ ]
  
    for row in tree:
        values = [ ]
        values.append(row.mwp)
        values.append(row.median)
        values.append(row.plus_1sig)
        values.append(row.plus_2sig)
        values.append(row.minus_1sig)
        values.append(row.minus_2sig)

        limits.append(values)
        
    return limits
 
 
# PLOT upper limits
def plotUpperLimits():
    # for example, see CMS plot guidelines: https://ghm.web.cern.ch/ghm/plots/

    lumi = 150

    limits = getLimits("mwp_upper_limit_L{}.root".format(lumi))  # array of limits 

    N = len(limits)
    yellow = TGraph(2*N)    # yellow band
    green = TGraph(2*N)     # green band
    median = TGraph(N)      # median line
 
    up2s = [ ]
    for i in range(N):
        values = limits[i]
#        if i == 1 and lumi == 150:
#             values = [200, 0.8591836, 1.3878179, 1.9979995, 0.5129849, 0.3124208]
#        if i == 5 and lumi == 150:
#             values = [600, 0.108226, 0.152326, 0.207678, 0.076572, 0.0558201]
        up2s.append(values[3])
        yellow.SetPoint(    i,    values[0], values[3] ) # + 2 sigma
        green.SetPoint(     i,    values[0], values[2] ) # + 1 sigma
        median.SetPoint(    i,    values[0], values[1] ) # median
        green.SetPoint(  2*N-1-i, values[0], values[4] ) # - 1 sigma
        yellow.SetPoint( 2*N-1-i, values[0], values[5] ) # - 2 sigma

    ROOT.gStyle.SetLineScalePS(1)
 
    W = 809
    H  = 530
    T = 0.08*H
    B = 0.12*H
    L = 0.12*W
    R = 0.04*W
    c = TCanvas("c","c",100,100,W,H)
    c.SetLogy()
    c.SetFillColor(0)
    c.SetBorderMode(0)
    c.SetFrameFillStyle(0)
    c.SetFrameBorderMode(0)
    c.SetLeftMargin( L/W )
    c.SetRightMargin( R/W )
    c.SetTopMargin( T/H )
    c.SetBottomMargin( B/H )
    c.SetTickx(0)
    c.SetTicky(0)
    c.SetGrid()
    c.cd()
    frame = c.DrawFrame(1.4,0.001, 4.1, 10)
    frame.SetLineColor(ROOT.kBlue + 4)
    frame.GetYaxis().SetTitleSize(0.045)
    frame.GetXaxis().SetTitleSize(0.045)
    frame.GetXaxis().SetLabelSize(0.04)
    frame.GetYaxis().SetLabelSize(0.04)
    frame.GetXaxis().SetLabelColor(ROOT.kBlue + 4)
    frame.GetYaxis().SetLabelColor(ROOT.kBlue + 4)
    frame.GetXaxis().SetTitleColor(ROOT.kBlue + 4)
    frame.GetYaxis().SetTitleColor(ROOT.kBlue + 4)
    frame.GetXaxis().SetTitleOffset(1.28)
    frame.GetYaxis().SetTitleOffset(1.4)
    frame.GetXaxis().SetNdivisions(508)
    frame.GetYaxis().SetNdivisions(10)
    frame.GetXaxis().SetTickLength(0.0237)
    frame.GetYaxis().SetTickLength(0.0237)
    frame.GetXaxis().CenterTitle(True)
    frame.GetYaxis().CenterTitle(True)
    frame.GetYaxis().SetTitle("95% CLs upper limit #sigma [pb]")
#    frame.GetYaxis().SetTitle("95% upper limit on #sigma #times BR / (#sigma #times BR)_{SM}")
    frame.GetXaxis().SetTitle("m_{W'} [GeV]")
    frame.SetMinimum(0.001)
    frame.SetMaximum(max(up2s)*1.4)
    frame.GetXaxis().SetLimits(min(values)+50,max(values)+50)
 
    yellow.SetFillColorAlpha(ROOT.kOrange-4, 0.6)
    yellow.SetLineColorAlpha(ROOT.kOrange-4, 0.6)
    yellow.SetFillStyle(1001)
    yellow.Draw('F')
 
    green.SetFillColorAlpha(ROOT.kSpring-5, 0.3)
    green.SetLineColorAlpha(ROOT.kSpring-5, 0.3)
    green.SetFillStyle(1001)
    green.Draw('Fsame')
 
    median.SetLineColorAlpha(ROOT.kGreen + 4, 0.5)
    median.SetLineWidth(1)
    median.SetLineStyle(2)
    median.Draw('Lsame')
 
#    CMS_lumi.CMS_lumi(c,14,11)
    ROOT.gPad.SetTicks(1,1)
    frame.Draw('sameaxis')
 
    x1 = 0.625
    x2 = x1 + 0.31
    y2 = 0.885
    y1 = 0.75
    legend = TLegend(x1,y1,x2,y2)
    legend.SetFillStyle(1001)
    legend.SetFillColor(ROOT.kWhite)
    legend.SetBorderSize(0)
    legend.SetTextColor(ROOT.kBlue + 4)
    legend.SetTextSize(0.035)
    legend.SetTextFont(42)
    legend.AddEntry(median, "Asymptotic CL_{s} expected",'L')
    legend.AddEntry(green, "#pm 1 std. deviation",'f')
#    legend.AddEntry(green, "Asymptotic CL_{s} #pm 1 std. deviation",'f')
    legend.AddEntry(yellow,"#pm 2 std. deviation",'f')
#    legend.AddEntry(green, "Asymptotic CL_{s} #pm 2 std. deviation",'f')
    legend.Draw()

    tx = ROOT.TLatex()
    tx.SetNDC()
    tx.SetTextAngle(0)
    tx.SetTextColor(ROOT.kBlue + 4)
    tx.SetTextFont(42)
    tx.SetTextAlign(11)
    tx.SetTextSize(0.037)

    tx.DrawLatex(0.76, 0.95, "#sqrt{{s}} = 14 TeV, {} fb^{{-1}}".format(lumi) )

    c.Update()
 
    print " "
    c.SaveAs("UpperLimit_L{}.eps".format(lumi))
    c.Close()
 
 
# MAIN
def main():
    plotUpperLimits()
 
if __name__ == '__main__':
    main()
