#!/usr/local/bin/ruby

require './mpgapi4r.rb'

p = ReqMod::Reauth.new
c = ReqMod::CVDInfo.new
a = ReqMod::AVSInfo.new

p.cvd_info=c
p.avs_info=a

p.order_id = "rudy_efraud_test_3"
p.cust_id = "customer name"
p.amount = "10.26"
p.orig_order_id = "originalorderid"
p.txn_number = "12345-67_8"
p.crypt_type = "7"

#Efraud Variables
p.cvd_info.cvd_indicator="0"
p.cvd_info.cvd_value="123"

p.avs_info.avs_street_number="123"
p.avs_info.avs_street_name="East Street"
p.avs_info.avs_zipcode="M1M2M2"

r = ReqMod::Request.new

r.store_id = 'store5'
r.api_token = 'yesguy'

r.reauth = p

response = HttpsPoster.post(r)
print "\nCard Type = " + response.receipt.cardtype.to_s
print "\nTransaction Amount = " + response.receipt.transamount.to_s
print "\nTxnNumber = " + response.receipt.transid.to_s
print "\nReceiptID = " + response.receipt.receiptid.to_s
print "\nTransaction Type = " + response.receipt.transtype.to_s
print "\nReference Number = " + response.receipt.referencenum.to_s
print "\nResponse Code = " + response.receipt.responsecode.to_s
print "\nISO = " + response.receipt.iso.to_s
print "\nMessage = " + response.receipt.message.to_s
print "\nAuthcode = " + response.receipt.authcode.to_s
print "\nComplete = " + response.receipt.complete.to_s
print "\nTransaction Date = " + response.receipt.transdate.to_s
print "\nTransaction Time = " + response.receipt.transtime.to_s
print "\nTicket = " + response.receipt.ticket.to_s
print "\nTimedOut = " + response.receipt.timedout.to_s

if response.receipt.avsresultcode != nil
	print "\nAvsResponse = " + response.receipt.avsresultcode.to_s
end

if response.receipt.cvdresultcode != nil
	print "\nCvdResponse = " + response.receipt.cvdresultcode.to_s
end