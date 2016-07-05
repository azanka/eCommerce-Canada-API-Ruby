#!c:\ruby\bin\rubyw.exe
require './mpgapi4r.rb' #path to mpgapi4r.rb 
p = ReqMod::ResAddCC.new

p.cust_id = "john smith"
p.phone = "416-555-5555"
p.email = "bob@smith.com"
p.note = "this is my note"
p.pan = "4242424242424242"
p.expdate = "0909"
p.crypt_type = "7"

#AvsInfo Variables
avs = ReqMod::AVSInfo.new
avs.avs_street_number = "1"
avs.avs_street_name = "bloor st"
avs.avs_zipcode = "90210"

p.avs_info = avs

r = ReqMod::Request.new

r.store_id = 'store5'
r.api_token = 'yesguy'

r.res_add_cc = p

response = HttpsPoster.post(r)
print "\nDataKey = " + response.receipt.datakey.to_s
print "\nResponse Code = " + response.receipt.responsecode.to_s
print "\nMessage = " + response.receipt.message.to_s
print "\nTransaction Date = " + response.receipt.transdate.to_s
print "\nTransaction Time = " + response.receipt.transtime.to_s
print "\nComplete = " + response.receipt.complete.to_s
print "\nTimedOut = " + response.receipt.timedout.to_s
print "\nResSuccess = " + response.receipt.ressuccess.to_s
print "\nPaymentType = " + response.receipt.paymenttype.to_s

#ResolveData
print "\n\nCust ID = " + response.receipt.resolvedata[0].cust_id.to_s
print "\nPhone = " + response.receipt.resolvedata[0].phone.to_s
print "\nEmail = " + response.receipt.resolvedata[0].email.to_s
print "\nNote = " + response.receipt.resolvedata[0].note.to_s
print "\nMasked Pan = " + response.receipt.resolvedata[0].masked_pan.to_s
print "\nExpDate = " + response.receipt.resolvedata[0].expdate.to_s
print "\nCrypt Type = " + response.receipt.resolvedata[0].crypt_type.to_s
print "\nAvs Street Number = " + response.receipt.resolvedata[0].avs_street_number.to_s
print "\nAvs Street Name = " + response.receipt.resolvedata[0].avs_street_name.to_s
print "\nAvs Zipcode = " + response.receipt.resolvedata[0].avs_zipcode.to_s
