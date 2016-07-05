#!/usr/local/bin/ruby

require './mpgapi4r.rb'

cv = ReqMod::CardVerification.new
c = ReqMod::CVDInfo.new
a = ReqMod::AVSInfo.new

cv.cvd_info=c
cv.avs_info=a

cv.order_id = "cardverify4"
cv.cust_id = "bob smith"
cv.pan = "4242424242424242"
cv.expdate = "1212"
cv.crypt_type = "7"


#Efraud Variables
cv.cvd_info.cvd_indicator="0"
cv.cvd_info.cvd_value="123"

cv.avs_info.avs_street_number="123"
cv.avs_info.avs_street_name="East Street"
cv.avs_info.avs_zipcode="M1M2M2"

r = ReqMod::Request.new

r.store_id = 'store5'
r.api_token = 'yesguy'

r.card_verification = cv

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