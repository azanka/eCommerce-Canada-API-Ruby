#!/usr/local/bin/ruby

require './mpgapi4r.rb'

p = ReqMod::Purchase.new
c = ReqMod::CVDInfo.new
a = ReqMod::AVSInfo.new

p.cvd_info=c
p.avs_info=a

p.order_id = "purchaseefraudtest2"
p.cust_id = "customer name"
p.amount = "10.01"
p.crypt_type = "7"

p.pan = "4242424242424242"
p.expdate = "1111"

#Efraud Variables
p.cvd_info.cvd_indicator="0"
p.cvd_info.cvd_value="123"

p.avs_info.avs_street_number="123"
p.avs_info.avs_street_name="East Street"
p.avs_info.avs_zipcode="M1M2M2"

#Additional AVS 
p.avs_info.avs_email="janesmith@test.com"
p.avs_info.avs_browser="Mozilla"
p.avs_info.avs_shiptocountry="CAN"
p.avs_info.avs_shipmethod="01"
p.avs_info.avs_merchprodsku="123123"
p.avs_info.avs_custip="192.168.0.1"
p.avs_info.avs_custphone="5556667777"

r = ReqMod::Request.new

r.store_id = 'store5'
r.api_token = 'yesguy'

r.purchase = p

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

if response.receipt.itdresponse != nil
	print "\nITDResponse = " + response.receipt.itdresponse.to_s
end