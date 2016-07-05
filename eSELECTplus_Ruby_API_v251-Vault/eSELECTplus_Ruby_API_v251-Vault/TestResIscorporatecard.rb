#!c:\ruby\bin\rubyw.exe
require './mpgapi4r.rb' #path to usmpgapi4r.rb 
p = ReqMod::ResIscorporatecard.new

p.data_key = "k8n3X9E2h79VNPf3888331tpt"

r = ReqMod::Request.new

r.store_id = 'store5'
r.api_token = 'yesguy'

r.res_iscorporatecard = p

response = HttpsPoster.post(r)
print "\nDataKey = " + response.receipt.datakey.to_s
print "\nCorporateCard = " + response.receipt.corporatecard.to_s
print "\nReceiptId = " + response.receipt.receiptid.to_s
print "\nResponse Code = " + response.receipt.responsecode.to_s
print "\nISO = " + response.receipt.iso.to_s
print "\nMessage = " + response.receipt.message.to_s
print "\nTransaction Date = " + response.receipt.transdate.to_s
print "\nTransaction Time = " + response.receipt.transtime.to_s
print "\nComplete = " + response.receipt.complete.to_s
print "\nCard Type = " + response.receipt.cardtype.to_s
print "\nTxn Number = " + response.receipt.txnnumber.to_s
print "\nTimedOut = " + response.receipt.timedout.to_s
print "\nResSuccess = " + response.receipt.ressuccess.to_s
print "\nPaymentType = " + response.receipt.paymenttype.to_s
